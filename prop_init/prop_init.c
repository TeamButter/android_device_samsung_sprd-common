/*
 * Copyright (C) 2016 CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
 
/*
	prop_init: It sets various device specific properties on init
 	Properties supported:
		   	     Automatic model number detection: Determines model number from examining baseband variant.
		   	     SIM Mode: Based on SIM num, it will set dual SIM property accordingly
*/ 

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#include <cutils/log.h>
#include <cutils/properties.h>

#define LOG_TAG		"prop_init"

/* props */
#define SIM_NUM_PROP	"ril.sim2.present"
#define BASEBAND_PROP	"gsm.version.baseband"

#define MODEL_PROP	"ro.product.model"
#define DUAL_SIM_PROP	"persist.radio.multisim.config"

#define MAX_RETRY_COUNT	8
#define SLEEP		2000	//2 secs?

/* We assume the device is dual SIM by default, as we had done in device tree*/
int is_dual_sim = 1; 

/* Function to determine model number by analysing baseband and set model number accordingly. Type is void* to comply with pthread for multithreading. */
void* detect_model_number() {
	char prop_buf[PROPERTY_VALUE_MAX];
	size_t count = 0;
	while(1) {
		property_get(BASEBAND_PROP,prop_buf,NULL);
		if(prop_buf[0] == NULL) {
			count++;
			if(count < MAX_RETRY_COUNT) 
				continue;
		}
		if(!strncmp(prop_buf,"S5280",5)) {
			ALOGI("Setting property %s to GT-S280",MODEL_PROP);
			property_set(MODEL_PROP,"GT-S5280");
			is_dual_sim = 0;
		}
		if(!strncmp(prop_buf,"S5282",5)) {
			ALOGI("Setting property %s to GT-S282",MODEL_PROP);
			property_set(MODEL_PROP,"GT-S5282");
		}
		break;
	}
	return NULL;
}

/* Function to determine SIM number, and set props accordingly*/
void* detect_sim_number() {
	char prop_buf[PROPERTY_VALUE_MAX];
	size_t count = 0;
	while(1) {
		property_get(SIM_NUM_PROP,prop_buf,NULL);
		if(prop_buf[0] == NULL) {
			if(count < MAX_RETRY_COUNT) {
				ALOGE("Could not get %s property. Retrying after 2secs!!",SIM_NUM_PROP);
				count++;
				usleep(SLEEP);
				continue;
			} else {
				ALOGI("Could not get %s property after %u tries. Assuming single mode!",SIM_NUM_PROP,count+1);
				property_set(DUAL_SIM_PROP,"none");
			}
		} else {
			if(atoi(prop_buf)) {
				ALOGI("Setting %s to dsds",DUAL_SIM_PROP);
				property_set(DUAL_SIM_PROP,"dsds");
			} else {
				ALOGI("Setting %s to none",DUAL_SIM_PROP);
				property_set(DUAL_SIM_PROP,"none");
			}
		}
		break;
	}
	return NULL;
}

void set_single_sim() {
	property_set(DUAL_SIM_PROP,"none");
}

int main(int argc,char* argv[]) {
	pthread_t mThread1;
	pthread_t mThread2;
	
	ALOGI("Detecting model number..");
	pthread_create(&mThread1,NULL,detect_model_number,NULL);
	pthread_join(mThread1,NULL);
	
	if(!is_dual_sim) {
		ALOGI("Single SIM model, switching to single SIM mode");
		set_single_sim();
		return 0;
	}
	/* At this point, the device is dual SIM for sure, but still we see the available number of SIMs and set property accordingly, to minimize confusion. */
	ALOGI("Detecting SIM number..");
	pthread_create(&mThread2,NULL,detect_sim_number,NULL);
	pthread_join(mThread2,NULL);
	
	return 0;
	
}

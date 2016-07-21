/*
 * Copyright (C) 2012 The CyanogenMod Project
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

package com.android.internal.telephony;

import static com.android.internal.telephony.RILConstants.*;

import android.content.Context;
import android.os.AsyncResult;
import android.os.Message;
import android.os.Parcel;
import android.os.SystemProperties;
import android.telephony.Rlog;
import android.telephony.PhoneNumberUtils;
import android.telephony.ModemActivityInfo;

import com.android.internal.telephony.uicc.SpnOverride;
import com.android.internal.telephony.RILConstants;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;

/**
 * Custom RIL to handle unique behavior of SPRD RIL
 *
 * {@hide}
 */
public class SamsungSPRDRIL extends RIL implements CommandsInterface {

    public SamsungSPRDRIL(Context context, int preferredNetworkType, int cdmaSubscription) {
        this(context, preferredNetworkType, cdmaSubscription, null);
    }

    public SamsungSPRDRIL(Context context, int preferredNetworkType,
            int cdmaSubscription, Integer instanceId) {
        super(context, preferredNetworkType, cdmaSubscription, instanceId);
    }

    @Override
    public void
    dial(String address, int clirMode, UUSInfo uusInfo, Message result) {
        RILRequest rr = RILRequest.obtain(RIL_REQUEST_DIAL, result);

        rr.mParcel.writeString(address);
        rr.mParcel.writeInt(clirMode);
        rr.mParcel.writeInt(0);     // CallDetails.call_type
        rr.mParcel.writeInt(1);     // CallDetails.call_domain
        rr.mParcel.writeString(""); // CallDetails.getCsvFromExtras

        if (uusInfo == null) {
            rr.mParcel.writeInt(0); // UUS information is absent
        } else {
            rr.mParcel.writeInt(1); // UUS information is present
            rr.mParcel.writeInt(uusInfo.getType());
            rr.mParcel.writeInt(uusInfo.getDcs());
            rr.mParcel.writeByteArray(uusInfo.getUserData());
        }

        if (RILJ_LOGD) riljLog(rr.serialString() + "> " + requestToString(rr.mRequest));

        send(rr);
    }

    @Override
    public void setUiccSubscription(int appIndex, boolean activate, Message result) {
        riljLog("setUiccSubscription " + appIndex + " " + activate);

        // Fake response (note: should be sent before mSubscriptionStatusRegistrants or
        // SubscriptionManager might not set the readiness correctly)
        AsyncResult.forMessage(result, 0, null);
        result.sendToTarget();

        // TODO: Actually turn off/on the radio (and don't fight with the ServiceStateTracker)
        if (mSubscriptionStatusRegistrants != null)
            mSubscriptionStatusRegistrants.notifyRegistrants(
                    new AsyncResult (null, new int[] { activate ? 1 : 0 }, null));
    }

    @Override
    public void setDataAllowed(boolean allowed, Message result) {
        int simId = mInstanceId == null ? 0 : mInstanceId;
        if (allowed) {
            riljLog("Setting data subscription to sim [" + simId + "]");
            invokeOemRilRequestRaw(new byte[] {0x9, 0x4}, result);
        } else {
            riljLog("Do nothing when turn-off data on sim [" + simId + "]");
            if (result != null) {
                AsyncResult.forMessage(result, 0, null);
                result.sendToTarget();
            }
        }
    }

    @Override
    public void getRadioCapability(Message response) {
        String rafString = mContext.getResources().getString(
            com.android.internal.R.string.config_radio_access_family);
        riljLog("getRadioCapability: returning static radio capability [" + rafString + "]");
        if (response != null) {
            Object ret = makeStaticRadioCapability();
            AsyncResult.forMessage(response, ret, null);
            response.sendToTarget();
        }
    }

    @Override
    protected RadioState getRadioStateFromInt(int stateInt) {
        RadioState state;
        switch (stateInt) {
        case 13: state = RadioState.RADIO_ON; break;
        default:
            state = super.getRadioStateFromInt(stateInt);
        }
        return state;
    }

    @Override
    protected Object responseFailCause(Parcel p) {
        int numInts = p.readInt();
        int response[] = new int[numInts];
        for (int i = 0 ; i < numInts ; i++)
            response[i] = p.readInt();
        LastCallFailCause failCause = new LastCallFailCause();
        failCause.causeCode = response[0];
        if (p.dataAvail() > 0)
            failCause.vendorCause = p.readString();
        return failCause;
    }

    @Override
    protected void notifyRegistrantsRilConnectionChanged(int rilVer) {
        super.notifyRegistrantsRilConnectionChanged(rilVer);
        if (rilVer != -1) {
            if (mInstanceId != null) {
                riljLog("Enable simultaneous data/voice on Multi-SIM");
                invokeOemRilRequestSprd((byte) 3, (byte) 1, null);
            } else {
                riljLog("Set data subscription to allow data in either SIM slot when using single SIM mode");
                setDataAllowed(true, null);
            }
        }
    }

    protected void invokeOemRilRequestSprd(byte key, byte value, Message response) {
        invokeOemRilRequestRaw(new byte[] { 'S', 'P', 'R', 'D', key, value }, response);
    }
}

#!/bin/bash

set -e 

# call with path to kernel dir
# should be called from cloned dir

[[ -z ${1-} ]] && echo "no dir specified" && exit 

pushd ./ump &> /dev/null || exit -1
   KDIR="$1"  CONFIG=sc8810 BUILD=release make SVN_REV=0
popd &> /dev/null


pushd ./mali &> /dev/null || exit -1
  KDIR="$1" CONFIG=sc8810 TARGET_PLATFORM=sc8810 BUILD=release make SVN_REV=0 UMP_SYMVERS_FILE=../ump/Module.symvers
oopd &> /dev/null
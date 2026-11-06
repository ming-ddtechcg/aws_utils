#!/bin/sh

OPTIONS=""

#
# starts from here
#

PROFILE_NAME="$1"
REGION="$2"

if [ "${PROFILE_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the profile name, abort"
    echo ""
 
    exit 1
fi

aws configure --profile ${PROFILE_NAME}
STATUS=$?

exit ${STATUS}


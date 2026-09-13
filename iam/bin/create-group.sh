#!/bin/sh

OPTIONS=""



#
# starts from here
#

GROUP_NAME="$1"
REGION="$2"

if [ "${GROUP_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the group name, abort"
    echo ""
 
    exit 1
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

aws iam create-group \
    --group-name ${GROUP_NAME} \
    ${OPTIONS}
STATUS=$?

exit ${STATUS}


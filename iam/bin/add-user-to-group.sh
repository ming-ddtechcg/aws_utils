#!/bin/sh

OPTIONS=""



#
# starts from here
#

USER_NAME="$1"
GROUP_NAME="$2"
REGION="$3"

if [ "${USER_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the user name, abort"
    echo ""
 
    exit 1
fi

if [ "${GROUP_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the group name, abort"
    echo ""
 
    exit 2
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

aws iam add-user-to-group \
    --user-name ${USER_NAME} \
    --group-name ${GROUP_NAME} \
    ${OPTIONS}
STATUS=$?

exit ${STATUS}


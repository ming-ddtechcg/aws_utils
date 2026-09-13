#!/bin/sh

OPTIONS=""

#
# starts from here
#

USER_NAME="$1"
REGION="$2"

if [ "${USER_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the user name, abort"
    echo ""
 
    exit 1
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

aws iam create-user \
    --user-name ${USER_NAME} \
    ${OPTIONS}
STATUS=$?

exit ${STATUS}


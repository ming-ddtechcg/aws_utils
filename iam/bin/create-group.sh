#!/bin/sh

#
# starts from here
#

GROUP_NAME="$1"

if [ "${GROUP_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the group name, abort"
    echo ""
 
    exit 1
fi

aws iam create-group \
    --group-name ${GROUP_NAME}
STATUS=$?

exit ${STATUS}


#!/bin/sh

OPTIONS=""



#
# starts from here
#

AMI_ID="$1"
REGION="$2"

if [ "${AMI_ID}" = "" ]
then
    echo ""
    echo "ERROR: missing the AMI id, abort"
    echo ""

    exit 1
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

aws ec2 describe-images \
    --image-ids ${AMI_ID} \
    ${OPTIONS}
STATUS=$?

exit ${STATUS}


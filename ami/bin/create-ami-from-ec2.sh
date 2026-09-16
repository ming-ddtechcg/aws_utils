#!/bin/sh

OPTIONS=""



#
# starts from here
#

INSTANCE_ID="$1"
NAME="$2"
REGION="$3"
DESCRIPTION="$4"

if [ "${INSTANCE_ID}" = "" ]
then
    echo ""
    echo "ERROR: missing the EC2 instance id, abort"
    echo ""

    exit 1
fi

if [ "${NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the AMI name, abort"
    echo ""
 
    exit 2
fi

if [ "${DESCRIPTION}" != "" ]
then
    OPTIONS="${OPTIONS} --description \"${DESCRIPTION}\""
fi

aws ec2 create-image \
  --instance-id ${INSTANCE_ID} \
  --name "${NAME}" \
  --region ${REGION} \
  ${OPTIONS}
STATUS=$?

exit ${STATUS}


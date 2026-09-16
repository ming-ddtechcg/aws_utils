#!/bin/sh

OPTIONS=""



#
# starts from here
#

SOURCE_AMI_ID="$1"
SOURCE_REGION="$2"
REGION="$3"
NAME="$4"
DESCRIPTION="$5"

if [ "${SOURCE_AMI_ID}" = "" ]
then
    echo ""
    echo "ERROR: missing the source AMI id, abort"
    echo ""

    exit 1
fi

if [ "${SOURCE_REGION}" = "" ]
then
    echo ""
    echo "ERROR: missing the source AMI region, abort"
    echo ""
 
    exit 2
fi

if [ "${REGION}" = "" ]
then
    echo ""
    echo "ERROR: missing the region, abort"
    echo ""
 
    exit 3
fi

if [ "${NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the new AMI name, abort"
    echo ""
 
    exit 4
fi

if [ "${DESCRIPTION}" != "" ]
then
    OPTIONS="${OPTIONS} --description ${DESCRIPTION}"
fi

aws ec2 copy-image \
  --source-image-id ${SOURCE_AMI_ID} \
  --source-region ${SOURCE_REGION} \
  --region ${REGION} \
  --name "${NAME}" \
  ${OPTIONS}
STATUS=$?

exit ${STATUS}


#!/bin/sh


#
# starts from here
#

POLICY_ARN="$1"

if [ "${POLICY_ARN}" = "" ]
then
    echo ""
    echo "ERROR: missing the  policy arn, abort"
    echo ""

    exit 1
fi


aws iam delete-policy \
  --policy-arn ${POLICY_ARN} \
STATUS=$?

exit ${STATUS}


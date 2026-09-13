#!/bin/sh


#
# starts from here
#

GROUP_NAME="$1"
POLICY_ARN="$2"

if [ "${GROUP_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the group name, abort"
    echo ""

    exit 1
fi

if [ "${POLICY_ARN}" = "" ]
then
    echo ""
    echo "ERROR: missing the policy arn, abort"
    echo ""

    exit 2
fi

aws iam detach-group-policy \
  --group-name ${POLICY_NAME} \
  --policy-arn ${POLICY_ARN}
STATUS=$?

exit ${STATUS}


#!/bin/sh


#
# starts from here
#

POLICY_NAME="$1"
POLICY_FILE="$2"

if [ "${POLICY_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the policy name, abort"
    echo ""

    exit 1
fi

if [ ! -s "${POLICY_FILE}" ]
then
    echo ""
    echo "ERROR: an issue about the policy file, abort"
    echo ""

    exit 2
fi

aws iam create-policy \
  --policy-name ${POLICY_NAME} \
  --policy-document file://${POLICY_FILE}
STATUS=$?

exit ${STATUS}


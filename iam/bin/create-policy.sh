#!/bin/sh

OPTIONS=""
TMP_JSON_FILE="/tmp/$$_json"



#
# cleans up the temproary JSON file
#
cleanupTmpFile()
{
    rm -f ${TMP_JSON_FILE} > /dev/null 2>&1
}



#
# starts from here
#

POLICY_NAME="$1"
POLICY_JSON_FILE="$2"
RESOURCE_ARN="$3"
REGION="$4"

if [ ! -s "${POLICY_JSON_FILE}" ]
then
    echo ""
    echo "ERROR: unable to access th policy JSON file, abort"
    echo ""

    exit 1
fi

if [ "${RESOURCE_ARN}" = "" ]
then
    echo ""
    echo "ERROR: missing the resource arn, abort"
    echo ""

    exit 2
fi

grep -v '^#' ${POLICY_JSON_FILE} \
    > ${TMP_JSON_FILE}
     

cat ${TMP_JSON_FILE} \
    | jq -r '. | .Statement[0].Resource="'"${RESOURCE_ARN}"'"' \
    > ${TMP_JSON_FILE}.1

mv ${TMP_JSON_FILE}.1 ${TMP_JSON_FILE} \
    > /dev/null 2>&1

if [ ! -s "${TMP_JSON_FILE}" ]
then
    cleanupTmpFile

    echo ""
    echo "ERROR: unable to process the policy JSON file, abort"
    echo ""
  
    exit 3
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

aws iam create-policy \
    --policy-name ${POLICY_NAME} \
    --policy-document file://${TMP_JSON_FILE} \
    ${REGION}
STATUS=$?

cleanupTmpFile

exit ${STATUS}


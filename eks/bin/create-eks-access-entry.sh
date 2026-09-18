#!/bin/sh

OPTIONS=""



#
# starts from here
#

CLUSTER_NAME="$1"
USER_NAME="$2"
TYPE="$3"
REGION="$4"

if [ "${CLUSTER_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the cluster name, abort"
    echo ""
 
    exit 1
fi

if [ "${USER_NAME}" = "" ]
then
    echo ""
    echo "ERROR: missing the user name, abort"
    echo ""
 
    exit 2
fi

if [ "${TYPE}" = "" ]
then
    echo ""
    echo "ERROR: missing the type, abort"
    echo ""
 
    exit 3
fi

if [ "${REGION}" != "" ]
then
    OPTIONS="${OPTIONS} --region ${REGION}"
fi

USER_PRINCIPAL_ARN=`aws iam get-user \
    --user-name ${USER_NAME} \
    ${OPTIONS} 2> /dev/null \
    | jq '. | select( .User != null ) | .User.Arn' | xargs`

if [ "${USER_PRINCIPAL_ARN}" = "" ]
then
    echo ""
    echo "ERROR: unable to retrieve the user proncipal arn, abort"
    echo ""

    exit 4
fi

aws eks create-access-entry \
    --cluster-name ${CLUSTER_NAME} \
    --principal-arn ${USER_PRINCIPAL_ARN} \
    --type ${TYPE} \
    ${OPTIONS}
STATUS=$?

exit ${STATUS}


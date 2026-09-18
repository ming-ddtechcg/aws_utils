#!/bin/sh

OPTIONS=""



#
# starts from here
#
# ACCESS_SCOPE can be in:
#   type=cluster
#   type=namespace,namespaces=<namespace_name>
#

CLUSTER_NAME="$1"
USER_NAME="$2"
POLICY_ARN="$3"
ACCESS_SCOPE="$4"
REGION="$5"

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

if [ "${POLICY_ARN}" = "" ]
then
    echo ""
    echo "ERROR: missing the policy arn, abort"
    echo ""
 
    exit 3
fi

if [ "${ACCESS_SCOPE}" = "" ]
then
    echo ""
    echo "ERROR: missing the access scope, abort"
    echo ""
 
    exit 4
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

aws eks associate-access-policy \
    --cluster-name ${CLUSTER_NAME} \
    --principal-arn ${USER_PRINCIPAL_ARN} \
    --access-scope ${ACCESS_SCOPE} \
    --policy-arn ${POLICY_ARN} \
    ${OPTIONS}

exit ${STATUS}


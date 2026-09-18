#!/bin/sh

OPTIONS=""



#
# starts from here
#

aws eks list-access-policies
STATUS=$?

exit ${STATUS}


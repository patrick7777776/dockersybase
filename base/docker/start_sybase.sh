#!/bin/bash
source /opt/sybase/SYBASE.sh

${SYBASE}/${SYBASE_ASE}/install/RUN_TESTSYBASE
RET=$?

exit ${RET}

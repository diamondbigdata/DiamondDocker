#!/bin/bash
/usr/bin/confd -onetime -backend rancher -prefix /2015-12-19
sleep 1
/usr/bin/confd -onetime -backend rancher -prefix /2015-12-19
sleep 1
if [[ $USE_UBUNTU_LOCAL_REPO -eq 'true' ]]; then
sed  's/localreg/'$UBUNTU_REPO_HOST_NAME'/g' /sources/sources.list.local.mdl > /sources/sources.list.local && /sources/source-change-to-local
fi

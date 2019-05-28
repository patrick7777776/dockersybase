#!/bin/bash

source /opt/sybase/SYBASE.sh 

srvbuildres -r /install/sybase-ase.rs

cp /install/interfaces /opt/sybase/

sleep 60

isql -Usa -Psa_pass -STESTSYBASE -i /install/create_dbs 


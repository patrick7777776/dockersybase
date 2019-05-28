#!/bin/bash

source /opt/sybase/SYBASE.sh 

sleep 60

isql -Usa -Psa_pass -STESTSYBASE -i /create_tables/create_tables


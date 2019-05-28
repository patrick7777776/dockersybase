#!/bin/bash

# fresh slate
rm sybase_empty.tgz
rm fresh.cid
rm ct.cid
rm -rf sybase_data
mkdir sybase_data

# run base image docker build
cd base
docker build . -t sybase:base 

# run base image with sybase mounted, execute build.sh; take note of container id
cd ..
docker run --cidfile fresh.cid -v $(pwd)/sybase_data:/var/sybase sybase:base build.sh

# commit container to image (via container id)
container_id=$(<fresh.cid)
docker commit $container_id sybase:empty

# tar up sybase data -> sybase.empty.tgz -- so you can later restore an empty state
tar cvfz sybase_empty.tgz sybase_data
mv sybase_empty.tgz sybase_data_archives

cd fresh
docker build . -t sybase:fresh
cd ..

# now create the required tables -- these may change from time to time so we do it last
docker run -d --cidfile ct.cid -v $(pwd)/sybase_data:/var/sybase -v $(pwd)/create_tables:/create_tables sybase:fresh
container_id=$(<ct.cid)
docker exec $container_id bash -c 'chmod +x /create_tables/create_tables.sh ; /create_tables/create_tables.sh'
docker stop $container_id

# and archive them for easy reuse
tar cvfz sybase_empty_tables.tgz sybase_data
mv sybase_empty_tables.tgz sybase_data_archives


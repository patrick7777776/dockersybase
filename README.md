Building Sybase image(s)
------------------------

A sketch of how one might Dockerize Sybase.

### Preparation - Obtain Sybase installation archive

First, you need to obtain the Sybase installation archive and put it into a directory called installation_archive:

    mkdir base/installation_archive

    cd base/installation_archive
	 
    curl -OLS http://d1cuw2q49dpd0p.cloudfront.net/ASE16/Linux16SP03/ASE_Suite.linuxamd64.tgz

    cd ../..

The installation_archive directory is not under version control. You must ensure that you have an appropriate licence for your use case.

### Build

The bash script build_images.sh executes the build process. Both the Sybase installation and the database creation take rather long periods of time. The script needs to be executed only once. (However, should you change the database/table definitions in base/docker/createXXX, you will have to re-run the script.)

    ./build_images.sh

When the script has finished successfully, you will have:

  * a Docker image tagged sybase:fresh
  * an empty DB in sybase_data 
  * an archive of the above in sybase_data_archives/sybase_emtpy.tgz

Running Sybase
--------------


### Assumptions:

   * you have extracted sybase_empty to a convenient directory /my/sybase_data
   * if you have a set of .csv files exported from another db, you have put them into a convenient directory /my/import

### Start with bind-mounts

    docker run -d --name sybase --network endtoend -p 5000:5000 -v /my/sybase_data:/var/sybase -v /my/import:/import sybase:fresh    

Once Sybase has started up (check via docker logs -f sybase_container_id), you can use a tool like DBeaver to connect:

    host: localhost
    port: 5000
    user: user1
    pass: pass123

### Import data

If you wish to import data from .csv files, execute the following command:

    docker exec sybase_container_id bash import.sh

As a precaution, the import csv files will be truncated to 1000 rows.

If you can't build
------------------

Ask somebody who can build to export sybase:fresh via:

    docker save sybase:fresh -o sybase_fresh.tgz

Once in possession of sybase_fresh.tgz, you can import it via:

    docker load -i sybase_fresh.tgz


Resources
---------

Some helpful resources:

  * https://www.petersap.nl/SybaseWiki/index.php?title=Main_Page
  * https://help.sap.com/doc/648ebc82a39147e88c7501740b053190/16.0.1.0/en-US/SAP_ASE_Installation_Guide_Linux_en.pdf
  * https://github.com/nguoianphu/docker-sybase


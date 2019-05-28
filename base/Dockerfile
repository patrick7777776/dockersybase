FROM debian:stretch

RUN mkdir -p /var/sybase/TESTSYBASE

ADD installation_archive/ASE_Suite.linuxamd64.tgz /install/ASE
COPY docker/response.txt /install
COPY docker/sybase-ase.rs /install
COPY docker/interfaces /install
COPY docker/create_dbs /install
COPY docker/start_sybase.sh /usr/local/bin
COPY docker/build.sh /usr/local/bin
COPY docker/import.sh /usr/local/bin

RUN chmod +x /usr/local/bin/start_sybase.sh
RUN chmod +x /usr/local/bin/build.sh
RUN chmod +x /usr/local/bin/import.sh

RUN apt-get update && apt-get -y install libaio1 zip procps

RUN /install/ASE/setup.bin -f /install/response.txt -i silent -DAGREE_TO_SAP_LICENSE=true -DRUN_SILENT=true


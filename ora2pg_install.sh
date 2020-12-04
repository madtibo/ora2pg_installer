#!/bin/bash

PGVERSION=${1:9.6}

wget https://dali.bo/ora2pg_installer
tar xzf ora2pg_installer.tgz
cd ora2pg_installer

yum install -y epel-release
yum install -y centos-release-scl
yum install -y unzip time libaio rlwrap \
		           perl perl-core perl-devel perl-DBI perl-Test-Simple \
               postgresql${PGVERSION/\./}-devel postgresql${PGVERSION/\./}-contrib

yum groupinstall -y 'Development Tools'

rpm -ivh oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
rpm -ivh oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
rpm -ivh oracle-instantclient12.2-jdbc-12.2.0.1.0-1.x86_64.rpm
rpm -ivh oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

tar xzf DBD-Oracle-1.80.tgz
cd DBD-Oracle-1.80-qMw7qi
export LD_LIBRARY_PATH=/usr/lib/oracle/12.2/client64/lib
export ORACLE_HOME=/usr/lib/oracle/12.2/client64/lib
perl Makefile.PL
make
make install

cd ..
tar xzf DBD-Pg-3.10.0.tgz
cd DBD-Pg-3.10.0-8bO_EQ
export POSTGRES_HOME=/usr/pgsql-${PGVERSION}/bin
export POSTGRES_INCLUDE=/usr/pgsql-${PGVERSION}/include/
export POSTGRES_LIB=/usr/pgsql-${PGVERSION}/lib/
perl Makefile.PL
make
make install

cd ..
unzip ora2pg-dlb_migration.zip
cd ora2pg-dlb_migration
perl Makefile.PL
make
make install

cd..

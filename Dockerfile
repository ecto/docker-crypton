
from ubuntu:12.04
maintainer Cam Pedersen <cam@spideroak.com>

# housekeeping
run apt-get update -y
run DEBIAN_FRONTEND=noninteractive apt-get -y install language-pack-en

env LANGUAGE en_US.UTF-8
env LANG en_US.UTF-8
env LC_ALL en_US.UTF-8
env DEBIAN_FRONTEND noninteractive

run locale-gen en_US.UTF-8
run dpkg-reconfigure locales
run update-locale LANG=en_US.UTF-8

# compilation dependencies
run apt-get install -y git wget make gcc g++

# install redis
run wget http://download.redis.io/releases/redis-2.8.8.tar.gz
run tar xzf redis-2.8.8.tar.gz
run rm redis-2.8.8.tar.gz
run cd redis-2.8.8 && make && make install

# install node
run wget http://nodejs.org/dist/v0.10.26/node-v0.10.26.tar.gz
run tar xzf node-v0.10.26.tar.gz
run rm node-v0.10.26.tar.gz
run cd node-v0.10.26 && ./configure && make && make install

# install postgres
run apt-get install -y postgresql-9.1 postgresql-client-9.1 postgresql-contrib-9.1

#user postgres
run echo "host all  all    0.0.0.0/0  trust" >> /etc/postgresql/9.1/main/pg_hba.conf
run echo "listen_addresses='*'" >> /etc/postgresql/9.1/main/postgresql.conf
run echo "local   all             all                                     trust" >> /etc/postgresql/9.1/main/pg_hba.conf
run echo "host    all             all             127.0.0.1/32            trust" >> /etc/postgresql/9.1/main/pg_hba.conf
run echo "host    all             all             ::1/128            trust" >> /etc/postgresql/9.1/main/pg_hba.conf

# get crypton
run git clone https://github.com/SpiderOak/crypton.git

# phantomjs dependencies
run apt-get install -y bzip2 curl libfreetype6 libfontconfig1

# link crypton server
run cd crypton/server && npm link

# expose only the crypton port
expose 443

# oracle-xe-11.2.0-1.0.x86_64
[Vagrant] Oracle Database 11g XE

1. [Download Vagrant](https://www.vagrantup.com)
2. [Download Oracle Database Express Edition 11g Release 2](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)
3. `cp ~/Downloads/oracle-xe-11.2.0-1.0.x86_64.rpm.zip $ROOT/modules/oracle/files/oracle-xe-11.2.0-1.0.x86_64.rpm.zip`
4. `vagrant up`

[Docker] Oracle Database 11g XE
1. [Download Docker Toolbox](https://www.docker.com/products/docker-toolbox)
2. [Download Oracle Database Express Edition 11g Release 2](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)
3. `cp ~/Downloads/oracle-xe-11.2.0-1.0.x86_64.rpm.zip $ROOT/modules/oracle/files/oracle-xe-11.2.0-1.0.x86_64.rpm.zip`
4. `ln -s $ROOT/modules/oracle/files/oracle-xe-11.2.0-1.0.x86_64.rpm.zip oracle-xe-11.2.0-1.0.x86_64.rpm.zip`
5. `docker-machine start`
6. `eval "$(docker-machine env default)"`
7. `docker build -t oracle-xe:11.2.0.1.0 --shm-size=2g .`
8. `docker run -i -P --name=oracle-xe_11.2.0.1.0 --shm-size=2g -t oracle-xe:11.2.0.1.0`

Default SYSTEM Password: "password"

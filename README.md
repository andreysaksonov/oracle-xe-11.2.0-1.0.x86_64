# vagrant_oracle-xe-11.2.0
[Vagrant] Oracle Database Express Edition 11g Release 2

1. [Download & Install Vagrant](https://www.vagrantup.com)
2. `vagrant plugin install vagrant-vbguest`
3. [Download Oracle Database Express Edition 11g Release 2](http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html)
4. `cp ~/Downloads/oracle-xe-11.2.0-1.0.x86_64.rpm.zip ./modules/oracle-xe/files/oracle-xe-11.2.0-1.0.x86_64.rpm.zip`
5. `vagrant up`
6. `cat ./modules/oracle-xe/files/oracle-xe.rsp`

#### Authors
* [Andrey Saksonov](https://saksonov.me)

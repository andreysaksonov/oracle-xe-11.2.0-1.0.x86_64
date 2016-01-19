class oracle::server {

  exec {
    "/usr/bin/apt-get -y update":
      logoutput => true,
      timeout => 3600;
  }

  package {
    "language-pack-ru": ensure => installed;
    "ntp": ensure => installed;
    "htop": ensure => installed;
    "unzip": ensure => installed;
    "monit": ensure => installed;
    "rsyslog": ensure => installed;
    "curl": ensure => installed;
    "alien": ensure => installed;
    "libaio1": ensure => installed;
    "unixodbc": ensure => installed;
    "git": ensure => installed;
  }

  service {
    "ntp": ensure => stopped;
    "monit": ensure => running;
    "rsyslog": ensure => running;
    "procps": ensure => running;
  }

  file {
    "/etc/sysctl.d/60-oracle.conf": source => "puppet:///modules/oracle/sysctl-oracle_xe.conf";
    "/etc/profile.d/oracle.sh": source => "puppet:///modules/oracle/oracle.sh";
  }

  user {
    "syslog":
      ensure => present,
      groups => ["syslog", "adm"];
  }
  
  group {
    "puppet":
      ensure => present;
  }
}

class oracle::xe {
  file {
    "/tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip": source => "puppet:///modules/oracle/oracle-xe-11.2.0-1.0.x86_64.rpm.zip";
    "/tmp/xe.rsp": source => "puppet:///modules/oracle/xe.rsp";
    "/etc/init.d/oracle-shm":
      mode => 0755,
      source => "puppet:///modules/oracle/oracle-shm";
    "/bin/awk":
      ensure => link,
      target => "/usr/bin/awk";
    "/var/lock/subsys": ensure => directory;
  }

  exec {
    "unzip xe":
      command => "/usr/bin/unzip -o /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip",
      require => [Package["unzip"], File["/tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip"]],
      cwd => "/tmp",
      user => root,
      creates => "/tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm";
    "alien xe":
      command => "/usr/bin/alien --veryverbose --to-deb --scripts /tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm",
      require => Exec["unzip xe"],
      cwd => "/tmp",
      user => root,
      logoutput => true,
      creates => "/tmp/oracle-xe_11.2.0-2_amd64.deb",
      timeout => 3600;
    "configure xe":
      command => "/etc/init.d/oracle-xe configure responseFile=/tmp/xe.rsp >> /tmp/xe-install.log",
      require => [Package["oracle-xe"], Exec["update-rc oracle-shm"]],
      user => root;
    "update-rc oracle-shm":
      command => "/usr/sbin/update-rc.d oracle-shm defaults 01 99",
      require => File["/etc/init.d/oracle-shm"],
      cwd => "/etc/init.d",
      user => root;
    "oracle-shm":
      command => "/etc/init.d/oracle-shm start",
      require => File["/etc/init.d/oracle-shm"],
      user => root;
    "update-rc oracle-xe":
      command => "/usr/sbin/update-rc.d oracle-xe defaults",
      require => [Package["oracle-xe"], Exec["configure xe"]],
      cwd => "/etc/init.d",
      user => root;
  }

  package {
    "oracle-xe":
      provider => "dpkg",
      ensure => latest,
      require => Exec["alien xe"],
      source => "/tmp/oracle-xe_11.2.0-2_amd64.deb";
  }
}

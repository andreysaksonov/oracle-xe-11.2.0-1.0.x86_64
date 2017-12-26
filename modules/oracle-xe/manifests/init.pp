class oracle-xe::default {

  file {
    "/bin/awk": ensure => link, target => "/usr/bin/awk";
    "/var/lock/subsys": ensure => directory;
  }

  file {
    "/etc/sysctl.d/60-oracle-xe.conf": source => "puppet:///modules/oracle-xe/sysctl_oracle-xe.conf";
    "/etc/profile.d/oracle_env.sh": source => "puppet:///modules/oracle-xe/profile_oracle_env.sh";
  }

  file {
    "/etc/init.d/oracle-xe-shm": mode => 0755, source => "puppet:///modules/oracle-xe/oracle-xe-shm";
  }

  file {
    "/tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip": source => "puppet:///modules/oracle-xe/oracle-xe-11.2.0-1.0.x86_64.rpm.zip";
    "/tmp/oracle-xe.rsp": source => "puppet:///modules/oracle-xe/oracle-xe.rsp";
  }

  exec {
    "update-rc oracle-xe-shm":
      command => "/usr/sbin/update-rc.d oracle-xe-shm defaults 01 99",
      require => File["/etc/init.d/oracle-xe-shm"],
      cwd => "/etc/init.d",
      user => root;
    "start oracle-xe-shm":
      command => "/etc/init.d/oracle-xe-shm start",
      require => [File["/etc/init.d/oracle-xe-shm"], Exec["update-rc oracle-xe-shm"]],
      user => root;

    "unzip oracle-xe":
      command => "/usr/bin/unzip -o /tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip",
      require => [Package["unzip"], File["/tmp/oracle-xe-11.2.0-1.0.x86_64.rpm.zip"]],
      cwd => "/tmp",
      user => root,
      creates => "/tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm";
    "alien oracle-xe":
      command => "/usr/bin/alien --to-deb --scripts /tmp/Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm",
      require => Exec["unzip oracle-xe"],
      cwd => "/tmp",
      user => root,
      logoutput => true,
      creates => "/tmp/oracle-xe_11.2.0-2_amd64.deb",
      timeout => 3600;

    "configure oracle-xe":
      command => "/etc/init.d/oracle-xe configure responseFile=/tmp/oracle-xe.rsp >> /tmp/oracle-xe_install.log",
      require => [Package["oracle-xe"], Exec["start oracle-xe-shm"]],
      user => root;
    "update-rc oracle-xe":
      command => "/usr/sbin/update-rc.d oracle-xe defaults",
      require => [Package["oracle-xe"], Exec["configure oracle-xe"]],
      cwd => "/etc/init.d",
      user => root;
  }

  package {
    "oracle-xe":
      provider => "dpkg",
      ensure => latest,
      require => Exec["alien oracle-xe"],
      source => "/tmp/oracle-xe_11.2.0-2_amd64.deb";
  }
}

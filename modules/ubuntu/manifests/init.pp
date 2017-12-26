class ubuntu::default {

  exec {
    apt_update:
      command => "/usr/bin/apt-get -y update",
      logoutput => true,
      timeout => 3600;
  }

  package {
    "language-pack-ru": ensure => installed, require => Exec[apt_update];
    "ntp": ensure => installed, require => Exec[apt_update];
    "monit": ensure => installed, require => Exec[apt_update];
    "rsyslog": ensure => installed, require => Exec[apt_update];
    "alien": ensure => installed, require => Exec[apt_update];
    "unzip": ensure => installed, require => Exec[apt_update];
    "libaio1": ensure => installed, require => Exec[apt_update];
    "unixodbc": ensure => installed, require => Exec[apt_update];
  }

  service {
    "ntp": ensure => stopped;
    "monit": ensure => running;
    "rsyslog": ensure => running;
    "procps": ensure => running;
  }

  user {
    "syslog": ensure => present, groups => ["syslog", "adm"];
  }
  
  group {
    "puppet": ensure => present;
  }
}

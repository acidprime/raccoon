# == Class: racoon
#
# Full description of class racoon here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { racoon:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2011 Your name here, unless otherwise noted.
#
class racoon(
  $psk,
  $wan_ip,
  $first_ip,
  $number_ips,
  $dns_server,
  $wins_server,
){

  file { '/etc/racoon/motd':
    ensure  => file,
    content => template("${module_name}/motd.erb"),
  }

  file { '/etc/racoon':
    ensure => directory,
  }

  file { '/etc/racoon/setkey.conf':
    ensure  => file,
    content => template("${module_name}/setkey.conf.erb"),
    mode    => '755',
  }

  file { '/etc/setkey.conf':
    ensure  => file,
    content => template("${module_name}/setkey.conf.erb"),
    mode    => '755',
  }

  file {'/etc/racoon/racoon.conf':
    ensure  => file,
    mode    => 600,
    content => template("${module_name}/racoon.conf.erb"),
  }

  file { '/etc/racoon/psk.txt':
    ensure  => file,
    mode    => '600',
    content => template("${module_name}/psk.txt.erb"),
  }
  service { 'racoon':
    ensure    => running,
    enable    => true,
    subscribe => [ File['/etc/racoon/racoon.conf'],File['/etc/racoon/psk.txt'] ],
  }

}

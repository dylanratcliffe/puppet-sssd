# == Class: sssd::config
#
# Configuration of the System Security Services Daemon (SSSD)
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
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'sssd::config':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Simon Lauger <simon.lauger@teamix.de
#
# === Copyright
#
# Copyright 2016 teamix GmbH
#
class sssd::config {
  case $::osfamily {
    'RedHat': {
      file { '/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/${module_name}/etc/oddjobd.conf.d/oddjobd-mkhomedir.conf",
        notify => Service['oddjobd'],
      }
    }
  }

  file { '/etc/sssd':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0700',
  }

  concat { '/etc/sssd/sssd.conf':
    target  => '/etc/sssd/sssd.conf',
    content => template($sssd::default_template),
    order   => '10',
    notify  => Service['sssd'],
  }
}

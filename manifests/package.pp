# == Class: sssd::package
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
#  class { 'sssd::package':
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
class sssd::package {
  case $::osfamily {
    'RedHat': {
      package { [ 'authconfig', 'openldap-clients' ]:
        ensure => present,
      }->
      package { 'oddjob-mkhomedir':
        ensure => present,
      }->
      package { [ 'sssd-client', 'sssd-tools']:
        ensure => present,
      }
    }
    'Suse': {
      package { ['sssd', 'sssd-tools']: 
        ensure => present,
      }
    }
  }
}

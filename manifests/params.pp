# == Class: sssd::params
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
#  class { 'sssd::params':
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
class sssd::params {
  $service_ensure                         = 'running'
  $service_enable                         = true
  $domains                                = 'default'
  $default_domain_suffix                  = ''
  $debug_level                            = '4'

  $authconfig                             = false
  $create_default_domain                  = false

  $default_domain                         = 'default'
  $default_template                       = "${module_name}/etc/sssd/sssd.conf.erb"
  $default_domain_template                = "${module_name}/etc/sssd/domain-ad.erb"

  $default_id_provider                    = 'ldap'
  $default_auth_provider                  = 'ldap'
  $default_chpass_provider                = 'ldap'
  $default_autofs_provider                = 'none'
  $default_netgroup_provider              = 'none'
  $default_sudo_provider                  = 'none'
  $default_selinux_provider               = 'none'
  $default_subdomains_provider            = 'none'
  $default_hostid_provider                = 'none'

  $default_override_shell                 = '/bin/bash'
  $default_override_homedir               = '/home/%u'
  $default_override_gid                   = '100'
  $default_default_gid                    = '100'
  $default_create_homedir                 = 'true'
  $default_remove_homedir                 = 'true'
  $default_homedir_umask                  = '077'
  $default_skel_dir                       = '/etc/skel'
  $default_re_expression                  = '(((?P<domain>[^\\]+)\\(?P<name>.+$))|((?P<name>[^@]+)@(?P<domain>.+$))|(^(?P<name>[^@\\]+)$))'
  $default_full_name_format               = '%1$s'
  $default_ldap_uri                       = ''
  $default_ldap_search_base               = ''
  $default_ldap_default_bind_dn           = ''
  $default_ldap_default_authtok           = ''
  $default_ldap_schema                    = 'ad'
  $default_ldap_user_object_class         = 'user'
  $default_ldap_user_search_base          = ''
  $default_ldap_group_object_class        = 'group'
  $default_ldap_group_search_base         = ''
  $default_ldap_account_expire_policy     = 'ad'
  $default_ldap_force_upper_case_realm    = 'false'
  $default_ldap_id_mapping                = 'true'
  $default_access_provider                = 'simple'
  $default_simple_allow_users             = [ 'root' ]
  $default_simple_allow_groups            = [ 'root', 'users' ]
  $default_ldap_tls_reqcert               = 'demand'
  $default_ldap_tls_cacert                = ''
  $default_ldap_id_use_start_tls          = 'false'
  $default_enumerate                      = 'false'
  $default_cache_credentials              = 'true'
  $default_reconnection_retries           = '10'
  $default_offline_credentials_expiration = '0'
  $default_offline_failed_login_attempts  = '5'
  $default_offline_failed_login_delay     = '5'
}

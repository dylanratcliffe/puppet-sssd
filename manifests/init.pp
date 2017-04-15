# == Class: sssd
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
#  class { 'sssd':
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
class sssd (
  $service_ensure                         = $sssd::params::service_ensure,
  $service_enable                         = $sssd::params::service_enable,
  $domains                                = $sssd::params::domains,
  $default_domain_suffix                  = $sssd::params::default_domain,
  $debug_level                            = $sssd::params::debug_level,
  $authconfig                             = $sssd::parms::authconfig,

  $create_default_domain                  = $sssd::params::create_default_domain,

  $default_domain                         = $sssd::params::default_domain,
  $default_template                       = $sssd::params::default_template,
  $default_domain_template                = $sssd::params::default_domain_template,

  $default_id_provider                    = $sssd::params::default_id_provider,
  $default_auth_provider                  = $sssd::params::default_auth_provider,
  $default_chpass_provider                = $sssd::params::default_chpass_provider,
  $default_autofs_provider                = $sssd::params::default_autofs_provider,
  $default_netgroup_provider              = $sssd::params::default_netgroup_provider,
  $default_sudo_provider                  = $sssd::params::default_sudo_provider,
  $default_selinux_provider               = $sssd::params::default_selinux_provider,
  $default_subdomains_provider            = $sssd::params::default_subdomains_provider,
  $default_hostid_provider                = $sssd::params::default_hostid_provider,
  $default_override_shell                 = $sssd::params::default_override_shell,
  $default_override_homedir               = $sssd::params::default_override_homedir,
  $default_override_gid                   = $sssd::params::default_override_gid,
  $default_default_gid                    = $sssd::params::default_default_gid,
  $default_create_homedir                 = $sssd::params::default_create_homedir,
  $default_remove_homedir                 = $sssd::params::default_remove_homedir,
  $default_homedir_umask                  = $sssd::params::default_homedir_umask,
  $default_skel_dir                       = $sssd::params::default_skel_dir,
  $default_re_expression                  = $sssd::params::default_re_expression,
  $default_full_name_format               = $sssd::params::default_full_name_format,
  $default_ldap_uri                       = $sssd::params::default_full_name_format,
  $default_ldap_search_base               = $sssd::params::default_ldap_search_base,
  $default_ldap_default_bind_dn           = $sssd::params::default_ldap_default_bind_dn,
  $default_ldap_default_authtok           = $sssd::params::default_ldap_default_authtok,
  $default_ldap_schema                    = $sssd::params::default_ldap_schema,
  $default_ldap_user_object_class         = $sssd::params::default_ldap_user_object_class,
  $default_ldap_user_search_base          = $sssd::params::default_ldap_user_search_base,
  $default_ldap_group_object_class        = $sssd::params::default_ldap_group_object_class,
  $default_ldap_group_search_base         = $sssd::params::default_ldap_group_search_base,
  $default_ldap_account_expire_policy     = $sssd::params::default_ldap_account_expire_policy,
  $default_ldap_force_upper_case_realm    = $sssd::params::default_ldap_force_upper_case_realm,
  $default_ldap_id_mapping                = $sssd::params::default_ldap_id_mapping,
  $default_access_provider                = $sssd::params::default_access_provider,
  $default_simple_allow_users             = $sssd::params::default_simple_allow_users,
  $default_simple_allow_groups            = $sssd::params::default_simple_allow_groups,
  $default_ldap_tls_reqcert               = $sssd::params::default_ldap_tls_reqcert,
  $default_ldap_tls_cacert                = $sssd::params::default_ldap_tls_cacert,
  $default_ldap_id_use_start_tls          = $sssd::params::default_ldap_id_use_start_tls,
  $default_enumerate                      = $sssd::params::default_enumerate,
  $default_cache_credentials              = $sssd::params::default_cache_credentials,
  $default_reconnection_retries           = $sssd::params::default_reconnection_retries,
  $default_offline_credentials_expiration = $sssd::params::default_offline_credentials_expiration,
  $default_offline_failed_login_attempts  = $sssd::params::default_offline_failed_login_attempts,
  $default_offline_failed_login_delay     = $sssd::params::default_offline_failed_login_delay,
) inherits sssd::params {
  validate_re($service_ensure, '(running|stopped)', "Invalid service_ensure ${service_ensure}. Valid values are running or stopped")
  validate_bool($service_enable)

  # avoid installations on unsupported operating systems
  case $::osfamily {
    'RedHat': {
      case $::operatingsystemmajrelease {
        '6', '7': {
          include 'sssd::package'
          include 'sssd::config'
          include 'sssd::service'
          include 'sssd::authconfig'

          Class['sssd::package'] -> Class['sssd::config'] -> Class['sssd::service'] -> Class['sssd::authconfig']
        }
        default: {
          fail("unsupported operatingsystemmajrelease ${::operatingsystemmajrelease}")
        }
      }
    }
    'Suse': {
      case $::operatingsystemmajrelease {
        '11', '12': {
          include 'sssd::package'
          include 'sssd::config'
          include 'sssd::service'
          include 'sssd::authconfig'

          Class['sssd::package'] -> Class['sssd::config'] -> Class['sssd::service'] -> Class['sssd::authconfig']
        }
        default: {
          fail("unsupported operatingsystemmajrelease ${::operatingsystemmajrelease}")
        }
      }
    }
    default: {
      fail("unsupported osfamily ${::osfamily}")
    }
  }

  # create a domain with the default flags
  if ($create_default_domain == true) {
    sssd::domain { 'default': }
  }
}

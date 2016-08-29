# == Class: sssd::domain
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
#  class { 'sssd::domain':
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
define sssd::domain (
  $domain                         = $sssd::default_domain,
  $template                       = $sssd::default_domain_template,
  $id_provider                    = $sssd::default_id_provider,
  $auth_provider                  = $sssd::default_auth_provider,
  $chpass_provider                = $sssd::default_chpass_provider,
  $autofs_provider                = $sssd::default_autofs_provider,
  $netgroup_provider              = $sssd::default_netgroup_provider,
  $sudo_provider                  = $sssd::default_sudo_provider,
  $selinux_provider               = $sssd::default_selinux_provider,
  $subdomains_provider            = $sssd::default_subdomains_provider,
  $hostid_provider                = $sssd::default_hostid_provider,
  $override_shell                 = $sssd::default_override_shell,
  $override_homedir               = $sssd::default_override_homedir,
  $override_gid                   = $sssd::default_override_gid,
  $default_gid                    = $sssd::default_default_gid,
  $create_homedir                 = $sssd::default_create_homedir,
  $remove_homedir                 = $sssd::default_remove_homedir,
  $homedir_umask                  = $sssd::default_homedir_umask,
  $skel_dir                       = $sssd::default_skel_dir,
  $re_expression                  = $sssd::default_re_expression,
  $full_name_format               = $sssd::default_full_name_format,
  $ldap_uri                       = $sssd::default_full_name_format,
  $ldap_search_base               = $sssd::default_ldap_search_base,
  $ldap_default_bind_dn           = $sssd::default_ldap_default_bind_dn,
  $ldap_default_authtok           = $sssd::default_ldap_default_authtok,
  $ldap_schema                    = $sssd::default_ldap_schema,
  $ldap_user_object_class         = $sssd::default_ldap_user_object_class,
  $ldap_user_search_base          = $sssd::default_ldap_user_search_base,
  $ldap_group_object_class        = $sssd::default_ldap_group_object_class,
  $ldap_group_search_base         = $sssd::default_ldap_group_search_base,
  $ldap_account_expire_policy     = $sssd::default_ldap_account_expire_policy,
  $ldap_force_upper_case_realm    = $sssd::default_ldap_force_upper_case_realm,
  $ldap_id_mapping                = $sssd::default_ldap_id_mapping,
  $access_provider                = $sssd::default_access_provider,
  $simple_allow_users             = $sssd::default_simple_allow_users,
  $simple_allow_groups            = $sssd::default_simple_allow_groups,
  $ldap_tls_reqcert               = $sssd::default_ldap_tls_reqcert,
  $ldap_tls_cacert                = $sssd::default_ldap_tls_cacert,
  $ldap_id_use_start_tls          = $sssd::default_ldap_id_use_start_tls,
  $enumerate                      = $sssd::default_enumerate,
  $cache_credentials              = $sssd::default_cache_credentials,
  $reconnection_retries           = $sssd::default_reconnection_retries,
  $offline_credentials_expiration = $sssd::default_offline_credentials_expiration,
  $offline_failed_login_attempts  = $sssd::default_offline_failed_login_attempts,
  $offline_failed_login_delay     = $sssd::default_offline_failed_login_delay,
) {
  concat::fragment { $title:
    target  => '/etc/sssd/sssd.conf',
    content => template($template),
    order   => '20',
  }
}

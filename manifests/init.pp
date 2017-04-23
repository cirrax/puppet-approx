#
# Approx apt proxy server
#
# Installs the approx server and a basic configuration file
# specific repositories have to be defined with
# apt::approx::repository.
#
class approx(
  $conffile      = $approx::params::conffile,
  $cache         = $approx::params::cache,
  $interval      = $approx::params::interval,
  $max_rate      = $approx::params::max_rate,
  $max_redirects = $approx::params::max_redirects,
  $user          = $approx::params::user,
  $group         = $approx::params::group,
  $syslog        = $approx::params::syslog,
  $pdiffs        = $approx::params::pdiffs,
  $offline       = $approx::params::offline,
  $max_wait      = $approx::params::max_wait,
  $verbose       = $approx::params::verbose,
  $debug         = $approx::params::debug,
  $config        = {},
) inherits approx::params {

  package { 'approx': ensure => 'installed' }

  concat { $conffile:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment{ 'approx.conf_header':
    target  => $conffile,
    content => template('approx/approx.conf_header.erb'),
    order   => '00'
  }

  create_resources('approx::repository',$config)
}

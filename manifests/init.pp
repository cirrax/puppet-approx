#
# == Approx apt proxy server, main class
#
# @summary Installs the approx server and a basic configuration file
# specific repositories have to be defined with
# apt::approx::repository.
#
# @examples hiera usage to configure repositories
#
#  approx::config:
#    debian:
#      url: 'http://ftp.ch.debian.org/debian'
#    debian-security:
#      url: 'http://security.debian.org/debian-security'
#    debian-backports:
#      url: 'http://ftp.ch.debian.org/debian-backports'
#
# @param conffile path to the configuration file
# @param cache path of the approx cache directory
# @param ensure_cache if true it ensures that the cache directories are created
# @param interval time  in  minutes  after which a cached file will be considered too old to deliver
# @param max_rate maximum download rate from remote repositories, in bytes per second
# @param max_redirects maximum number of HTTP redirections 
# @param user user that owns the files in cache
# @param group group that owns the files in cache
# @param syslog syslog facility to use when logging
# @param pdiffs whether to support IndexFile diffs
# @param offline whether to deliver (possibly out-of-date) cached files
# @param max_wait  how many seconds an approx(8) process will wait for a concurrent download
# @param verbose whether informational messages should be printed in the log
# @param debug whether debugging messages should be printed in the log
# @param config Hash of repositories to configure 
# @param create_resources  a Hash of Hashes to create additional resources
#    Defaults to {} (do not create any additional resources)
#
#    Example (hiera) to create an xinetd service using puppetlabs-xinetd
#
#    approx::create_resources:
#      xinetd::service:
#        approx:
#          server: '/usr/sbin/approx'
#          user: 'approx'
#
#    Will result in  executing:
#      xinetd::service{'approx':
#        server => '/usr/sbin/approx'
#        user   => 'approx'
#
class approx(
  String $conffile      = $approx::params::conffile,
  Boolean $ensure_cache = true,
  String $cache         = $approx::params::cache,
  Integer $interval      = $approx::params::interval,
  Variant[Integer, Enum['unlimited']] $max_rate      = $approx::params::max_rate,
  Integer $max_redirects = $approx::params::max_redirects,
  String  $user          = $approx::params::user,
  String  $group         = $approx::params::group,
  String  $syslog        = $approx::params::syslog,
  Boolean $pdiffs        = $approx::params::pdiffs,
  Boolean $offline       = $approx::params::offline,
  Integer $max_wait      = $approx::params::max_wait,
  Boolean $verbose       = $approx::params::verbose,
  Boolean $debug         = $approx::params::debug,
  Hash    $config        = {},
  Hash    $create_resources = {},
) inherits approx::params {

  package { 'approx': ensure => 'installed' }

  concat { $conffile:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['approx'],
  }

  concat::fragment{ 'approx.conf_header':
    target  => $conffile,
    content => template('approx/approx.conf_header.erb'),
    order   => '00',
  }

  if $ensure_cache {
    file { $cache :
      ensure => 'directory',
      owner  => $user,
      group  => $group,
      mode   => '0755',
    }
  }


  create_resources('approx::repository',$config)

  $create_resources.each | $res, $vals | {
    create_resources($res, $vals )
  }
}

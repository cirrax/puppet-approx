#
# Approx apt proxy server
#
# Installs the approx server and a basic configuration file
# specific repositories have to be defined with
# apt::approx::repository.
#
class approx(
  $conffile = '/etc/approx/approx.conf',
  $config   = {},
){
  package { 'approx': ensure => 'installed' }

  concat { $conffile:
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  concat::fragment{ 'approx.conf_header':
    target => $conffile,
    source => 'puppet:///modules/approx/approx.conf',
    order  => '00'
  }

  create_resources('approx::repository',$config)
}

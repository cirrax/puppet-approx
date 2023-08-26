# @summary alter port/ip to listen if using systemd
#
# if on a system with systemd, you can use this class
# to alter port/ip to listen on.
#
# @param listen_streams
#  Array of ListenStream option to listen
#  if undef (default) the dropin is set to absent
#  Example (yaml):
#    approx::systemd_socket::listen_streams:
#      - '127.0.0.1:9999'
#      - '[::1]:9999'
#
# @param unit
#  The target unit file to create
#
# @param service_name
#  the name of the service we want to ensure
# @param service_ensure
#  state of the service to ensure
# @param service_enable
#  if the service should be enabled or not
#
class approx::systemd_socket (
  Optional[Array[String]] $listen_streams = undef,
  Systemd::Unit           $unit           = 'approx.socket',
  String[1]               $service_name   = 'approx.socket',
  String[1]               $service_ensure = 'running',
  Boolean                 $service_enable = true,
) {
  if $listen_streams {
    systemd::dropin_file { 'approx.conf':
      ensure  => 'present',
      unit    => $unit,
      content => inline_epp( @(ENDTEMPLATE)
        [Socket]
        ListenStream=
        <% $listen_streams.each | String[1] $v | { -%>
        ListenStream=<%= $v %> 
        <% } -%> 
        |ENDTEMPLATE
      ),
    }
  } else {
    systemd::dropin_file { 'approx.conf':
      ensure => 'absent',
      unit   => $unit,
    }
  }

  service { $service_name:
    ensure => $service_ensure,
    enable => $service_enable,
  }
}

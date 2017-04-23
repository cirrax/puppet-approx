
class approx::params {

  $conffile      = '/etc/approx/approx.conf'

  # approx default values
  $cache         = '/var/cache/approx'
  $interval      = 60
  $max_rate      = 'unlimited'
  $max_redirects = 5
  $user          = 'approx'
  $group         = 'approx'
  $syslog        = 'daemon'
  $pdiffs        = true
  $offline       = false
  $max_wait      = 10
  $verbose       = false
  $debug         = false
}

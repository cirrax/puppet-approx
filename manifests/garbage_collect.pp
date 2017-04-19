
#
# Cronjob to run approx-gc
#
class approx::garbage_collect (
) {

  cron { 'approx-gc':
    command => '/usr/sbin/approx-gc -q',
    user    => 'root',
    hour    => fqdn_rand(6,'approx-gc'),
    minute  => fqdn_rand(60,'approx-gc'),
  }
}

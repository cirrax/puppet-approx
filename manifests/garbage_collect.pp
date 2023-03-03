#
# Cronjob to run approx-gc
#
# @note approx-gc is not available in newer versions of approx
#   (@see https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=861947)
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

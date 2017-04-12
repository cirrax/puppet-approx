#
# Approx repository
#
# Add a repository line to an approx proxy
#
# Parameters:
#   $url:
#     URL to add to the proxy
#   $reponame:
#     Name for this repository on the approx proxy.
#     Defaults to $title.
#   $conffile:
#     config file to add the repository
#     Defaults to $approx::conffile
#   $order:
#     Order for the concat.
#     Defaults to '50'
#
define approx::repository (
  $url,
  $reponame = $title,
  $conffile = '/etc/approx/approx.conf',
  $order    = '50',
) {

  concat::fragment{ $title:
    target  => $conffile,
    content => "${reponame} 	${url}\n",
    order   => $order,
  }
}


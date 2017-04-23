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
  $order    = '50',
) {

  include approx

  concat::fragment{ $title:
    target  => $approx::conffile,
    content => "${reponame} 	${url}\n",
    order   => $order,
  }
}


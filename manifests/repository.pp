#
# Add a repository line to an approx proxy
#
# @example basic usage
#   approx::repository{'debian-security':
#     url => 'http://security.debian.org/debian-security', 
#   }  
#
# @param url
#   URL to add to the proxy
# @param reponame
#   Name for this repository on the approx proxy.
#   Defaults to $title.
# @param order
#   Order for the concat.
#   Defaults to '50'
#
define approx::repository (
  String $url,
  String $reponame = $title,
  String $order    = '50',
) {
  include approx

  concat::fragment { $title:
    target  => $approx::conffile,
    content => inline_template("<%= @reponame.ljust(25,' ') %> <%= @url %>\n"),
    order   => $order,
  }
}

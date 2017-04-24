# approx

#### Table of Contents

1. [Overview](#overview)
1. [Usage - Configuration options and additional functionality](#usage)




## Overview

This module is used to configure approx. Approx is a caching proxy for 
Debian (and derivative) packages requested by apt-get. 

## Usage

To start using approx you need to include the approx main class and
add the urls you like to make available.

A minimal example might be:

~~~
class{'approx'}

approx::repository{'debian':
  url => 'http://ftp.ch.debian.org/debian',
}

approx::repository{'debian-security':
  url => 'http://security.debian.org/debian-security',
}
~~~

If you like to use hiera, you can define:

~~~
---
approx::config:
  debian:
      url: 'http://ftp.ch.debian.org/debian'
  debian-security:
      url: 'http://security.debian.org/debian-security'
~~~


## Contributing

Please report bugs and feature request using GitHub issue tracker.

For pull requests, it is very much appreciated to check your Puppet manifest with puppet-lint
and the available spec tests  in order to follow the recommended Puppet style guidelines
from the Puppet Labs style guide.


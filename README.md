# approx puppet module

[![Build Status](https://travis-ci.org/cirrax/puppet-approx.svg?branch=master)](https://travis-ci.org/cirrax/puppet-approx)
[![Puppet Forge](https://img.shields.io/puppetforge/v/cirrax/approx.svg?style=flat-square)](https://forge.puppetlabs.com/cirrax/approx)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/cirrax/approx.svg?style=flat-square)](https://forge.puppet.com/cirrax/approx)
[![Puppet Forge](https://img.shields.io/puppetforge/e/cirrax/approx.svg?style=flat-square)](https://forge.puppet.com/cirrax/approx)
[![Puppet Forge](https://img.shields.io/puppetforge/f/cirrax/approx.svg?style=flat-square)](https://forge.puppet.com/cirrax/approx)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/github/cirrax/puppet-approx)

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

## Reference
### classes
[::approx](http://www.puppetmodule.info/github/cirrax/puppet-approx/master/puppet_classes/approx)
[::approx::params](http://www.puppetmodule.info/github/cirrax/puppet-approx/master/puppet_classes/approx_3A_3Aparams)
[::approx::garbage_collect](http://www.puppetmodule.info/github/cirrax/puppet-approx/master/puppet_classes/approx_3A_3Agarbage_collect)

### defined types
[::approx::repository](http://www.puppetmodule.info/github/cirrax/puppet-approx/master/puppet_defined_types/approx_3A_3Arepository)


## Contributing

Please report bugs and feature request using GitHub issue tracker.

For pull requests, it is very much appreciated to check your Puppet manifest with puppet-lint
and the available spec tests  in order to follow the recommended Puppet style guidelines
from the Puppet Labs style guide.

### Authors

This module is mainly written by [Cirrax GmbH](https://cirrax.com).

See the [list of contributors](https://github.com/cirrax/puppet-postfix/graphs/contributors)
for a list of all contributors.

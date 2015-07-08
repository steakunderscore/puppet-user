#Hiera Users [![Build Status](https://secure.travis-ci.org/steakunderscore/puppet-user.png)](http://travis-ci.org/steakunderscore/puppet-user)

##Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with Hiera Users](#setup)
    * [What Hiera Users affects](#what-Hiera_users-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with Hiera Users](#beginning-with-hiera_users)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

###Gittip
[![Support via Gittip](https://rawgithub.com/twolfson/gittip-badge/0.2.0/dist/gittip.png)](https://www.gittip.com/steakunderscore/)

##Overview

The Hiera Users module allows management of user accounts through hiera making
use of the hirea [merge deeper] functionality my describing users in yaml.

##Module Description

This module enable having a default set of user templtes also alowing per host
overriding of the users configuration paramerets. So for example a user having
a default password on each host, but over riding that password on some hosts.

##Setup

###What Hiera Users affects

Hiera users reads from hiera making calls to the `user`, `ssh_authorized_key`
and `group` classes from stdlib.

###Setup Requirements

* The `merge_deeper` gem
* Stdlib

```sh
gem install merge_deeper
```

###Beginning with Hiera Users

Include the users to all hosts
```ruby
# site.pp
include users
```

Then configure the users in yaml

```yaml
# hiera.yaml
---
:hierarchy:
  - "%{::clientcert}"
  - users
  - groups
  - common
:backends:
  - yaml
  - gpg
:yaml:
  :datadir: '/etc/puppet/hieradata'
:merge_behavior: deeper
```

```yaml
# host1.example.com.yaml
---
site_users:
  bob:
    home_dir: /home/bob
    password: "optional password hash"
    groups:
      - sudo
      - adm
  john:
    groups:
site_groups:
  sysadmin:
    gid: 300
```

```yml
# host1.example.com.yaml
---
  users:
    John:
      groups:
        - adm
  groups:
    - sysadmin
```

```yml
# users.yaml
---
site_users:
  bob:
    home_dir: /opt/sysadmin
    uid: 1000
    gid: 1001
    password: "default password hash for hosts"
    groups:
      - sudo
      - users
  john:
    home_dir: /opt/sysadmin
    password: "default password hash for all host"
    groups:
      - sudo
      - default_groups_for_all_hosts
```

```yml
# groups.yaml
---
site_groups:
  sysadmin:
    gid: 1000
  appadmin:
```

##Reference

* http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120

##Limitations

Should would on any system that supports stdlib.

##Development

Hit me up on github.

##Release Notes/Contributors/Etc

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.

[merge deeper]: http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120

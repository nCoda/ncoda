nCoda Development Environment Setup Program
===========================================

[![CircleCI](https://circleci.com/gh/nCoda/ncoda/tree/main.svg?style=svg)](https://circleci.com/gh/nCoda/ncoda/tree/main)

This repository holds an automation suite that downloads and configures an
[nCoda](https://ncodamusic.org/) development environment. nCoda software is cloned into the
"programs" directory.

We develop *nCoda* on our own [Phabricator](https://goldman.ncodamusic.org/) installation. You must
register an account and upload an SSH key to clone our repositories from Phabricator. However, you
may also clone this repository without signing up by using our mirror on
[GitHub](https://github.com/ncoda/ncoda).

**Supported platforms:** we develop this program on CentOS 7, test formally on Ubuntu 14.04, and
less often on several macOS versions. We would like to support more platforms and operating systems,
so please contact us if you can help.


Getting Started
===============

Setup your development environment and run the nCoda test suites.

1. Install manual dependencies (see below).
1. `./init.py`
1. `./nc init`
1. `./nc test`
1. Run `./nc` to see what other commands you can run.

Note that you should not handle the virtualenv yourself since `ncoda` handles this automatically.

Note that you *must* run `init.py` with a CPython 2.7 interpreter to bootstrap Ansible---no other
Python interpreters or versions will work.

To use another Python interpreter for development, provide the `lychee_python` commandline flag:

    $ ./init.py --lychee_python "/usr/bin/pypy"


Manual Dependencies
===================

The `ncoda` program uses Ansible to automate software installation and configuration. Unfortunately,
Ansible itself has some dependencies, and we have not automated their installation yet. Please
install the following software in your usual way:

- libffi
- openssl

For macOS computers, maybe `brew install libffi && brew install openssl` will work.

For Fedora-like computers, try `yum install libffi-devel openssl-devel`.

For Debian-like computers, consider `apt install libffi-dev libssl-dev`.

There's no need to guess whether you've installed these correctly: if the `init.py` script succeeds
then the dependencies were installed!


Troubleshooting
===============

When problems arise, we try to automate the solution so nobody will run into them again. Not every
problem has been found, and some are not solved properly yet.

- If `./nc init` fails and the error message includes the text "password required," this may be a
  problem with `sudo`. We're considering our options to resolve this properly. Currently, you must
  either add the "NOPASSWD" option to the relevant place in `/etc/sudoers`, or make sure the
  no-password timeout hasn't elapsed yet. (E.g., run a `sudo` command just before `./nc init`).
- On macOS, sometimes `init.py` fails while installing "pycrypto" due to a years-old bug in that
  library. You can resolve this by installing "pycrypto" from source:
  1. Activate the `ansible-venv` virtualenv.
  1. Install "pycrypto" from source.
  1. Deactivate the virtualenv.
  1. Continue with `init.py`.


Contact
=======

Find contact information on our website at https://ncodamusic.org/.

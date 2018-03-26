nCoda Development
=================

The nCoda development is focusing on three areas
* Binary releases for use on Linux, Mac or Windows platforms (specific requirements not yet published)
* Binary pre-release (current builds of the development environment)
* Development codebase (Continuous Integration testing [![CircleCI](https://circleci.com/gh/nCoda/ncoda/tree/main.svg?style=svg)](https://circleci.com/gh/nCoda/ncoda/tree/main))

The nCoda application operates as a web based, client/server model, with the server (a python socket)
operating as on localhost. Additional architecture documentation pending development.

We are approaching our [MVP](https://spivak.ncodamusic.org/t/mvp-test-plan/670) (Minimum Viable Product), basic functionality of opening a project, rendering an engraving, changing the score, saving and reopening the project; with simplified install and minimal bugs.

This repository is the development codebase, with development specific components (not required for regular nCoda use).

* Phabricator (project management) https://goldman.ncodamusic.org/ 
* Git master ssh://vcs@goldman.ncodamusic.org/source/ncoda.git
* Development mirror (read-only, public fork) https://github.com/ncoda/ncoda

(Phabricator and our git master require account approval, email and ssh key authentication.)

Bootstrapping the Development Environment
=========================================

**Supported platforms:** we develop on CentOS 7, test formally on Ubuntu 14.04, and
less often on several macOS versions. See manual dependencies below for help on other platforms.
We would like to support additional platforms and operating systems, please contact us if you can help.

After you have cloned this repo,
bootstrap the development environment as a regular user (not root) with the following steps: 

1. Install manual dependencies (libffi and openssl, see below).
1. `./init.py`
1. `./nc init`
1. `./nc test`
1. Run `./nc` to see what other commands you can run.

Note that you should not handle the virtualenv yourself since `ncoda` handles this automatically.

Note that you *must* run `init.py` with a CPython 2.7 interpreter to bootstrap Ansible---no other
Python interpreters or versions will work.

To use another Python interpreter for development, provide the `lychee_python` commandline flag:

    $ ./init.py --lychee_python "/usr/bin/pypy"


Activate Lychee's Virtualenv
============================

We use [virtualenv](https://virtualenv.pypa.io/) to manage our Python dependencies. It can be useful
to activate Lychee's virtualenv when you're working on *nCoda*. Run the `./nc activate` command.

We added some extra goodies to the virtualenv:
- The `node` and `npm` commands will use the NodeJS and NPM version installed for *nCoda*. This is
  matched to the same version of NodeJS that *Electron* uses when you start *nCoda*. The setup
  program automatically upgrades NodeJS when we upgrade *Electron*.
- The `nc` and `ncoda` commands are also added to the `PATH`, available from any directory without
  the silly `./` bit. You won't be able to use `netcat` when the virtualenv is activated.

Type `exit` to leave the virtualenv.


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

Manual Dependencies
===================

These steps are only required for **non-supported** platforms.

Using CentOS 6.x or Python 2.6 requires a newer python. [Latest python on CentOS 6](https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/)
requires:

1. yum update
1. yum groupinstall -y "development tools"
1. yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel expat-devel wget
1. mkdir -p /usr/local/dist /usr/local/src
1. cd /usr/local/dist
1. wget http://python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
1. cd /usr/local/src
1. tar xf ../dist/Python-2.7.14.tar.xz
1. cd Python-2.7.14
1. ./configure --prefix=/usr/local --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/lib"
1. make && make altinstall
1. mkdir /usr/local/bin/python2.7-bin
1. ln -s /usr/local/bin/python2.7 /usr/local/bin/python2.7-bin/python
1. PATH=/usr/local/bin/python2.7-bin/:$PATH

Contact
=======

Find contact information on our website at https://ncodamusic.org/.


#!/usr/bin/env python
#
# Copyright 2016 Christopher Antila

import argparse
import os.path
import subprocess
import sys

VENV_PATH = 'ansible-venv'
VENV_PROMPT = 'ncoda-ansible '


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--lychee_python', help='The Python interpreter to use for Lychee')
    args = parser.parse_args()

    # Verify "lychee_python" argument
    ansible_python = sys.executable
    lychee_python = sys.executable
    if args.lychee_python:
        if not os.path.exists(args.lychee_python):
            print('The "lychee_python" file does not exist.')
            raise SystemExit(1)
        elif not os.path.isfile(args.lychee_python):
            print('The "lychee_python" file is not a file.')
            raise SystemExit(1)
        else:
            lychee_python = args.lychee_python

    # See if the virtualenv already exists, in which case they shouldn't us this script!
    if not os.path.exists(VENV_PATH):
        # find the Python executable we'll use
        if (not sys.version.startswith('2.7')) or ('PyPy' in sys.version):
            print('Please start this script with CPython 2.7')
            raise SystemExit(1)

        # find the virtualenv executable we'll use
        try:
            virtualenv_exec = subprocess.check_output(['which', 'virtualenv']).strip()
        except subprocess.CalledProcessError:
            print('\nPlease install "virtualenv" before running init.py\n')
            raise SystemExit(1)

        # make the virtualenv
        try:
            print('Creating a virtualenv for Ansible')
            output = subprocess.check_output([
                virtualenv_exec,
                '-p',
                ansible_python,
                '--prompt={0}'.format(VENV_PROMPT),
                VENV_PATH
            ])
        except subprocess.CalledProcessError:
            raise SystemExit(1)

    activate = 'source {0}/bin/activate'.format(VENV_PATH)

    try:
        subprocess.check_call(['env', 'bash', '-c', '{0}; pip install -U setuptools pip'.format(activate)])
    except subprocess.CalledProcessError:
        print('Failed while upgrading setuptools and pip')
        raise SystemExit(1)

    try:
        subprocess.check_call(['env', 'bash', '-c', '{0}; pip install -U "ansible<2.2"'.format(activate)])
    except subprocess.CalledProcessError:
        print('Failed while installing Ansible')
        raise SystemExit(1)

    # Set the Ansible variables file with the path to Lychee's Python interpreter.
    with open('.python_vars.yml', 'w') as vars_file:
        vars_file.write('---\nlychee_venv_python: "{0}"\n'.format(lychee_python))

    try:
        subprocess.check_call(['env', 'bash', '-c', '{0}; ansible-playbook -i .inventory .initialize.yml -t install_ncoda'.format(activate)])
    except subprocess.CalledProcessError:
        print('Failed while running "ansible-playbook"')
        raise SystemExit(1)

    print('''
********************************************************************************

Finished initial setup (part 1)!

Before you continue, make sure you can pull the following repositories from Phabricator:
- fujian
- hgdemo_config
- julius
- lychee
- mercurial-hug
- ShelfExtender

Then run these commands:
    $ ./nc init
    $ ./nc test
''')


if __name__ == '__main__':
    main()

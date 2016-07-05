#!/usr/bin/env python
#
# Copyright 2016 Christopher Antila

import os.path
import subprocess
import sys

VENV_PATH = 'ansible-venv'
VENV_PROMPT = 'ncoda-ansible '

# See if the virtualenv already exists, in which case they shouldn't us this script!
if not os.path.exists(VENV_PATH):
    # find the Python executable we'll use
    if sys.version.startswith('2.7') and 'PyPy' not in sys.version:
        python_exec = sys.executable
    else:
        print('Please start this script with CPython 2.7')
        raise SystemExit(1)
        # TODO: take the interpreter from the commandline
        # TODO: try to look for an interpreter ourselves

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
            python_exec,
            '--prompt={0}'.format(VENV_PROMPT),
            VENV_PATH
        ])
    except subprocess.CalledProcessError:
        raise SystemExit(1)

activate = 'source {0}/bin/activate'.format(VENV_PATH)

try:
    subprocess.check_call('{0}; pip install -U setuptools pip'.format(activate), shell=True)
except subprocess.CalledProcessError:
    print('Failed while upgrading setuptools and pip')
    raise SystemExit(1)

try:
    subprocess.check_call('{0}; pip install -U "ansible<2.2"'.format(activate), shell=True)
except subprocess.CalledProcessError:
    print('Failed while installing Ansible')
    raise SystemExit(1)

try:
    subprocess.check_call('{0}; ansible-playbook -i .inventory .initialize.yml -t install_ncoda'.format(activate), shell=True)
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

Then run this command: './nc init'
''')

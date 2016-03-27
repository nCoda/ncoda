#!/usr/bin/env bash
#
# Copyright 2016 Christopher Antila

VENV_PATH="ansible-venv"

# See if the virtualenv already exists, in which case they shouldn't us this script!
if [ ! -d "${VENV_PATH}" ]; then
    # See if we have a CPython 2
    HAVE_PYTHON=false
    which python 1> /dev/null 2> /dev/null

    if (( $? == 0 )); then
        python2 --version
        read -p "^ Does that say 'Python 2.7.x'? (y/n)  " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Awesome!"
            HAVE_PYTHON=true
        else
            echo "Please install CPython 2.7"
            exit 1
        fi
    else
        echo "Please install CPython 2.7"
        exit 1
    fi

    # See if we have virtualenv
    HAVE_VENV=false
    which virtualenv 1> /dev/null 2> /dev/null

    if (( $? == 0 )); then
        virtualenv --version
        read -p "^ Does that say '1.x.y'? (y/n)  " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            echo "Super!"
            HAVE_VENV=true
        else
            echo "Please install virtualenv"
            exit 1
        fi
    else
        echo "Please install virtualenv"
        exit 1
    fi

    # IDK we'll probably need 'em later but for now just assume we have everything...
    echo $'\nPreparing your Ansible virtualenv!\n'
    virtualenv -p python --prompt="ncoda-ansible " ${VENV_PATH}
else
    echo "NOTE: you already have the Ansible virtualenv. We'll continue but you maybe don't need this script"
fi

source ${VENV_PATH}/bin/activate
pip install -U setuptools pip
pip install -U "ansible<3"
ansible-playbook -i .inventory .initialize.yml -t update_ncoda
echo ""
echo "Before you continue, make sure:"
echo "- you can pull from Phabricator (if you pull this repository, you're good)"
echo "- you can pull the following repositories on Phabricator:"
echo "    - Lychee"
echo "    - Julius"
echo "    - Fujian"
echo "    - mercurial-hug"
echo "    - hgdemo"
echo ""
echo "Then run this command: './nc init'"
echo ""

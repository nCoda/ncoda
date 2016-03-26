#!/usr/bin/env bash
#
# Copyright 2016 Christopher Antila

source ansible-venv/bin/activate

ansible-playbook -i .inventory .ansible.yml
ansible-playbook -i .inventory .initialize.yml

#!/usr/bin/env bash
#
# Copyright 2016 Christopher Antila

case $1 in
    "init"|"initialize")
        source ansible-venv/bin/activate
        ansible-playbook -i .inventory .ansible.yml
        ansible-playbook -i .inventory .initialize.yml
    ;;

    "run")
        case $2 in
            "http")
            exec ./.julius-http.py
            ;;
            *)
            exec ./.julius-electron.py
            ;;
        esac
    ;;

    *)
        echo "nc: program does this"
        echo ""
        echo "Copyright 2016 Christopher Antila"
        echo ""
        echo "Commands:"
        echo "---------"
        echo "- init                    Bootstrap the nCoda development environment."
        echo "  initialize"
        echo "- run [electron|http]     Start Fujian/Lychee and Julius, either with"
        echo "                          'electron' (the default) or a web server."
        echo ""
esac

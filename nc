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
                echo "Starting Julius via web server"
                exec ./.julius-http.py
            ;;
            *)
                echo "Starting Julius in Electron"
                exec ./.julius-electron.py
            ;;
        esac
    ;;

    "update"|"upgrade"|"sync")
        case $2 in
            "julius")
                echo "Updating Julius's dependencies"
                source ansible-venv/bin/activate
                ansible-playbook -i .inventory .initialize.yml -t update_julius
            ;;
            "lychee")
                echo "Updating Lychee's dependencies"
                source ansible-venv/bin/activate
                ansible-playbook -i .inventory .initialize.yml -t update_lychee
            ;;
            *)
                echo "Updating all dependencies"
                source ansible-venv/bin/activate
                ansible-playbook -i .inventory .initialize.yml -t update
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
        echo "- update [julius|lychee|all] (default 'all') Update, upgrade, or"
        echo "  upgrade                 synchronize dependencies for these softwares."
        echo "  sync"
        echo ""
esac

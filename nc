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

    "test")
        case $2 in
            "julius")
                echo "Running the Julius test suite"
                cd programs/julius
                ../../nodejs-5.1.1/bin/npm test
            ;;
            "fujian")
                echo "Running the Fujian test suite"
                source lychee-venv/bin/activate
                py.test programs/fujian
            ;;
            "lychee")
                echo "Running the Lychee test suite"
                source lychee-venv/bin/activate
                py.test programs/lychee
            ;;
            "mercurial-hug")
                echo "Running the Mercurial-Hug test suite"
                source lychee-venv/bin/activate
                py.test programs/mercurial-hug
            ;;
            *)
                echo "Running all the test suites"
                cd programs/julius
                ../../nodejs-5.1.1/bin/npm test
                cd ../..
                source lychee-venv/bin/activate
                py.test programs/fujian
                py.test programs/lychee
                py.test programs/mercurial-hug
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
        echo "- test [julius|lychee|fujian|mercurial-hug]  Run an automated test suite."
        echo "- update [julius|lychee|all] (default 'all') Update, upgrade, or"
        echo "  upgrade                 synchronize dependencies for these softwares."
        echo "  sync"
        echo ""
esac

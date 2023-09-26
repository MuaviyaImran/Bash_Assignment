#!/bin/bash

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -i INTERVAL  Set the download interval in minutes (default: 60 minutes)."
    echo "  -h           Show this help message."
}

# Default values
interval=60

while getopts ":i:h" opt; do
    case $opt in
        i)
            interval="$OPTARG"
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            usage
            exit 1
            ;;
    esac
done

cp ./wallpaper.sh ~/wallpaper.sh
crontab -e
(crontab -l ; echo "*/1 * * * * ~/wallpaper.sh") | crontab -

echo "Wallpaper script installed in the home directory, and a cron job has been added."


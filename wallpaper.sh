#!/bin/bash

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -p PATH      Save image to a specific path."
    echo "  -t           Save image in /tmp."
    echo "  -o FILENAME  Save image with a specific name."
    echo "  -r RES       Set custom resolution for the image."
    echo "  -h           Show this help message."
}


# Default values
path=""
tmp=false
filename="wallpaper"
resolution="1920/1080"

while getopts ":p:to:r:h" opt; do
    case $opt in
        p)
            path="$OPTARG"
            ;;
        t)
            tmp=true
            ;;
        o)
            filename="$OPTARG"
            ;;
        r)
            resolution="$OPTARG"
            resolution=$(echo "$resolution" | sed 's/x/\//g')
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument."
            usage
            exit 1
            ;;
    esac
done

# Setting path according to the Arguments
download_dir=""
if [ -n "$path" ]; then
    download_dir="$path/$filename.jpg"
elif [ "$tmp" = true ]; then
    mkdir tmp
    download_dir="./tmp/$filename.jpg"
else
    download_dir="./$filename.jpg"
fi

wget -O "$download_dir" "https://picsum.photos/$resolution"


echo "Image saved to: $download_dir"




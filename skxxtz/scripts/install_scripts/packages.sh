#!/bin/bash

PACKAGE_LIST="dependencies/packages.txt"

if [[ ! -f "$PACKAGE_LIST" ]]; then
    echo "Package list not found!"
    exit 1
fi 

while IFS= read -r package; do 
    if [[ -n "$package" ]]; then 
        echo "Installing $package..."
        sudo pacman -S --needed "$package"
    fi 
done < "$PACKAGE_LIST"

echo "All packages installed."

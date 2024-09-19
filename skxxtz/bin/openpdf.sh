#!/bin/bash


while IFS= read -r line; do 
    thorium-browser --open "file:///$line"
done

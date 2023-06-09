#!/bin/bash
set -e
clear
echo "Please enter the local path of the file you want to export to Mega:"
        read file
        megaput $file
        ;;
        
clear

#!/usr/bin/env bash


for file in $1; do 
            echo "$file was modified. Directory: $(dirname "$file"), Name: $(basename "$(dirname "$file")")"
            
            # if [] || []; then
            #   echo "changes_exist=true" >> $GITHUB_ENV
            # else
            #   echo "changes_exist=false" >> $GITHUB_ENV
            # fi
          done
#!/usr/bin/env bash


echo "aaaaaaaa: ${changedFiles}"
for file in ${changedFiles}; do 
            echo "$file was modified. Directory: $(dirname "$file"), Name: $(basename "$(dirname "$file")")"
            
            # if [] || []; then
            #   echo "changes_exist=true" >> $GITHUB_ENV
            # else
            #   echo "changes_exist=false" >> $GITHUB_ENV
            # fi
          done

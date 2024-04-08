#!/usr/bin/env bash


echo "List of changed files: ${changedFiles}"
for file in ${changedFiles}; do 
            # echo "$file was modified. Directory: $(dirname "$file"), Name: $(basename "$(dirname "$file")")"

            parentDirPath=$(dirname "$file")
            parentDirName=$(basename "$(dirname "$file")")
            
            echo "$file was modified. Path: $parentDirPath, Name: $parentDirName"
            
            # if [] || []; then
            #   echo "changes_exist=true" >> $GITHUB_ENV
            # else
            #   echo "changes_exist=false" >> $GITHUB_ENV
            # fi
          done

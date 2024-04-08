#!/usr/bin/env bash


echo "List of changed files: ${changedFiles}"
appsToValidate=()
for file in ${changedFiles}; do 
            # echo "$file was modified. Directory: $(dirname "$file"), Name: $(basename "$(dirname "$file")")"

            parentDirPath=$(dirname "$file")
            parentDirName=$(basename "$(dirname "$file")")
            echo "$file was modified. Path: $parentDirPath, Name: $parentDirName"
            
            if [ "$parentDirName" == "base" ] || [ "$parentDirName" == "overlays" ]; then
              appDirPath=$(dirname "$parentDirPath")              
              appDirName=$(basename "$(dirname "$parentDirPath")")
              echo "App manifest was modified. Path: $appDirPath, Name: $appDirName"
              appsToValidate+=($appDirPath)
              appsToValidate+=("aaaa")
              appsToValidate+=("bbbb")
            else
              echo "Terminating.. Change occurred in a file other than base and overlays dir."
            fi
          done

          echo "appsToValidate=$appsToValidate" >> $GITHUB_ENV

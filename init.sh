#!/bin/bash

echo "Checking grunt"

file=./package.json
apps=./apps.txt

if gulp -v > /dev/null; then
  echo "gulp is already installed."
  if [ -e "$file" ]; then
    echo "File - package.json - exists"
    if [ -e "$apps" ]; then
      echo "File - apps.txt - exists"
      while read -r line
      do
        app=`echo $line | cut -d \; -f 1`
        npm install $app
      done < $apps
    else
      echo "File not exists"
    fi
  else
    echo "File not exists"
    npm init
  fi
else
  echo "installing node and npm"
  if node -v > /dev/null; then
    if npm -v > /dev/null; then
      echo "installing grunt"
      npm install grunt-cli -g
      npm install grunt -g
      npm install grunt-init -g
      touch Gruntfile.js
      if [ -e "$file" ]; then
        echo "File - package.json - exists"
        if [ -e "$apps" ]; then
          echo "File - apps.txt - exists"
          while read -r line
          do
            app=`echo $line | cut -d \; -f 1`
            npm install $app
          done < $apps
        else
          echo "File not exists"
        fi
      else
        echo "File not exists"
        npm init
      fi
    else
      echo "npm is not installed"
    fi
  else
    echo "node is not installed"
  fi
fi

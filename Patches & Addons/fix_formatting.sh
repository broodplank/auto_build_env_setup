#!/bin/sh

sudo apt-get install dos2unix

find . -type f -exec dos2unix {} +

sudo chown -R broodplank .

echo "Done with converting all files to unix format"
echo "Changing ownership of files done"
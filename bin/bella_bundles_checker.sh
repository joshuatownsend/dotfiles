#!/bin/bash

bundles_path=/home/gez/Dev/git/bella/vendor/ttps
namespace=TTPS

for dir in `ls -1 ${bundles_path}`
do
    path=${bundles_path}/${dir}
    for bundle in `ls -1 ${path}/TTPS`
    do
        bundle_path=${path}/${namespace}/${bundle}
        cd ${bundle_path}
        echo "* Checking ${bundle}"
        git status
        echo ""
    done
done

echo "Done!"



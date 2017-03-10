#!/bin/bash
for file in _site/post/*.html
do
    postname=$( basename "$( basename "$file" )" .html )
    ln -s "${file}" "_site/${postname}"
done

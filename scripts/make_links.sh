#!/bin/bash
for file in _site/post/*.html
do
    postname=$( basename "$( basename "$file" )" .html )
    cp "${file}" "_site/${postname}"
done

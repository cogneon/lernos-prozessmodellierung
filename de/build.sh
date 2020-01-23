#!/bin/sh

filename="lernOS-Prozessmodellierung-de"
dest_folder="generate"

# install pandoc and pdflatex (best results with mactex) before

echo Cleaning up destination folder \"$dest_folder\"
rm -rf $dest_folder
mkdir $dest_folder

echo Generating pdf for $filename
pandoc $filename.md metadata.yaml -o $dest_folder/$filename.pdf --from markdown --template ressources/Prozessmodellierung.latex --pdf-engine=pdflatex --number-sections -V lang=de-de
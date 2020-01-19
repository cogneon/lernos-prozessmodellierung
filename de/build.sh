#!/bin/sh

filename="lernOS-Prozessmodellierung-de"

# install pandoc and pdflatex (best results with mactex) before

echo Generating pdf for $filename
pandoc $filename.md metadata.yaml -o $filename.pdf --from markdown --template ressources/Prozessmodellierung.latex --pdf-engine=pdflatex --number-sections -V lang=de-de
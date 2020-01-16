@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core tbd.

REM Variables
set filename="lernOS-Prozessmodellierung-de"

REM Delete Old Versions
REM del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png

REM Create Microsoft Word Version (docx)
rem pandoc -s -o %filename%.docx %filename%.md

REM Create Web Version (html)
REM pandoc -s --toc -o %filename%.html %filename%.md

REM Create PDF Version (pdf)
pandoc %filename%.md metadata.yaml -o %filename%.pdf --from markdown --template Prozessmodellierung.latex --number-sections -V lang=de-de

REM Create eBook Versions (epub, mobi)
REM magick -density 300 %filename%.pdf[0] ebook-cover.png
REM magick mogrify -size 2500x2500 -resize 2500x2500 ebook-cover.jpg
REM magick mogrify -crop 1563x2500+102+0 ebook-cover.jpg
REM pandoc metadata.yaml -s --epub-cover-image=ebook-cover.png -o %filename%.epub %filename%.md
REM ebook-convert %filename%.epub %filename%.mobi
REM del ebook-cover.jpg
REM del ebook-cover.png

pause

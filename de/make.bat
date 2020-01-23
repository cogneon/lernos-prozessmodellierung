@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core tbd.

REM Variables
set filename="lernOS-Prozessmodellierung-de"
set dest_folder="generate"

REM Delete Old Versions
REM del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png

echo Cleaning up destination folder "%dest_folder%"
rmdir %dest_folder% /s /q
mkdir %dest_folder%

REM Create Microsoft Word Version (docx)
pandoc -s -o %dest_folder%/%filename%.docx %filename%.md

REM Create Web Version (html)
pandoc -s --toc -o %dest_folder%/%filename%.html %filename%.md

REM Create PDF Version (pdf)
pandoc %filename%.md metadata.yaml -o %dest_folder%/%filename%.pdf --from markdown --template Prozessmodellierung.latex --number-sections -V lang=de-de

REM Create eBook Versions (epub, mobi)
magick -density 300 %dest_folder%/%filename%.pdf[0] %dest_folder%/ebook-cover.png
magick mogrify -size 2500x2500 -resize 2500x2500 Images\ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 images\ebook-cover.jpg
pandoc metadata.yaml -s --epub-cover-image=%dest_folder%/ebook-cover.png -o %dest_folder%/%filename%.epub %filename%.md
ebook-convert %dest_folder%/%filename%.epub %dest_folder%/%filename%.mobi
del %dest_folder%\ebook-cover.png
pause

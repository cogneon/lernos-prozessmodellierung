@echo off
echo Starting lernOS Guide Generation ...

REM Required Software
REM See lernOS Core tbd.

REM Variables
set filename="lernOS-Guide-en"

REM Delete Old Versions
del %filename%.docx %filename%.epub %filename%.mobi %filename%.html %filename%.pdf images\ebook-cover.png

REM Create Microsoft Word Version (docx)
pandoc -s -o %filename%.docx %filename%.md

REM Create Web Version (html)
pandoc -s --toc -o %filename%.html %filename%.md

REM Create PDF Version (pdf)
pandoc %filename%.md metadata/metadata.yaml -o %filename%.pdf --from markdown --template lernOS --number-sections -V lang=de-de

REM Create eBook Versions (epub, mobi)
magick -density 300 %filename%.pdf[0] ebook-cover.png
magick mogrify -size 2500x2500 -resize 2500x2500 ebook-cover.jpg
magick mogrify -crop 1563x2500+102+0 ebook-cover.jpg
pandoc metadata/metadata.yaml -s --epub-cover-image=ebook-cover.png -o %filename%.epub %filename%.md
ebook-convert %filename%.epub %filename%.mobi
del ebook-cover.jpg
del ebook-cover.png

pause

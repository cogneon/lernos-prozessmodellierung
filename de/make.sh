PATH=$PATH:/opt/homebrew/bin
echo Starting lernOS Guide Generation ...

# Variables
filename="lernOS-Prozessmodellierung-Guide-de"
chapters="./src/index.md ./src/1-0-Grundlagen.md ./src/1-1-Was-ist-Prozessmodellierung.md ./src/1-2-Warum-ein-Lernpfad-PM.md ./src/1-3-Aufbau-des-Lernpfads.md ./src/1-4-Lernunterlagen.md ./src/1-5-Ressourcen.md ./src/2-0-Lernpfad.md ./src/2-1-Kata-Grundlagen.md ./src/2-2-Kata-Happy-Path.md ./src/2-3-Kata-Entscheidungen.md ./src/2-4-Kata-Markierungen.md ./src/2-5-Kata-Pools-Lanes.md ./src/2-6-Kata-Unterprozesse.md ./src/2-7-Kata-Eventtypen.md ./src/2-8-Kata-DMN.md ./src/2-9-Kata-Datentypen.md ./src/2-10-Kata-DRD.md ./src/2-11-Kata-Meisterstueck.md ./src/2-12-Kata-Retrospektive.md ./src/3-0-Anhang.md"

# Delete Old Versions
echo Deleting old versions ...
rm -rf $filename.*
rm -rf ../docs/de/*
#rm -ff ../docs/de-slides/index.html

# Create Web Version (mkdocs)
echo Creating Web Version ...
mkdocs build

# Create Microsoft Word Version (docx)
echo Creating Word version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.docx $chapters

# Create HTML Version (html)
echo Creating HTML version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --number-sections -V lang=de-de -o $filename.html $chapters

# Create PDF Version (pdf)
echo Creating PDF version ...
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --template lernos --number-sections --toc -V lang=de-de -o $filename.pdf $chapters

# Create eBook Versions (epub, mobi)
echo Creating eBook versions ...
magick -density 300 $filename.pdf[0] src/images/ebook-cover.jpg
mogrify -size 2500x2500 -resize 2500x2500 src/images/ebook-cover.jpg
mogrify -crop 1563x2500+102+0 src/images/ebook-cover.jpg
pandoc metadata.yaml --from markdown -s --resource-path="./src" -F mermaid-filter --epub-cover-image=src/images/ebook-cover.jpg --number-sections --toc -V lang=de-de -o $filename.epub $chapters
ebook-convert $filename.epub $filename.mobi

# Create Slides (revealjs)
# echo Creating Presentation ...
# pandoc metadata.yaml --from markdown -s --resource-path="./src" -t revealjs -V theme=night -s ./slides/index.md -o ../docs/de-slides/index.html

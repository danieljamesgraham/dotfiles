#!/bin/sh

file=$1

filename=$(basename "$file" .md)

# mkdir -p ./pdf/

`pandoc $file -o ./$filename.pdf -V geometry:"left=25mm, right=25mm, top=25mm, bottom=25mm" \
									 -V papersize:a4 \
									 -V fontsize:11pt \
									 -V boxlinks:true \
									 -V header-includes:"\renewcommand{\familydefault}{\sfdefault}"` \
&& echo "Successfully converted $file to $filename.pdf"
# && open ./pdf/$filename.pdf

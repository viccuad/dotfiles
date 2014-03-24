# replaces a color in PDF document (useful for removing dark background for printing)
# usage:	remove_color input.pdf output.pdf
function uncolorpdf()
{
convert -density 300 "$1" -fill "rgb(255,255,255)" -opaque "rgb(0,0,0)" "$2"
}

# Concatenate PDF files	
# e.g. cat_pdfs -o combined.pdf file1.pdf file2.pdf file3.pdf
function cat_pdfs() { python '/System/Library/Automator/Combine PDF Pages.action/Contents/Resources/join.py' "$@" ; }


# Convert a single-page PDF to a hi-res PNG, at 300dpi
# If you skip this part: -density 300x300, you'll get a very lo-res image
function pdf2png()
{
convert -density 300x300 $1 $2
}
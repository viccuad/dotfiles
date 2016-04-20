# Create the image:
sudo -E DIST=experimental pbuilder create

# Use it:
DIST=experimental pbuilder (or gbp build-package, or whatever)

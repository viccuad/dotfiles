# syntax of .commands:
ftp://ftp.upload.debian.org/pub/UploadQueue/README


debuild -S # or debuild -sa -S if the orig tar is not in the ftp
debsign drumgizmo_source.changes
dput debomatic-arm64 drumgizmo.changes
dcut --host debomatic-arm64 -U drumgizmo.commands

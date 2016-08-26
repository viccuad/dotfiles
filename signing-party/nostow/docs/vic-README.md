
Online computer:
    $ export GNUPGHOME=/path/to/.gnupg
    $ caff --no-sign --no-export-old --no-mail     <ksp-fingerprints.txt
Offline computer:  $ caff --no-download --no-export-old --no-mail <ksp-fingerprints.txt
Online computer:  $ caff --no-download --no-sign --no-export-old <ksp-fingerprints.txt

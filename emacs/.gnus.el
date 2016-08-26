;; GNUS config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Make Gnus into an offline newsreader:
;; (setq gnus-agent t)

;; always list all subscribed groups even if they don't have messages currently:
;; (setq gnus-group-list-all-groups t) ;; TODO I don't know if this works


;; http://groups.google.com/group/gnu.emacs.gnus/browse_thread/thread/a673a74356e7141f
;; turn on mail icon
(setq display-time-use-mail-icon t)
(when window-system
  (setq gnus-sum-thread-tree-indent "  ")
  ;; (setq gnus-sum-thread-tree-root "") ;; "● ")
  (setq gnus-sum-thread-tree-root "● ")
  ;; (setq gnus-sum-thread-tree-false-root "") ;; "◯ ")
  (setq gnus-sum-thread-tree-false-root "◯ ")
  (setq gnus-sum-thread-tree-single-indent "◎ ")
  (setq gnus-sum-thread-tree-vertical        "│")
  (setq gnus-sum-thread-tree-leaf-with-other "├─► ")
  (setq gnus-sum-thread-tree-single-leaf     "╰─► "))
(setq gnus-summary-line-format
      (concat
       "%0{%U%R%z%}"               ;; status
       "%3{%}" "%1{%d%}" "%3{%}" ;; date
       ;; "%3{│%}" "%1{%d%}" "%3{│%}" ;; date
       "  "
       "%4{%-20,20f%}"             ;; name
       "  "
       "%3{%}"
       ;; "%3{│%}"
       " "
       "%1{%B%}"
       "%s\n"))
;; (setq gnus-summary-display-arrow t)

;; https://github.com/russell/dotfiles/blob/master/gnus
(setq gnus-score-over-mark ?↑)          ; ↑ ☀
(setq gnus-score-below-mark ?↓)         ; ↓ ☂
(setq gnus-ticked-mark ?⚑)
(setq gnus-dormant-mark ?⚐)
(setq gnus-expirable-mark ?♻)
(setq gnus-read-mark ?✓)
(setq gnus-del-mark ?✗)
(setq gnus-killed-mark ?☠)
(setq gnus-replied-mark ?↺)
(setq gnus-forwarded-mark ?↪)

(setq gnus-cached-mark ?☍)
(setq gnus-recent-mark ?★)
(setq gnus-unseen-mark ?✩)
(setq gnus-unread-mark ?✉)

(setq gnus-thread-sort-functions
      '((not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)))

;; use cache?
;; (setq gnus-use-cache t)

;; Fetch only part of the article if we can.
;; I saw this in someone's .gnus
;; (setq gnus-read-active-file 'some)

;; open attachment
;; (eval-after-load 'mailcap
;;   '(progn
;;      (cond
;;       ;; on OSX, maybe change mailcap-mime-data?
;;       ((eq system-type 'darwin))
;;       ;; on Windows, maybe change mailcap-mime-data?
;;       ((eq system-type 'windows-nt))
;;       (t
;;        ;; Linux, read ~/.mailcap
;;        (mailcap-parse-mailcaps)))));; Tree view for groups.  I like the organisational feel this has.


;; Read HTML mail
;; You need install the command line browser 'w3m' and Emacs plugin 'w3m'
(setq mm-text-html-renderer 'w3m
      mm-inline-text-html-with-images t
      mm-inline-text-html-with-w3m-keymap nil)


(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; (eval-after-load 'gnus-topic
;;   '(progn

;;      (setq gnus-topic-topology '(
;;              ("Gnus" visible nil nil)
;;              (("misc" visible nil nil))
;;              (("me@viccuad.me" visible nil nil))
;;              (("mail lists" visible nil nil))
;;              (("host" visible nil nil))))

;;      (setq gnus-topic-alist '(
;;              ("host"
;;               "nnml:mail.misc"
;;               "nnml+localhost:mail.misc")

;;              ("mail lists"
;;               "nntp+news.gmane.org:gmane.linux.debian.devel.general"
;;               "nntp+news.gmane.org:gmane.linux.debian.devel.announce")

;;              ("me@viccuad.me"
;;               "nnimap+gandi:INBOX"
;;               "nnimap+gandi:Sent"
;;               "nnimap+gandi:Drafts"
;;               "nnimap+gandi:Junk"
;;               "nnimap+gandi:Trash"
;;               "nnimap+gandi:jobs"
;;               "nnimap+gandi:Debian"
;;               "nnimap+gandi:Deb-multimedia"
;;               "nnimap+gandi:keysigning"
;;               "nnimap+gandi:Compras"
;;               "nnimap+gandi:I Love Me binder"
;;               "nnimap+gandi:Registros"
;;               "nnimap+gandi:Vault"
;;               "nnimap+gandi:Viajes")

;;              ("misc" "nndraft:drafts")

;;              ("Gnus" "nndraft:queue")))
;; ))


     ;; (setq gnus-message-archive-group '((format-time-string "sent.%Y")))
     ;; (setq gnus-server-alist '(("archive" nnfolder "archive" (nnfolder-directory "~/Mail/archive")
     ;;                            (nnfolder-active-file "~/Mail/archive/active")
     ;;                            (nnfolder-get-new-mail nil)
     ;;                            (nnfolder-inhibit-expiry t))))

     ;; (setq gnus-topic-topology '(("Gnus" visible)
     ;;                             (("misc" visible))
     ;;                             (("hotmail" visible nil nil))
     ;;                             (("gmail" visible nil nil))))

     ;; (setq gnus-topic-alist '(("hotmail" ; the key of topic
     ;;                           "nnimap+hotmail:Inbox"
     ;;                           "nnimap+hotmail:Drafts"
     ;;                           "nnimap+hotmail:Sent"
     ;;                           "nnimap+hotmail:Junk"
     ;;                           "nnimap+hotmail:Deleted")
     ;;                          ("gmail" ; the key of topic
     ;;                           "INBOX"
     ;;                           "[Gmail]/Sent Mail"
     ;;                           "[Gmail]/Trash"
     ;;                           "Sent Messages"
     ;;                           "Drafts")
     ;;                          ("misc" ; the key of topic
     ;;                           "nnfolder+archive:sent.2015-12"
     ;;                           "nnfolder+archive:sent.2016"
     ;;                           "nnfolder+archive:sent.2017"
     ;;                           "nndraft:drafts")

;; automatic linebreaking:
(defun my-message-mode-setup ()
  (setq fill-column 72)
  (turn-on-auto-fill))
(add-hook 'message-mode-hook 'my-message-mode-setup)

;; TODO notify if missing attachment
;; Checks that the mail contains an attached file if the body refers to it:
(defcustom check-no-missing-attachment-regexp "attach\w*\|adjunt\w*"
  "*A mail whose body matches this regular expression should contain
an attachment")

(defun contains-attachment (l)
  (and l (or (and
              (eq (car (car l)) 'part)
              (string= "attachment" (cdr (assoc 'disposition (cdr (car l))))))
             (contains-attachment (cdr l)))))

(defun check-no-missing-attachment ()
  "Checks the mail contains an attached file if the body refers to such an
attachment"
  (message-goto-body)
  (and (re-search-forward check-no-missing-attachment-regexp nil t)
       (not (contains-attachment (mml-parse)))
       (not (y-or-n-p "An attachment seems to be missing, send message ? "))
       (error "You refer to an unexisting attachment.")))

(add-hook 'message-send-hook 'check-no-missing-attachment)


;; open mail in web browser: TODO doesn't work
(defun my-gnus-summary-view-html-alternative ()
  "Display the HTML part of the current multipart/alternative MIME message
    in current browser."
  (interactive)
  (save-current-buffer
    (gnus-summary-show-article)
    (set-buffer gnus-article-buffer)
    (let ((file (make-temp-file "html-message-" nil ".html"))
          (handle (nth 3 (assq 1 gnus-article-mime-handle-alist))))
      (mm-save-part-to-file handle file)
      (browse-url (concat "file://" file)))))

(define-key gnus-summary-mode-map [?K ?H]
  'my-gnus-summary-view-html-alternative)


;; ACCOUNTS config ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-mail-address "me@viccuad.me"
      user-full-name "Víctor Cuadrado Juan")

;; primary ingoing server:
(setq gnus-select-method
      '(nnimap "gandi"
               (nnimap-address "mail.gandi.net")
               (nnimap-server-port "imaps")
               (nnimap-stream ssl)))

;; primary outgoing server:
(setq send-mail-function          'smtpmail-send-it
      message-send-mail-function  'smtpmail-send-it
      smtpmail-default-smtp-server "mail.gandi.net"
      smtpmail-smtp-server         "mail.gandi.net"
      smtpmail-smtp-service 465)

;; make gnus always use TLS:
(setq starttls-use-gnutls t)
(setq starttls-gnutls-program "gnutls-cli")
(setq starttls-extra-arguments nil)

;; Archive outgoing email in Sent folder on imap.gmail.com:
(setq gnus-message-archive-method '(nnimap "gandi")
    gnus-message-archive-group "nnimap:Sent")
    ;; gnus-message-archive-group "Sent")

;; Archive outgoing email in Sent folder on imap.gmail.com:
; (setq gnus-message-archive-method '(nnimap "imap.gmail.com")
;     gnus-message-archive-group "[Gmail]/Sent Mail")

;; set return email address based on incoming email address
(setq gnus-posting-styles
    '(((header "to" "me@viccuad.me")
       (address "me@viccuad.me"))
      ((header "to" "victorcuad@gmail.com")
       (address "me@viccuad.me"))
      ))

;; (add-to-list 'gnus-secondary-select-methods
;;              '(nnimap "gmail-second"
;;                       (nnimap-address "imap.gmail.com")
;;                       (nnimap-server-port 993)
;;                       (nnimap-stream ssl)
;;                       (nnir-search-engine imap)
;;                                         ; @see http://www.gnu.org/software/emacs/manual/html_node/gnus/Expiring-Mail.html
;;                       ;; press 'E' to expire email
;;                       (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash")
;;                       (nnmail-expiry-wait 90)))


; ;; store email in ~/gmail directory
; (setq nnml-directory "~/gmail")
; (setq message-directory "~/gmail")

;; (setq mail-sources '((pop :server "pop.provider.org"
;;                           :user "you")))

;; inbound servers:
;; (setq gnus-secondary-select-methods
;;       ‘((nnimap “mail.gandi.net” (nnimap-address "me@viccuad.me") (nnimap-server-port 993))))


;; (setq gnus-select-method '(nntp "gmane"
;;                                 (nntp-address "news.gmane.org")))

(add-to-list 'gnus-secondary-select-methods '(nnml "localhost"))
;; (add-to-list 'gnus-secondary-select-methods '((nntp "gmane" (nntp-address "news.gmane.org"))))
(add-to-list 'gnus-secondary-select-methods '(nntp "news.gmane.org"))
;; (add-to-list 'gnus-secondary-select-methods '(nntp "linux.debian.debian-devel@lists.debian.org" ))
                ;; (nntp "news.eternal-september.org")

                ;; (nntp "nntp.aioe.org")
                ;; (nntp "news.gwene.org")
                ;; ))

;; (add-to-list 'gnus-secondary-select-methods '(nntp "news.gnus.org"))
;; (add-to-list 'gnus-secondary-select-methods '(nnml ""))

; (setq gnus-secondary-select-methods
;       '(
;         (nntp "gmane"
;               (nntp-address "news.gmane.org"))
;         (nntp "news.eternal-september.org")

;         (nntp "nntp.aioe.org")
;         (nntp "news.gwene.org")
;         ))

;; signature:
;; https://www.gnu.org/software/emacs/manual/html_node/gnus/Posting-Styles.html
(setq gnus-posting-styles
      '((".*"
         (signature-file "~/.dotfiles/mail/nostow/viccuadme_signature")
        ;;  (name "User Name")
        ;;  (x-face-file "~/.xface")
        ;;  (x-url (getenv "WWW_HOME"))
        ;;  (organization "People's Front Against MWM"))
        ;; ("^rec.humor"
        ;;  (signature my-funny-signature-randomizer))
        ;; ((equal (system-name) "gnarly")  ;; A form
        ;;  (signature my-quote-randomizer))
        ;; (message-news-p        ;; A function symbol
        ;;  (signature my-news-signature))
        ;; (window-system         ;; A value symbol
        ;;  ("X-Window-System" (format "%s" window-system)))
        ;; ;; If I’m replying to Larsi, set the Organization header.
        ;; ((header "from" "larsi.*org")
        ;;  (Organization "Somewhere, Inc."))
        ;; ((posting-from-work-p) ;; A user defined function
        ;;  (signature-file "~/.work-signature")
        ;;  (address "user@bar.foo")
        ;;  (body "You are fired.\n\nSincerely, your boss.")
        ;;  ("X-Message-SMTP-Method" "smtp smtp.example.org 587")
        ;;  (organization "Important Work, Inc"))
        ;; ("nnml:.*"
        ;;  (From (with-current-buffer gnus-article-buffer
        ;;          (message-fetch-field "to"))))
        ;; ("^nn.+:"
         ))
      )

;; CONTACT MANAGER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; bbdb contact manager:
;; (require 'bbdb)
;; (require 'bbdb-autoloads)
;; (setq
;;  bbdb-file "~/.bbdb"
;;  bbdb-offer-save 'auto
;;  bbdb-notice-auto-save-file t
;;  bbdb-expand-mail-aliases t
;;  bbdb-canonicalize-redundant-nets-p t
;;  bbdb-always-add-addresses t
;;  bbdb-complete-name-allow-cycling t
;;  )

;; (setq bbdb-always-add-addresses t)
;; (setq bbdb/news-auto-create-p t)
;; (setq bbdb-dwim-net-address-allow-redundancy t)
;; (setq bbdb-complete-name-allow-cycling t)

;; BBDB: Address list
;; (add-to-list 'load-path "/where/you/place/bbdb/")
;; (require 'bbdb)
;; (bbdb-initialize 'message 'gnus 'sendmail)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-gnus)
;; (setq bbdb/mail-auto-create-p t
;;       bbdb/news-auto-create-p t)

;; ;; auto-complete emacs address using bbdb UI
;; (add-hook 'message-mode-hook
;;           '(lambda ()
;;              (flyspell-mode t)
;;              (local-set-key "<TAB>" 'bbdb-complete-name)))

;; GPG ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'epg-config)
;; (setq mml2015-use 'epg

;;       mml2015-verbose t
;;       epg-user-id gpgpgpkeyID
;;       mml2015-encrypt-to-self t
;;       mml2015-always-trust nil
;;       mml2015-cache-passphrase t
;;       mml2015-passphrase-cache-expiry '36000
;;       mml2015-sign-with-sender t

;;       gnus-message-replyencrypt t
;;       gnus-message-replysign t
;;       gnus-message-replysignencrypted t
;;       gnus-treat-x-pgp-sig t

;;       ;;       mm-sign-option 'guided
;;       ;;       mm-encrypt-option 'guided
;;       mm-verify-option 'always
;;       mm-decrypt-option 'always

;;       gnus-buttonized-mime-types
;;       '("multipart/alternative"
;;         "multipart/encrypted"
;;         "multipart/signed")

;;       epg-debug t ;;  then read the *epg-debug*" buffer
;; )

;; Debian goodies
(require 'gnus-BTS) ;; makes debian bug numbers clickable

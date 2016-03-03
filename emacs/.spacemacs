;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load. If it is the symbol `all' instead
   ;; of a list then all discovered layers will be installed.
   dotspacemacs-configuration-layers
   '(
     emacs-lisp
     (auto-completion :variables
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'cycle
                      auto-completion-complete-with-key-sequence nil
                      auto-completion-complete-with-key-sequence-delay 0.1
                      auto-completion-private-snippets-directory nil ;; use ~/.emacs.d/private/snippets
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-enable-help-tooltip t
                      auto-completion-enable-sort-by-usage t)
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default t
                     spell-checking-enable-auto-dictionary t ;; detect the current language from the buffer content
                     )
     syntax-checking
     ;; semantic ;; display current function interface at the top of the screen
     git
     (version-control :variables
                      version-control-global-margin t
                      version-control-diff-tool 'diff-hl
                      ;; version-control-diff-tool 'git-gutter+
                      )
     (colors :variables
             ;; colors-enable-rainbow-identifiers t
             ;; colors-enable-nyan-cat-progress-bar t
             )
     evil-cleverparens
     evil-commentary
     evil-snipe
     vinegar
     vim-empty-lines ;; TODO disable and look how tildes look at the end of file
     tmux
     ;; prodigy
     (c-c++ :variables
            c-c++-enable-clang-support t
            )
     extra-langs
     html
     (latex :variables
            latex-build-command "LatexMk -pdflatex='xelatex --shell-escape'"
            )
     markdown
     vimscript
     cscope
     python
     django
     shell-scripts
     sql
     emoji
     selectric
     speed-reading
     themes-megapack
     typography
     ;; theming
     ;; (geolocation :variables
     ;;              ;; geolocation-enable-osx-location-service-support t
     ;;              ;; geolocation-enable-weather-forecast t
     ;;              ;; geolocation-enable-automatic-theme-changer t
     ;;              )
     (golden-ratio :variables
                   setq golden-ratio-auto-scale t ;; for wide screens
                   )
     gnus
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      evil-terminal-cursor-changer ;; has been temporarily disabled: https://github.com/7696122/evil-terminal-cursor-changer/issues/8
                                      key-chord ;; to not have hiccups on the line with jk
                                      ;; xclip
                                      w3m      ;; for gnus
                                      smtpmail ;; for gnus
                                      highlight-chars
                                      )
   ;; A list of packages and/or extensions that will not be install and loaded.
   dotspacemacs-excluded-packages '(
                                    )
   ;; If non-nil spacemacs will delete any orphan packages, i.e. packages that
   ;; are declared in a layer which is not a member of
   ;; the list `dotspacemacs-configuration-layers'. (default t)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. (default t)
   dotspacemacs-check-for-update nil
   ;; One of `vim', `emacs' or `hybrid'. Evil is always enabled but if the
   ;; variable is `emacs' then the `holy-mode' is enabled at startup. `hybrid'
   ;; uses emacs key bindings for vim's insert mode, but otherwise leaves evil
   ;; unchanged. (default 'vim)
   dotspacemacs-editing-style 'vim
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in the startup buffer. If nil it is disabled.
   ;; Possible values are: `recents' `bookmarks' `projects'.
   ;; (default '(recents projects))
   dotspacemacs-startup-lists '(recents projects bookmarks)
   ;; Number of recent files to show in the startup buffer. Ignored if
   ;; `dotspacemacs-startup-lists' doesn't include `recents'. (default 5)
   dotspacemacs-startup-recent-list-size 10
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(
                         badwolf
                         monokai
                         spacemacs-dark
                         spacemacs-light
                         solarized-dark
                         solarized-light
                         leuven
                         zenburn)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state nil
   ;; Default font. `powerline-scale' allows to quickly tweak the mode-line
   ;; size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m)
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; (Not implemented) dotspacemacs-distinguish-gui-ret nil
   ;; The command key used for Evil commands (ex-commands) and
   ;; Emacs commands (M-x).
   ;; By default the command key is `:' so ex-commands are executed like in Vim
   ;; with `:' and Emacs commands are executed with `<leader> :'.
   dotspacemacs-command-key ":"
   ;; If non nil `Y' is remapped to `y$'. (default t)
   dotspacemacs-remap-Y-to-y$ t
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil then `ido' replaces `helm' for some commands. For now only
   ;; `find-files' (SPC f f), `find-spacemacs-file' (SPC f e s), and
   ;; `find-contrib-file' (SPC f e c) are replaced. (default nil)
   dotspacemacs-use-ido nil
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-micro-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters the
   ;; point when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling nil
   ;; If non nil line numbers are turned on in all `prog-mode' and `text-mode'
   ;; derivatives. If set to `relative', also turns on relative line numbers.
   ;; (default nil)
   dotspacemacs-line-numbers t
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil advises quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init'.  You are free to put almost
any user code here.  The exception is org related code, which should be placed
in `dotspacemacs/user-config'."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration. You are free to put any user code."


;;;; SPACEMACS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (spacemacs/toggle-evil-cleverparens-on)
  ;; (spacemacs/toggle-aggressive-indent-globally-on)

  ;; truncate lines in buffer (there is no hook for buffers and the setting is
  ;; buffer-local, so do it with other hooks):
  (add-hook 'prog-mode-hook 'spacemacs/toggle-truncate-lines-off)
  (add-hook 'text-mode-hook 'spacemacs/toggle-truncate-lines-off)
  ;; TODO after an autocompletion, the truncate-lines gets back on (open an issue)

  (setq powerline-default-separator 'utf-8)
  ;; (for other separators than arrows, use
  ;; powerline-utf-8-separator-left and powerline-utf-8-separator-right)

  (setq visible-bell t)  ;; Don't let Emacs hurt your ears

  ;; TODO: persistent undo history: https://github.com/syl20bnr/spacemacs/issues/774
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

;;;; FLYCHECK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (with-eval-after-load 'flycheck
  ;;   (flycheck-pos-tip-mode))

;;;; CURSOR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (blink-cursor-mode t)

  ;; invert colors of cursor to see chars better:
  '(etcc-use-color nil)
  '(cursor ((t (:inverse-video t))))

  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer))

;;;; LINUM and HL-LINE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; TODO fix: line numbers inherit underlines from the beginning of the line

  (setq hl-line-sticky-flag nil) ;; highlights the line about point in the selected window only

  (set-face-background 'linum  (face-attribute 'hl-line :background))

  ;; make current line number color, and add separation with hl-line:
  (defface my-linum-hl
    ;; `((t :inherit linum :background ,(face-background 'hl-line nil t))) ;; only background as hl-line
    `((t :inherit linum :foreground ,(face-foreground 'font-lock-string-face nil t)))  ;; current line number
    "Face for the current line number."
    :group 'linum)
  (defvar my-linum-format-string "%3d")
  (add-hook 'linum-before-numbering-hook 'my-linum-get-format-string)
  (defun my-linum-get-format-string ()
    (let* ((width (1+ (length (number-to-string
                               (count-lines (point-min) (point-max))))))
           (format (concat "%" (number-to-string width) "d ")))
      (setq my-linum-format-string format)))
  (defvar my-linum-current-line-number 0)
  (setq linum-format 'my-linum-format)
  (defun my-linum-format (line-number)
    (propertize (format my-linum-format-string line-number) 'face
                (if (eq line-number my-linum-current-line-number)
                    'my-linum-hl 'linum)))
  (defadvice linum-update (around my-linum-update)
    (let ((my-linum-current-line-number (line-number-at-pos)))
      ad-do-it))
  (ad-activate 'linum-update)

;;;; RULER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq
   fci-rule-column 81 ;; because the utf char is to the left
   fci-always-use-textual-rule t

   ;; not so good unicodes:
   ;; fci-rule-character ?\u2502 ;; full dash
   ;; fci-rule-character ?\u030d ;; little dash up
   ;; fci-rule-character ?\u0951 ;; little dash up
   ;; fci-rule-character ?\u05bc ;; little point middle
   ;; fci-rule-character ?\u0732 ;; two little points up and down

   ;; good unicodes:
   ;; fci-rule-character ?\u05d9 ;; little dash middle
   ;; fci-rule-character ?\u20d3 ;; medium slim dash middle
   ;; fci-rule-character ?\u05d5 ;; medium dash middle
   ;; fci-rule-character ?\u0964 ;; medium medium-slim dash middle

   ;; weird but slim unicodes: ð ð etc
   ;; fci-rule-character ?\u1d0da
   ;; fci-rule-character ?\u1d0db
   ;; fci-rule-character ?\u1d1c4
   ;; fci-rule-character ?\u1d1c3

   ;; fci-rule-character ?\u23a5 ;; right box vertical
   ;; fci-rule-character ?\u2503 ;; right box vertical
   fci-rule-character ?\u258E ;; left 1/4 block

   fci-rule-color (face-attribute 'hl-line :background)
   )

  ;; Activate column indicator as global mode, except for org-mode:
  (add-hook 'prog-mode-hook 'turn-on-fci-mode)
  (add-hook 'text-mode-hook 'turn-on-fci-mode)
  (add-hook 'org-mode-hook 'turn-off-fci-mode 'append)

;;;; VC GUTTER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq
   diff-hl-side 'right
   diff-hl-margin-mode t ;; so it works in TUI
   )

  ;; (set-face-background 'diff-hl-insert  (face-attribute 'default :background))
  ;; (set-face-background 'diff-hl-delete  (face-attribute 'default :background))
  ;; (set-face-background 'diff-hl-change  (face-attribute 'default :background))
  ;; (set-face-foreground 'diff-hl-change  "orange")

  ;; (git-gutter:linum-setup)

;;;; GIT ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (global-git-commit-mode t) ;; use spacemacs as $EDITOR for editing git commit messages:

;;;; WHITESPACE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (setq-default
  ;;  whitespace-line-column 80)

  ;; (spacemacs/toggle-whitespace-globally-on)
  (add-hook 'prog-mode-hook #'whitespace-mode)
  (add-hook 'text-mode-hook #'whitespace-mode)


  (setq whitespace-style '(
                           ;; via display table:
                           ;; space-mark
                           tab-mark
                           newline-mark
                           face
                           spaces            ;; SPACEs and HARD SPACEs
                           ;; lines          ;; lines that go past whitespace-line-column
                           ;; lines-tail     ;; part of lines that go past whitespace-line-column
                           tabs
                           newline
                           ;; empty             ;; empty lines at beginning and end of buffer
                           trailing        
                           ;; evaluated in this order:
                           indentation                ;; either 8 or more spaces, or tabs, depending on indent-tab-mode
                           ;; indentation::tab        ;; tabs at beginning of line
                           ;; indentation::space      ;; 8 or more spaces at beginning of line
                           ;; evaluated in this order:
                           space-after-tab            ;; 8 or more SPACEs after a TAB, if ‘indent-tabs-mode’ (which see) is non-nil; otherwise tabs
                           ;; space-after-tab::tab    ;; 8 or more SPACEs after a TAB
                           ;; space-after-tab::space  ;; TABs are visualized when occurs 8 or more SPACEs after a TAB
                           ;; evaluated in this order:
                           space-before-tab           ;; SPACEs before TAB, if ‘indent-tabs-mode’ (which see) is non-nil; otherwise, TABs
                           ;; space-before-tab::tab   ;; SPACEs before TAB
                           ;; space-before-tab::space ;; TABs are visualized when occurs SPACEs before TAB
                           )
        whitespace-display-mappings '(
                                      (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
                                      (newline-mark 10 [8629 10]) ; 10 LINE FEED
                                      ;; (tab-mark 9 [8594 9] [92 9])
                                      )
        )

  ;; (require 'highlight-chars)
  ;; (add-hook 'prog-mode-hook 'hc-highlight-tabs)
  ;; (custom-set-faces
  ;;  '(hc-tab ((t (:Strike-through "red")))))


  ;; (custom-set-faces
  ;;  '(whitespace-space ((t (:foreground "#363636"))))
  ;;  ;; '(whitespace-empty ((t (:foreground "firebrick" :background "SlateGray1"))))
  ;;  ;; '(whitespace-hspace ((t (:foreground "lightgray" :background "LemonChiffon3"))))
  ;;  ;; '(whitespace-line ((t (:foreground "black" :background "red"))))
  ;;  '(whitespace-newline ((t (:foreground "#363636"))))
  ;;  '(whitespace-space-after-tab ((t (:foreground "#363636"))))
  ;;  '(whitespace-space-before-tab ((t (:foreground "#363636"))))
  ;;  ;; '(whitespace-space-after-tab ((t (:foreground "black" :background "green"))))
  ;;  ;; '(whitespace-space-before-tab ((t (:foreground "black" :background "DarkOrange"))))
  ;;  '(whitespace-tab ((t (:foreground "#363636"))))
  ;;  '(whitespace-indentation ((t (:foreground "#363636"))))
  ;;  ;; '(whitespace-trailing ((t (:foreground "red" :background "yellow"))))
  ;;  )


  ;; TODO: add lines to highlight whitespace-tab
  ;; wasamasa's proof of concept for highlighting tabs with lines:
  ;; https://gist.github.com/wasamasa/9e3afb228d8694383e22#file-hl-tab-el-L1
  ;; (defface hl-tab-line
  ;;   '((((type graphic)) :strike-through t)
  ;;     (((type tty)) :underline t))
  ;;   "Tab line")

  ;; (defun hl-tab-fontify (beg end)
  ;;   (let ((bol (save-excursion (goto-char beg) (line-beginning-position)))
  ;;         (eol (save-excursion (goto-char end) (line-end-position))))
  ;;     (save-excursion
  ;;       (goto-char bol)
  ;;       (while (search-forward-regexp "^\t+" eol t)
  ;;         (with-silent-modifications
  ;;           (add-text-properties (line-beginning-position) (point)
  ;;                               '(font-lock-face hl-tab-line)
  ;;                               (current-buffer)))))))

  ;; (defun hl-tab-unfontify ()
  ;;   (save-excursion
  ;;     (goto-char (point-min))
  ;;     (while (search-forward-regexp "^\t+" (point-max) t)
  ;;       (with-silent-modifications
  ;;         (remove-text-properties (line-beginning-position) (point)
  ;;                                 '(font-lock-face hl-tab-line)
  ;;                                 (current-buffer))))))

  ;; (define-minor-mode hl-tab-mode
  ;;   "Highlight tabs with a line."
  ;;   :lighter "\\t"
  ;;   (if hl-tab-mode
  ;;       (jit-lock-register 'hl-tab-fontify)
  ;;     (jit-lock-unregister 'hl-tab-fontify)
  ;;     (hl-tab-unfontify)))


;;;; HIGHLIGHT TROLL CHARS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; TODO: http://www.emacswiki.org/emacs/ShowWhiteSpace#toc3
  ;; call matchadd('ErrorMsg', '[^\d0-\d127]')
  ;; highlights weird unicode chars that try to pass as
  ;; normal. eg:↵ ⅰnt ⅿain() { рrintf ("Ηello troll!\n");

;;;; VIM ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; use key-chord instead of evil-escape to not have hiccups on the line:
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)

  (setq
   evil-escape-key-sequence "jk" ;; but also use evil-escape to escape from "everything" in Emacs
   ;;   evil-escape-delay 0.1
   evil-want-fine-undo nil ;; use vim undo, to undo last insert mode as a chunk:
   ;; evil-move-cursor-back nil ;; don't move cursor back when going to normal mode from insert
   )

  (fset 'evil-visual-update-x-selection 'ignore) ;; prevent visual selections to override system clipboard:

  ;; make j & k behave as g j & g k:
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

;;;; COMMENTS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (set-face-italic 'font-lock-comment-face t)

;;;; END OF FILE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq ;; insert newline at the end of the file automatically
   require-final-newline t
   mode-require-final-newline t)

;;;; COLORS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (add-hook 'css-mode-hook 'rainbow-mode)  ;; Rainbow mode for css automatically
  ;; (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)  ;; Rainbow delimiters for all prog modes

;;;; CLIPBOARD ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; use xclip to make system clipboard available:
  (unless window-system
    (when (getenv "DISPLAY")
      (defun xclip-cut-function (text &optional push)
        (with-temp-buffer
          (insert text)
          (call-process-region (point-min) (point-max) "xclip" nil 0 nil "-i" "-selection" "clipboard")))
      (defun xclip-paste-function()
        (let ((xclip-output (shell-command-to-string "xclip -o -selection clipboard")))
          (unless (string= (car kill-ring) xclip-output)
            xclip-output )))
      (setq interprogram-cut-function 'xclip-cut-function)
      (setq interprogram-paste-function 'xclip-paste-function)
      ))

;;;; LANGUAGES ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq c-default-style "linux")  ;; or k&r for example

  ;; TODO enable spell checking for text modes

;;;; WIDTH ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (setq-default tab-width 4)  ;; set default tab char's display width to 4 spaces

  ;; TAB key:
  ;; (setq-default tab-always-indent t)         ;; make tab key always call a indent command.
  ;; (setq-default tab-always-indent nil)       ;; make tab key call indent command or insert tab character, depending on cursor position
  ;; (setq-default tab-always-indent 'complete) ;; make tab key do indent first then completion.


;;;; ORG-MODE ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (with-eval-after-load 'org
    ;; here goes your Org config :)
    (setq org-agenda-files (list "")
          org-todo-keywords '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE"))
          ;; http://members.optusnet.com.au/~charles57/GTD/gtd_workflow.html
          org-tag-alist '(("@work" . ?w) ("@home" . ?h) ("debian" . ?l)))
  )

;;;; TODO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; fix zshenv warning
  ;; fix ~ at the end of the buffer
  ;; emacs doesn't see debian-el editing d/control etc as prog-mode nor text-mode
  ;; try autocompletion with the other engine
  ;; wrap
  ;; color of the brackets, I don't know which one I am on?
  ;; get autocompletion tooltips on terminal https://github.com/expez/company-quickhelp/issues/24
  ;; mouse on terminal
  ;; fix colors on diffs and patches
  ;; CTRL + hjkl to move inside emacs windows/buffers


)
;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.

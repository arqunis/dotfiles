;;; init.el --- Emacs configuration -*- lexical-binding: t; no-byte-compile: t; no-native-compile: t; no-update-autoloads: t; -*-

;; Store customised options in a separate file.
(defconst custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Silence warnings from byte compilation and native compilation of Elisp code to reduce noise.
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local)
      native-comp-async-report-warnings-errors nil
      load-prefer-newer t)

;; Disable backup files.
(setq make-backup-files nil
      auto-save-default nil)

;; Allow specifying =y= or =n= for confirmation/aborting.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Add highlighting to pairs of parentheses.
(show-paren-mode 1)

;; Auto refresh buffers of files that were changed outside of Emacs.
(global-auto-revert-mode 1)

;; Treat sentences as a string of characters terminated with a full
;; stop and an optional space.
(setq sentence-end-double-space nil)

;; Mimic scrolling behaviour of other text editors (i.e. moving to the next line
;; that is out of view shifts the view one line up and vice versa).
(setq scroll-conservatively 100)

;; Maintain a three line margin before and after the cursor (if lines are available).
(setq scroll-margin 3)

;; Mimic text selection behaviour of other text editors (i.e. inserting text
;; when a region is selected replaces it).
(delete-selection-mode t)

;; Configure deletion backwards to remove all whitespaces.
(setq backward-delete-char-untabify-method 'hungry)

;; Disable addition of a newline when trying to move to the next line at the end of a buffer.
(setq next-line-add-newlines nil)

;; Indent only with spaces.
(setq indent-tabs-mode nil)

;; Define the width of a "tab" as 4 characters.
(setq tab-width 4)

;; Indent and complete text with the TAB key.
(setq tab-always-indent 'complete)

;; Show a maximum of 3 items when asking to complete text.
(setq completion-cycle-threshold 3)

;; Use Java-style braces by default in =c-mode= buffers.
(setq c-default-style "java")

;; Define indentation size as 4 characters in =c-mode= buffers.
(setq c-basic-offset 4)

;; Remove trailing whitespace when saving a buffer.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable absolute line numbers only in `prog-mode` buffers.
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode)))

;; Allow saving variables across Emacs instances.
(savehist-mode)

(load (expand-file-name "alex/keybindings.el" user-emacs-directory))
(load (expand-file-name "alex/elpaca.el" user-emacs-directory))
(load (expand-file-name "alex/modeline.el" user-emacs-directory))

(when (display-graphic-p)
  (load (expand-file-name "alex/gui.el" user-emacs-directory)))

(use-package use-package
  :custom
  (use-package-compute-statistics t))

;; Emulate Vim keybindings.
(when (< emacs-major-version 28)
  (use-package undo-fu
    :ensure t))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)
  (evil-undo-system (if (< emacs-major-version 28) 'undo-fu 'undo-redo))
  (evil-search-module 'evil-search))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-items '((recents . 15)))
  (dashboard-set-file-icons nil)
  (dashboard-set-heading-icons nil))

;; Show a prompt when leaving a keybinding unfinished to display which
;; options are available.
(use-package which-key
  :ensure t
  :custom (which-key-idle-delay 1)
  :config (which-key-mode 1))

;; Enhance text navigation.
(use-package expand-region
  :ensure t
  :bind ("C-q" . er/expand-region))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

;; Configure vertico and marginalia as Emacs's completion system.
(use-package vertico
  :ensure t
  :custom (vertico-cycle t)
  :config (vertico-mode 1))

(use-package marginalia
  :ensure t
  :after vertico
  :config (marginalia-mode 1))

;; Add EditorConfig support.
(use-package editorconfig
  :ensure t
  :config (editorconfig-mode 1))

;; Use tree-sitter for accurate syntax highlighting.
;; Emacs 29 integrates tree-sitter natively. Only use the external
;; package when running an older emacs.
(unless (>= emacs-major-version 29)
  (use-package tree-sitter
    :ensure t
    :config
    (global-tree-sitter-mode))

  (use-package tree-sitter-langs
    :ensure t
    :hook (tree-sitter-after-on . tree-sitter-hl-mode)))

;; Use Corfu for text completion in buffers.
(use-package corfu
  :ensure (corfu :files (:defaults "extensions/*")
                 :includes (corfu-info corfu-history corfu-popupinfo))
  :custom
  (corfu-cycle t)
  (coru-preselect 'prompt)
  (corfu-popupinfo-delay '(1.0 . 1.0))
  (corfu-preview-current nil)
  (corfu-quit-no-match t)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :hook
  (corfu-mode . corfu-popupinfo-mode)
  (corfu-mode . corfu-history-mode)
  :init
  (add-to-list 'savehist-additional-variables 'corfu-history)
  :config
  (global-corfu-mode))

(use-package kind-icon
  :ensure t
  :after corfu
  :custom (kind-icon-default-face 'corfu-default)
  :config (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

(use-package corfu-terminal
  :ensure (:repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
  :unless (display-graphic-p)
  :after corfu
  :config (corfu-terminal-mode +1))

;;; init.el ends here

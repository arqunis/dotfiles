;;; init.el --- Emacs configuration  -*- lexical-binding: t; -*-

;; Store customised options in a separate file to avoid committing to VCS.
(defconst custom-file (expand-file-name "custom.el" user-emacs-directory))
(unless (file-exists-p custom-file)
  (write-region "" nil custom-file))
(load custom-file)

;; Restore GC settings that were changed in =early-init.el=.
(add-hook 'after-init-hook (lambda ()
                              (setq gc-cons-threshold 16777216
                                    gc-cons-percentage 0.1)))

;; Configure the maximum amount of data Emacs can read from a process to
;; 1 MiB.
(setq read-process-output-max (* 1 1024 1024))

;; Silence warnings from byte compilation and native compilation of Elisp code to reduce noise.
(setq byte-compile-warnings '(not free-vars unresolved noruntime lexical make-local)
      native-comp-async-report-warnings-errors nil
      load-prefer-newer t)

;; Disable the ring bell, which activates upon an illegal operation.
(setq ring-bell-function 'ignore)

;; Disable backup files to reduce file clutter.
(setq make-backup-files nil
      auto-save-default nil)

;; Enforce UTF-8 everywhere.
(set-charset-priority 'unicode)
(setq locale-coding-system 'utf-8
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-process-coding-system '(utf-8-unix . utf-8-unix))

;; Resize frames pixel-wise.
(setq frame-resize-pixelwise t)

;; Allow specifying =y= or =n= for confirmation/aborting.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Add highlighting to pairs of parentheses.
(show-paren-mode 1)

;; Enable line and column numbers in the modeline.
(setq line-number-mode t
      column-number-mode t)

;; Enable absolute line numbers only in `prog-mode` buffers.
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode)))

;; Set the GUI font to whatever the monospace font is.
(add-to-list 'default-frame-alist '(font . "monospace-12"))

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

;; Remove trailing whitespace when saving a buffer.
(add-hook 'before-save-hook 'delete-trailing-whitespace)

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

;; Custom keybindings.
(defun kill-current-buffer ()
  "Kill the current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

(global-set-key (kbd "C-x k") 'kill-current-buffer)
(global-set-key (kbd "C-x b") 'ibuffer)

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C-+") 'text-scale-decrease)

;; Configure the straight.el package manager, and bootstrap it if it hasn't been installed yet.
(setq straight-vc-git-default-clone-depth 1
      straight-check-for-modifications nil)

(defvar bootstrap-version)
(let ((straight-install-file "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el")
      (bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously straight-install-file 'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

;; GC magic hack for better performance.
(use-package gcmh
  :straight t
  :config (gcmh-mode 1))

;; When in the GUI, use Catppuccin's Macchiato theme.
(when (display-graphic-p)
  (use-package catppuccin-theme
    :straight t
    :config (load-theme 'catppuccin t)
    :custom
    (catppuccin-flavor 'macchiato)))

(use-package dashboard
  :straight t
  :init
  (dashboard-setup-startup-hook)
  :custom
  (dashboard-items '((recents . 15)))
  (dashboard-set-file-icons nil)
  (dashboard-set-heading-icons nil))

(use-package doom-modeline
  :straight t
  :config (doom-modeline-mode 1)
  :custom
  (doom-modeline-icon nil))

;; Show a prompt when leaving a keybinding unfinished to display which
;; options are available.
(use-package which-key
  :straight t
  :config (which-key-mode 1)
  :custom (which-key-idle-delay 1))

;; Enhance text navigation.
(use-package expand-region
  :straight t
  :bind ("C-q" . er/expand-region))

(use-package avy
  :straight t
  :bind ("M-s" . avy-goto-char))

;; Add EditorConfig support.
(use-package editorconfig
  :straight t
  :init (editorconfig-mode 1))

;; Configure vertico and marginalia as Emacs's completion system.
(use-package vertico
  :straight t
  :config (vertico-mode 1)
  :custom (vertico-cycle t))

(use-package marginalia
  :straight t
  :after vertico
  :config (marginalia-mode 1))

;; Add support for more major modes.

; Major mode for the D programming language.
(use-package d-mode
  :straight t)

; Major mode for the Odin programming language.
(straight-use-package
  '(odin-mode :type git :host github :repo "mattt-b/odin-mode"))

; Major mode for the Zig programming language.
(use-package zig-mode
  :straight t)

; Major mode for the Nim programming language.
(use-package nim-mode
  :straight t)

; Major mode for the TOML configuration language.
(use-package toml-mode
  :straight t)

; Major mode for CMake's scripting language.
(use-package cmake-mode
  :straight t)

; Major mode for Meson's scripting language.
(use-package meson-mode
  :straight t)

;; Emulate Vim keybindings.
(use-package undo-fu
  :straight t)

(use-package evil
  :straight t
  :after undo-fu
  :config
  (evil-mode 1)
  (add-to-list 'evil-emacs-state-modes 'dired-mode)
  :custom
  (evil-want-integration t)
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-C-i-jump nil)
  (evil-undo-system 'undo-fu)
  (evil-search-module 'evil-search))

;; Use tree-sitter for accurate syntax highlighting.
; Emacs 29 integrates tree-sitter natively. Only use the external
; package when running an older emacs.
(if (version< emacs-version "29.0")
  (use-package tree-sitter
    :straight t
    :init
    (global-tree-sitter-mode))

  (use-package tree-sitter-langs
    :straight t
    :hook (tree-sitter-after-on . tree-sitter-hl-mode)))

;; Use Corfu for text completion in buffers.
(use-package corfu
  :straight (corfu :files (:defaults "extensions/*")
                   :includes (corfu-popupinfo))
  :custom
  (corfu-cycle t)
  (coru-preselect 'prompt)
  (corfu-popupinfo-delay '(1.0 . 1.0))
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-popupinfo-mode))

(straight-use-package
 '(corfu-terminal
   :type git
   :repo "https://codeberg.org/akib/emacs-corfu-terminal.git"))

(straight-use-package
 '(corfu-doc-terminal
   :type git
   :repo "https://codeberg.org/akib/emacs-corfu-doc-terminal.git"))

(unless (display-graphic-p)
  (corfu-terminal-mode +1)
  (corfu-doc-terminal-mode +1))

(use-package kind-icon
  :straight t
  :after corfu
  :custom (kind-icon-default-face 'corfu-default)
  :config
  (add-to-list 'corfu-margin-formatters #'kind-icon-margin-formatter))

;; Show emoji images when their Unicode data is present in a file.
(use-package emojify
  :straight t
  :init (global-emojify-mode 1))

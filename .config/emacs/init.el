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

;; Set the GUI font to the mononoki font, or whatever the monospace font is.
(defun font-exists-p (font)
  "Check if FONT exists. Returns t if it does, nil otherwise."
  (interactive)
  (not (null (x-list-fonts font))))

(when (display-graphic-p)
  (cond ((font-exists-p "mononoki") (add-to-list 'default-frame-alist '(font . "mononoki-12")))
	(t (add-to-list 'default-frame-alist '(font . "monospace-12")))))


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

;; Allow saving variables across Emacs instances.
(savehist-mode)

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

;; Elpaca package manager.
(defvar elpaca-installer-version 0.8)
(defvar elpaca-directory (expand-file-name "elpaca/" user-emacs-directory))
(defvar elpaca-builds-directory (expand-file-name "builds/" elpaca-directory))
(defvar elpaca-repos-directory (expand-file-name "repos/" elpaca-directory))
(defvar elpaca-order '(elpaca :repo "https://github.com/progfolio/elpaca.git"
                              :ref nil :depth 1
                              :files (:defaults "elpaca-test.el" (:exclude "extensions"))
                              :build (:not elpaca--activate-package)))
(let* ((repo  (expand-file-name "elpaca/" elpaca-repos-directory))
       (build (expand-file-name "elpaca/" elpaca-builds-directory))
       (order (cdr elpaca-order))
       (default-directory repo))
  (add-to-list 'load-path (if (file-exists-p build) build repo))
  (unless (file-exists-p repo)
    (make-directory repo t)
    (when (< emacs-major-version 28) (require 'subr-x))
    (condition-case-unless-debug err
        (if-let* ((buffer (pop-to-buffer-same-window "*elpaca-bootstrap*"))
                  ((zerop (apply #'call-process `("git" nil ,buffer t "clone"
                                                  ,@(when-let* ((depth (plist-get order :depth)))
                                                      (list (format "--depth=%d" depth) "--no-single-branch"))
                                                  ,(plist-get order :repo) ,repo))))
                  ((zerop (call-process "git" nil buffer t "checkout"
                                        (or (plist-get order :ref) "--"))))
                  (emacs (concat invocation-directory invocation-name))
                  ((zerop (call-process emacs nil buffer nil "-Q" "-L" "." "--batch"
                                        "--eval" "(byte-recompile-directory \".\" 0 'force)")))
                  ((require 'elpaca))
                  ((elpaca-generate-autoloads "elpaca" repo)))
            (progn (message "%s" (buffer-string)) (kill-buffer buffer))
          (error "%s" (with-current-buffer buffer (buffer-string))))
      ((error) (warn "%s" err) (delete-directory repo 'recursive))))
  (unless (require 'elpaca-autoloads nil t)
    (require 'elpaca)
    (elpaca-generate-autoloads "elpaca" repo)
    (load "./elpaca-autoloads")))
(add-hook 'after-init-hook #'elpaca-process-queues)

(when (string= system-type "windows-nt")
  (elpaca-no-symlink-mode))

(elpaca `(,@elpaca-order))

(elpaca elpaca-use-package
  ;; Enable use-package :ensure support for Elpaca.
  (elpaca-use-package-mode))

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
  ;; :bind
  ;; (:map evil-normal-state-map ("C-M-z" . evil-emacs-state))
  ;; (:map evil-emacs-state-map ("C-M-z" . evil-normal-state))
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

(use-package doom-modeline
  :ensure t
  :custom (doom-modeline-icon nil)
  :config (doom-modeline-mode 1))

;; When in the GUI, use Catppuccin's Macchiato theme.
(use-package catppuccin-theme
  :ensure t
  :if (display-graphic-p)
  :custom (catppuccin-flavor 'macchiato)
  :config (load-theme 'catppuccin t))

;; Show emoji images when their Unicode data is present in a file.
(use-package emojify
  :ensure t
  :if (display-graphic-p)
  :config (global-emojify-mode 1))

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

;; Add support for more major modes.

;; Major mode for the D programming language.
(use-package d-mode
  :ensure t
  :mode ("\\.d'" "\\.di'"))

;; Major mode for the Odin programming language.
(use-package odin-mode
  :ensure (:host github :repo "mattt-b/odin-mode")
  :mode "\\.odin'")

;; Major mode for the Zig programming language.
(use-package zig-mode
  :ensure t
  :mode "\\.zig'")

;; Major mode for the TOML configuration language.
(use-package toml-mode
  :ensure t
  :mode "\\.toml'")

;; Major mode for CMake's scripting language.
(use-package cmake-mode
  :mode ("CMakeLists\\.txt\\'" "\\.cmake\\'"))

;; Major mode for Meson's scripting language.
(use-package meson-mode
  :ensure t
  :mode ("meson\\.build\\'" "meson_options\\.txt'" "meson\\.options'"))

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

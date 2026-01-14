;;; modeline.el --- Modeline configuration -*- lexical-binding: t; -*-

;; Enable line and column numbers in the modeline.
(setq line-number-mode t
      column-number-mode t)

;; Use DOOM Emacs' modeline.
(use-package doom-modeline
  :ensure t
  :custom (doom-modeline-icon nil)
  :config (doom-modeline-mode 1))

;;; modeline.el ends here

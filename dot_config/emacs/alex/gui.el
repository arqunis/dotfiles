;;; gui.el --- Configuration when Emacs is running in a GUI -*- lexical-binding: t; -*-

(defun alex/font-exists-p (font)
  "Check if FONT exists. Returns t if it does, nil otherwise."
  (interactive)
  (not (null (x-list-fonts font))))

;; Resize frames pixel-wise.
(setq frame-resize-pixelwise t)

;; Set the GUI font to the mononoki font, or whatever the monospace font is.
(add-to-list 'default-frame-alist `(font . ,(if (alex/font-exists-p "mononoki") "mononoki-12" "monospace-12")))

;; Use Catppuccin's Macchiato theme.
(use-package catppuccin-theme
  :ensure t
  :custom (catppuccin-flavor 'macchiato)
  :config (load-theme 'catppuccin t))

;; Show emoji images when their Unicode data is present in a file.
(use-package emojify
  :ensure t
  :config (global-emojify-mode 1))

;;; gui.el ends here

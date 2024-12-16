;;; early-init.el -*- lexical-binding: t; no-byte-compile: t; no-native-compile: t; no-update-autoloads: t; -*-

;; Keep as many messages in the =*Message*= buffer.
(setq message-log-max t)

;; Disable `package.el`. Elpaca will be used instead.
(setq package-enable-at-startup nil
      package-quickstart nil)

;; Disable GUI elements.
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Disable the startup message.
(setq inhibit-startup-message t)

;; Disable the ring bell.
(setq ring-bell-function 'ignore)

;; Disable pop-up UI dialogs.
(setq use-dialog-box nil)

;; Use UTF-8.
(set-default-coding-systems 'utf-8)

;;; early-init.el ends here

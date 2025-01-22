;;; early-init.el -*- lexical-binding: t; no-byte-compile: t -*-

;; Keep as many messages in the =*Message*= buffer.
(setq message-log-max t)

;; Optimise the garbage collector for startup times.
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; Disable package management via package.el. We are going to be using Elpaca instead.
(setq package-enable-at-startup nil
      package-quickstart nil)

;; Resizing the Emacs frame can be a terribly expensive part of changing the
;; font. By inhibiting this, we easily halve startup times with fonts that are
;; larger than the system default.
(setq frame-inhibit-implied-resize t)

;; Disable GUI elements.
(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

;; Compile packages ahead of time.
(setq comp-deferred-compilation nil)

;; Disable the startup message.
(setq inhibit-startup-message t)

;;; early-init.el ends here

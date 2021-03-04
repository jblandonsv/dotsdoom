;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jaime Blandón"
      user-mail-address "blandontechnology@gmail.com")

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(setq projectile-project-search-path '("~/proyectosFiverr/"))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-molokai)
(setq doom-theme 'doom-outrun-electric)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(use-package pyvenv
  :ensure t
  :init (setenv "WORKON_HOME" "/opt/anaconda3/envs/")
  :custom
  (pyvenv-mode 1))

(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  :bind
  ("C-j" . centaur-tabs-backward)
  ("C-k" . centaur-tabs-forward))


(centaur-tabs-headline-match)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)

(set-face-attribute 'default nil :height 150)



(defun fate-lsp-setup-python ()
  "Microsoft Python Language Server does not have a syntax checker, setup one for it."
  (progn
    (require 'lsp-python-ms)
    (lsp)
    ;; https://github.com/flycheck/flycheck/issues/1762#issuecomment-626210720
    ;; Do not let lsp hijack flycheck
    (setq-local lsp-diagnostics-provider :none)
    (setq-local flycheck-checker 'python-flake8)))


(use-package lsp-mode
  :diminish lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  ((python-mode . fate-lsp-setup-python)))

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Jaime Blandón"
      user-mail-address "blandon.jaime@gmail.com")

(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-to-list 'custom-theme-load-path "/~/.doom.d/themes/")

;; (require 'zerodark-theme)
(setq projectile-project-search-path '("~/projects/" "~/testlabs/"))

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
;; (setq doom-font (font-spec :family "monospace" :size 16 :weight 'semi-light)
(setq doom-font (font-spec :family "Monaco" :size 15 :weight 'semi-light)
       doom-variable-pitch-font (font-spec :family "PT Sans" :size 14))
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the

;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-molokai)
;; (setq doom-theme 'doom-outrun-electric)
;; (setq doom-theme 'zerodark)
;; (setq doom-theme 'panda)
(setq doom-theme 'misterioso)

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

;; to make this thing work:
;; 1. Install .net cross platform for mac os: https://learn.microsoft.com/en-us/dotnet/core/install/macos
;; 2. Install mono and omnisharp-roslyn lsp run file following the section "Manual installation on macOS with brew": https://github.com/OmniSharp/omnisharp-emacs/blob/master/doc/server-installation.md
;; 3. Download manually the latest version of omnisharp-roslyn release zip file and unzip it in ~/.emacs.d/.local/etc/lsp/omnisharp-roslyn/latest/omnisharp-roslyn, edit the run file to give the correspoing path to the exe file
;; 4. intall rider2emacs to configure the external tool path: https://github.com/elizagamedev/rider2emacs
(use-package omnisharp
  :ensure t)

(setq omnisharp-server-executable-path "/usr/local/bin/omnisharp")
(use-package pyvenv
  :ensure t
  ;; :init (setenv "WORKON_HOME" "/opt/anaconda3/envs/")
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
(setq treemacs-text-scale -1)

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



(after! lsp-rust
  (setq lsp-rust-server 'rust-analyzer))


;; (use-package dap-gdb-lldb)

(after! dap-mode
  (setq dap-python-debugger 'debugpy))


;;;; Debugging
;; GDB settings
(setq gdb-show-main t
      gdb-many-windows t)

(setq pdb-show-main t
      pdb-many-windows t)
;
;;
;; (use-package! realgud-lldb
;;   :defer t
;;   :init (add-to-list '+debugger--realgud-alist
;;                      '(realgud:lldb :modes (c-mode c++-mode rust-mode)
;;                                     :package realgud-lldb)))

;;  (use-package exec-path-from-shell
;;    :ensure
;;    :init (exec-path-from-shell-initialize))



;; (require 'dap-lldb)
;; (require 'dap-gdb-lldb)
;;
;;
;;
;;

;; (dap-register-debug-template "Rust::GDB Project Run Configuration"
;;                              (list :type "gdb"
;;                                    :request "launch"
;;                                    :name "Custom GDB::Run"
;;                            :gdbpath "rust-gdb"
;;                                    :target nil
;;                                    :cwd nil))


;; (dap-register-debug-template "Rust::GDB CUSTOM Run Configuration"
;;                               (list :type "gdb"
;;                                     :request "launch"
;;                                     :name "GDB::Run"
;;                             :gdbpath "rust-gdb"
;;                                     :target nil
;;                                     :cwd nil))



;; (setq dap-cpptools-extension-version "1.5.1")
;;   (with-eval-after-load 'lsp-rust
;;     (require 'dap-cpptools))
;;   (with-eval-after-load 'dap-cpptools
;;     ;; Add a template specific for debugging Rust programs.
;;     ;; It is used for new projects, where I can M-x dap-edit-debug-template
;;     (dap-register-debug-template "Rust::GDB Run Configuration"
;;                              (list :type "gdb"
;;                                    :request "launch"
;;                                    :name "GDB::Run"
;;                            :gdbpath "rust-gdb"
;;                                    :target nil
;;                                    :cwd nil)))


    ;; (dap-register-debug-template "Rust::CppTools Run Configuration"
    ;;                              (list :type "cppdbg"
    ;;                                    :request "launch"
    ;;                                    :name "Rust::Run"
    ;;                                    :MIMode "gdb"
    ;;                                    :miDebuggerPath "rust-gdb"
    ;;                                    :environment []
    ;;                                    :program "${workspaceFolder}/target/debug/hello-cargo"
    ;;                                    :cwd "${workspaceFolder}"
    ;;                                    :console "external"
    ;;                                    :dap-compilation "cargo build"
    ;;                                    :dap-compilation-dir "${workspaceFolder}")))
  ;;(with-eval-after-load 'dap-mode
  ;;  (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
  ;;  (dap-auto-configure-mode +1))

;; (setq dap-cpptools-extension-version "1.5.1")
;;
;;   (with-eval-after-load 'lsp-rust
;;     (require 'dap-cpptools))
;;
;;   (with-eval-after-load 'dap-cpptools
;;     ;; Add a template specific for debugging Rust programs.
;;     ;; It is used for new projects, where I can M-x dap-edit-debug-template
;;     (dap-register-debug-template "Rust::CppTools Run Configuration"
;;                                  (list :type "cppdbg"
;;                                        :request "launch"
;;                                        :name "Rust::Run"
;;                                        :MIMode "gdb"
;;                                        :miDebuggerPath "rust-gdb"
;;                                        :environment []
;;                                        :program "${workspaceFolder}/target/debug/hello-cargo"
;;                                        :cwd "${workspaceFolder}"
;;                                        :console "external"
;;                                        :dap-compilation "cargo build"
;;                                        :dap-compilation-dir "${workspaceFolder}")))
;;
;;   (with-eval-after-load 'dap-mode
;;     (setq dap-default-terminal-kind "integrated") ;; Make sure that terminal programs open a term for I/O in an Emacs buffer
;;     (dap-auto-configure-mode +1))

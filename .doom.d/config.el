;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
;;(straight-use-package 'org)


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com"
      projectile-project-search-path '("~/dev/workspace/"))

(setq doom-projectile-fd-binary (executable-find "fdfind"))

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Liberation Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Liberation Mono" :size 13))
;;(setq doom-font (font-spec :family "Fira Code" :size 14 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(menu-bar--wrap-long-lines-window-edge)
(setq menu-bar--wrap-long-lines-window-edge t)

(setq +format-on-save-enabled-modes '(not emacs-lisp-mode sql-mode tex-mode latex-mode js2x-mode typescript-mode web-mode))
(global-set-key [f4] 'save-buffer)
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

;(use-package org-bullets :ensure t)
;(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
;(setq org-hide-leading-stars t)

(use-package! org
  :ensure org-plus-contrib

  :config
  (setq org-directory "~/org/")

  (setq org-agenda-files '("~/org/inbox.org.gpg"
                           "~/org/gtd.org.gpg"
                           "~/org/tickler.org.gpg"))

  (setq org-capture-templates '(("t" "Todo [inbox]" entry
                                 (file+headline "~/org/inbox.org.gpg" "Tasks")
                                 "* TODO %i%?")
                                ("T" "Tickler" entry
                                 (file+headline "~/org/tickler.org.gpg" "Tickler")
                                 "* %i%? \n %U")))

  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

  (setq org-refile-targets '(("~/org/gtd.org.gpg" :maxlevel . 3)
                             ("~/org/someday.org.gpg" :level . 1)
                             ("~/org/tickler.org.gpg" :maxlevel . 2)))

  :custom
  (org-deadline-warning-days 8)
  (org-agenda-start-with-log-mode t)
  (org-log-done 'time)
  (org-log-into-drawer t)
  (org-babel-do-load-languages
  'org-babel-load-languages
  '((dot . t))) ; this line activates dot

)

(require 'yasnippet)

(defun yas-jsx-get-class-name-by-file-name ()
  "Return name of class-like construct by `file-name'."
  (if buffer-file-name
      (let ((class-name (file-name-nondirectory
                         (file-name-sans-extension buffer-file-name))))
        (if (equal class-name "index")
            (file-name-nondirectory
             (directory-file-name (file-name-directory buffer-file-name)))
          class-name))
    ""))

(defun yas-snake-case (s)
  "Convert S to snake-case."
  (mapconcat #'upcase (split-string s "[^[:word:]0-9]+" t) "_"))

;; (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)
(with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action))

(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
;; (require 'org-notify)
;; (use-package org-notify
;;   :after org
;;   :config (org-notify-start)
;;   )
;; (require 'org-alert)
;; (use-package org-alert
;;   :ensure t
;;   :custom (alert-default-style 'notifications)
;;   :config
;;   (setq org-alert-interval 300
;;         org-alert-notification-title "Org Alert Reminder")
;;   (org-alert-enable)
;;  )

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(require 'epa-file)
(epa-file-enable)
(require 'org-crypt)
(org-crypt-use-before-save-magic)
(setq org-tags-exclude-from-inheritance (quote ("crypt")))

(add-hook 'web-mode #'toggle-truncate-lines)
(require 'org-bullets)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(setq org-hide-leading-stars t)
(setq org-src-fontify-natively t)
(global-prettify-symbols-mode t)

(setq ispell-dictionary "british")
;(require 'elfeed-goodies)
;; (elfeed-goodies/setup)
;; (setq elfeed-goodies/entry-pane-size 0.5)

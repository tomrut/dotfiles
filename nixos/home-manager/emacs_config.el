(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
(setq org-agenda-files (quote ("~/org")))
(global-set-key "\C-ca" 'org-agenda)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key (kbd "C-c c") #'org-capture)
(global-set-key (kbd "C-c l") #'org-store-link)

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory "~/org/org-roam")
  (org-roam-completion-everywhere t)
  (org-roam-capture-templates
   '(("d" "default" plain
      "%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)
     ("l" "programming language" plain
      "* Characteristics\n\n- Family: %?\n- Inspired by: \n\n* Reference:\n\n"
      :if-new (file+head "%<%Y%m%d%H%M%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)
     ("b" "book notes" plain
      "\n* Source\n\nAuthor: %^{Author}\nTitle: ''${title}\nYear: %^{Year}\n\n* Summary\n\n%?"
      :if-new (file+head "%<%Y%m%d%H%M%S>-''${slug}.org" "#+title: ''${title}\n")
      :unnarrowed t)
     ))
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	   ("C-c n c" . org-roam-capture)
	   ("C-c n j" . org-roam-dailies-capture-today)
  )
  :config
  (org-roam-db-autosync-mode)
  (org-roam-setup)
)

(setq org-capture-templates
   (doct `(("Flashcard" :keys "f"
	    :file "~/org/flashcards.org"
	    :template "* %^{title} \n** %? *%\\1* .\n*** %^{title_pl} \n****  *%\\2* ."
	    :children (("Expr"       :keys "1"   :headline "Expression")
		       ("Job"        :keys "2"   :headline "Job")
		       ("Animal"     :keys "3"   :headline "Animal")
		       ("Plant"      :keys "4"   :headline "Plant")
		       ("Place"      :keys "5"   :headline "Place")
		       ("Adjective"  :keys "6"   :headline "Adjective")
		       ("Verb"       :keys "7"   :headline "Verb")
		       ("Noun     "  :keys "8"   :headline "Noun")
		       ("General  "  :keys "9"   :headline "General")
		       ("Food     "  :keys "f"   :headline "Food")
		       ("Health   "  :keys "h"   :headline "Health")
		       ("Other"      :keys "0"
			:function ,(defun +org-capture-project-heading ()
				     (if-let ((category (read-string "Category:" "")))
					 (let ((headline (org-find-exact-headline-in-buffer category)))
					   (goto-char (or headline (point-max)))
					   (unless headline (insert "* " category))
					   (org-capture-put :target-entry-p t))
				       (user-error "No category selected")))
			)

		      )
	    ))
   )
)

    

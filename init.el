;; Emacs init file
;; Jewel James

;; DO NOT EDIT THIS BLOCK ---------------------------
;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Use straight.el to install all listed packages
;; To add a new package, add it to the list in package-list.el
(load-file (expand-file-name "package-list.el" user-emacs-directory))
(mapc (lambda(package-name)
	(straight-use-package package-name)) package-list)
;; END OF BLOCK -------------------------------------

;; Change garbage collection threshold for faster loading
(setq gc-cons-threshold 100000000
      gc-cons-percentage 0.6)
;; Disabling some stuff during startup
(defvar file-name-handler-alist--save file-name-handler-alist)
(setq file-name-handler-alist nil)

;; Basic configurations
(add-to-list 'load-path "~/.emacs.d/custom")

;; Load the theme
(load-theme 'doom-wilmersdorf t)

;; Setup alternate directory for backups
(setq backup-directory-alist `(("." . "~/.saves")))

;; Inhibit the splash screen and message
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

;; Set default frame size
(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 115))

;; Disable all GUI crap
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;; After-init hook
(add-hook 'after-init-hook (lambda()
			     (global-visual-line-mode +1)
			     (column-number-mode +1)
			     (winner-mode +1)
			     (global-company-mode +1)
			     ;; Third-party
			     (evil-mode +1)))

;; Set custom face settings
(set-face-attribute 'default nil :font "Jetbrains Mono-11" )
(set-face-attribute 'variable-pitch nil :font "Iosevka Sparkle-11.5")
(set-face-attribute 'fixed-pitch nil :inherit 'default)
(set-face-attribute 'font-lock-comment-face nil :inherit 'default :italic nil)

;; Global keybindings
(global-set-key (kbd "C-x C-t") 'eshell)
(global-set-key (kbd "C-x k") 'kill-this-buffer)
(global-set-key (kbd "C-(") 'evil-prev-buffer)
(global-set-key (kbd "C-)") 'evil-next-buffer)
(global-set-key (kbd "C-x d") (lambda() (interactive) (dired ".")))
(global-set-key (kbd "C-x C-d") 'dired)
(global-set-key (kbd "C-c d") 'sdcv-search-pointer)

;; Custom function definitions
(defun xm/editing-mode()
  (variable-pitch-mode 1)
  (setq-local line-spacing 2)
  (setq-local left-margin-width 2)
  (setq-local right-margin-width 2))

(add-hook 'prog-mode-hook (lambda ()
			    (display-line-numbers-mode 1)
			    (hl-line-mode 1)
			    (hl-todo-mode 1)))
(add-hook 'conf-mode-hook (lambda()
			    (display-line-numbers-mode 1)
			    (hl-line-mode 1)
			    (hl-todo-mode 1)))
(add-hook 'text-mode-hook (lambda ()
			    (xm/editing-mode)
			    (flyspell-mode 1)
			    (display-line-numbers-mode -1)))
;; Custom extensions
(add-to-list 'load-path "~/.emacs.d/custom")
;; (require 'personal-journal)

;; recentf ------------------------
(setq recentf-max-saved-items 100)
(recentf-mode t)

;; evil ---------------------------
(setq evil-want-C-u-scroll t
      evil-want-keybinding nil)
(defun xm/save-and-kill-this-buffer ()
  "Save the current buffer and then kill it; Same as Vim's ':wq'"
  (interactive)
  (save-buffer)
  (kill-this-buffer))
(with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
  (define-key evil-insert-state-map (kbd "C-n") nil)
  (define-key evil-insert-state-map (kbd "C-p") nil))
(with-eval-after-load 'evil
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'xm/save-and-kill-this-buffer))

;; crux ---------------------------
(define-key ctl-x-map (kbd "C-r") 'crux-recentf-find-file)
(define-key ctl-x-map (kbd "C-_") 'crux-delete-file-and-buffer)
(define-key global-map (kbd "<f9>") 'crux-visit-term-buffer)

;; ido ----------------------------
(setq ido-everywhere t
      ido-enable-flex-matching t)
(ido-mode +1)
(ido-ubiquitous-mode +1)
(ido-yes-or-no-mode +1)

;; ivy ----------------------------
(setq ivy-height 8
      ivy-wrap t)
;; (ivy-mode 1)
;; (add-hook 'ivy-mode-hook #'ivy-rich-mode)

;; amx ----------------------------
(setq amx-backend 'auto)
(amx-mode 1)

;; counsel ------------------------
(define-key ctl-x-map (kbd "C-b") 'persp-switch-to-buffer)
;; (counsel-mode)

;; avy ----------------------------
(define-key global-map (kbd "C-;") 'avy-goto-line)
;; (avy-setup-default)

;; dired --------------------------
(setq dired-du-size-format t)
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'dired-hide-dotfiles-mode)
  (define-key dired-mode-map "-" 'dired-up-directory))

;; projectile ---------------------
(setq projectile-completion-system 'ido
      projectile-mode-line-function '(lambda () (format " [%s]" (projectile-project-name))))
(projectile-mode 1)
(define-key global-map (kbd "C-x p p") 'projectile-switch-project)
(define-key global-map (kbd "C-x p f") 'projectile-find-file)
(define-key global-map (kbd "C-x p n") 'projectile-add-known-project)

;; persp-mode ---------------------
(setq persp-nil-name "-")
;; (persp-mode 0)

;; magit --------------------------
(define-key ctl-x-map (kbd "g") 'magit-status)

;; evil-snipe ---------------------
(setq evil-snipe-scope 'buffer)
(evil-snipe-mode 1)

;; olivetti -----------------------
(setq olivetti-body-width 120)
(define-key ctl-x-map (kbd "t o") 'olivetti-mode)
(add-hook 'olivetti-mode-hook 'hide-mode-line-mode)

;; markdown-mode ------------------
;; (require 'markdown-mode)
(setq wc-modeline-format "%tw")
(with-eval-after-load 'markdown-mode
  (add-hook 'markdown-mode-hook 'wc-mode)
  (add-hook 'markdown-mode-hook 'mixed-pitch-mode))

;; mixed-pitch-mode ---------------
(with-eval-after-load 'mixed-pitch
  (diminish 'mixed-pitch-mode)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-tag)
  (add-to-list 'mixed-pitch-fixed-pitch-faces 'org-done))

;; helpful-mode
(global-set-key (kbd "C-h v") 'helpful-variable)
(global-set-key (kbd "C-h f") 'helpful-function)
(global-set-key (kbd "C-h k") 'helpful-key)

;; yas ---------------------------
;; (require 'yasnippet)
;; (yas-reload-all)
;; (add-hook 'yas-minor-mode-hook 'yas-reload-all)

;; org ----------------------------
(setq org-directory "~/Dropbox/Notes/org"
      org-return-follows-link t
      org-todo-keywords '((sequence "TODO(t)" "ACTV(a)" "REFL(r)" "|" "HOLD(h)" "DONE(d)"))
      org-inbox-file "~/Dropbox/Notes/org/inbox.org"
      org-agenda-files '("~/Dropbox/Notes/org")
      org-refile-targets '((org-inbox-file :maxlevel . 2)
			   ("~/Dropbox/Notes/org/emacs.org" :maxlevel . 1)
			   ("~/Dropbox/Notes/org/todo.org" :maxlevel . 2)
			   ("~/Dropbox/Notes/org/lists/books.org" :maxlevel . 3))
      org-startup-with-inline-images t
    ;; org-indent-indentation-per-level 1
    ;; org-adapt-indentation nil
      org-hide-emphasis-markers t
      org-capture-templates
      `(("t" "Add a TODO" entry
	(file ,(concat org-directory "/todo.org")) 
	"* TODO %?\n")
	("T" "Just a THOUGHT" entry
	(file ,(concat org-directory "/inbox.org"))
	"* %?\n")
	("Q" "A QUOTE" entry
	(file ,(concat org-directory "/quotes.org"))
	"* %?\n\n")
	("b" "Add a BLOG post IDEA" entry
	(file ,(concat org-directory "/blog-post-ideas.org")) 
	"* %?\n")
	("B" "Add a BOOK to the 'considering' list" entry
	(file+olp ,(concat org-directory "/lists/books.org") "Considering")
	"* %?\n")
	("r" "Add an ARTICLE to read later" checkitem
	(file+olp+datetree ,(concat org-directory "/lists/read-later.org"))
	"- [ ] %:annotation %?\n")
	("e" "An Emacs customization idea" entry
	(file+headline ,(concat org-directory "/emacs.org") "To-do")
	"* TODO %? \n\n")))
(define-key mode-specific-map (kbd "a") 'org-agenda)
(define-key mode-specific-map (kbd "c") 'counsel-org-capture)
(with-eval-after-load 'org
  (define-key org-mode-map (kbd "C-c C-q") 'counsel-org-tag)
  (add-hook 'org-mode-hook 'org-indent-mode)
  (add-hook 'org-mode-hook 'yas-minor-mode)
  ;; (add-hook 'org-mode-hook 'org-bullets-mode)
  (add-hook 'org-mode-hook 'mixed-pitch-mode))


;; org-journal --------------------
(setq org-journal-dir (concat org-directory "/journal")
      org-journal-file-type 'monthly
      org-journal-date-format "%A, %d %B %Y"
      org-journal-prefix-key (kbd "C-c j"))
(global-set-key (kbd "C-c j n") 'org-journal-new-entry)

;; anki-editor --------------------
;; (require 'anki-editor)
;; (define-key org-mode-map (kbd "C-c x a") 'anki-editor-insert-note)
;; (define-key org-mode-map (kbd "C-c x p") 'anki-editor-push-notes)
(setq anki-editor-create-decks t 
      anki-editor-org-tags-as-anki-tags t)
;; (add-hook 'org-mode-hook #'anki-editor-mode)

;; deft ---------------------------
(setq deft-directory org-directory
      deft-recursive t
      deft-auto-save-interval -1.0
      deft-extensions '("org")
      deft-default-extension "org")
(define-key global-map (kbd "<f8>") 'deft)
(define-key mode-specific-map (kbd "f") 'deft-find-file)
;; (add-hook 'deft-mode-hook #'custom/editing-mode)

;; org-ref ------------------------
(setq org-ref-completion-library 'org-ref-ivy-cite)
(setq reftex-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib"))
(setq bibtex-completion-bibliography "~/Dropbox/Notes/org/bibliography/references.bib")
(setq org-ref-bibliography-notes "~/Dropbox/bibliography/notes.org"
      org-ref-default-bibliography '("~/Dropbox/Notes/org/bibliography/references.bib")
      org-ref-pdf-directory "~/Dropbox/Notes/org/bibliography/bibtex-pdfs/")

;; org-roam -----------------------
(setq org-roam-directory (concat org-directory "/knowledgebase")
      org-roam-capture-templates `(("d" "default" plain #'org-roam-capture--get-point "\n- refs :: \n- tags :: %?\n\n" :file-name "%<%Y%m%d%H%M%S>-${slug}" :head "#+title: ${title}\n#+created: %U\n" :unnarrowed t)))
(org-roam-mode 1)
(define-key mode-specific-map (kbd "n l") 'org-roam-buffer-toggle-display)
(define-key mode-specific-map (kbd "n f") 'org-roam-find-file)
(define-key mode-specific-map (kbd "n g") 'org-roam-show-graph)
(define-key mode-specific-map (kbd "n i") 'org-roam-insert)
(add-hook 'org-roam-mode-hook 'org-roam-bibtex-mode)
(with-eval-after-load 'company
  (push 'company-org-roam company-backends))

;; org-roam-bibtex ----------------
(org-roam-bibtex-mode 1)
(add-to-list 'orb-preformat-keywords "abstract")
(setq orb-templates
  '(("r" "ref" plain (function org-roam-capture--get-point) ""
     :file-name "${citekey}"
     :head "#+title: ${title}\n#+roam_key: ${ref}\n\n" ; <--
     :unnarrowed t)))

;; diminish------------------------
(setq diminished-modes
      '(org-roam-mode org-indent-mode ivy-mode counsel-mode evil-snipe-mode undo-tree-mode org-roam-bibtex-mode company-mode mixed-pitch-mode visual-line-mode evil-snipe-local-mode buffer-face-mode))
(add-hook 'emacs-startup-hook (lambda() (mapc (lambda(minor-mode) (diminish minor-mode)) diminished-modes)))

(load "./my-faces.el")

;; Reset garbage-collection threshold
(add-hook 'emacs-startup-hook (lambda()
				(setq gc-cons-threshold 16777216
				      gc-cons-percentage 0.1)
				(setq file-name-handler-alist file-name-handler-alist--save)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values (quote ((org-log-done . time)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

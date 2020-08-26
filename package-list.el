;;; package-list.el --- The list of all my Emacs packages  -*- lexical-binding: t; -*-

;; Copyright (C) 2020  Jewel

;; Author: Jewel <monk@thinkpad>
;; Keywords: 

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

(defvar package-list)
(setq package-list '(
		     yasnippet-snippets
		     yasnippet
		     wc-mode
		     use-package
		     undo-tree
		     sdcv
		     projectile
		     poet-theme
		     pdf-tools
		     ;; org-superstar
		     org-roam-server
		     org-roam-bibtex
		     org-roam
		     org-ref
		     org-journal
		     ;; org-evil
		     org-bullets
		     ;; org
		     olivetti
		     neotree
		     ;; names
		     ;; nadvice
		     mixed-pitch
		     markdown-mode
		     magit
		     ;; ivy-rich
		     ;; ivy-hydra
		     ;; ivy-bibtex
		     ;; ivy
		     ido-completing-read+
		     ido-yes-or-no
		     flx-ido
		     hydra
		     hl-todo
		     hl-sentence
		     hide-mode-line
		     helpful
		     ;; helm
		     golint
		     go-mode
		     go-eldoc
		     go-complete
		     ;; gnupg
		     flymake-shell
		     flymake-easy
		     evil-snipe
		     evil-magit
		     evil
		     evil-collection
		     doom-themes
		     dired-single
		     dired-hide-dotfiles
		     deft
		     dashboard
		     csv-mode
		     crux
		     ;; counsel
		     company-org-roam
		     company-dict
		     company
		     command-log-mode
		     ;; centaur-tabs
		     bind-key
		     ;; avy
		     anki-editor
		     anki-connect
		     amx
		     all-the-icons
		     ;; Enhancements
		     diminish
		     ;; Custom recipes
		     ;; (wilmersdorf-theme :type git :host github :repo "ianpan870102/wilmersdorf-emacs-theme")
))


(provide 'package-list)
;;; package-list.el ends here

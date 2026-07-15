(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)
(column-number-mode 1)
(global-display-line-numbers-mode 1)

(global-visual-line-mode 0)
(global-whitespace-mode 1)
(setq whitespace-line-column 80)

(setq visible-bell t)
(setq
  backup-by-copying t      ; don't clobber symlinks
  backup-directory-alist
  '(("." . "~/Dropbox/org/backup"))    ; don't litter my fs tree
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)       ; use versioned backups

(setq whitespace-style
      (quote (face
               trailing
               tabs
               newline
               newline-mark)))

(setq whitespace-display-mappings
      '((newline-mark ?\n   [?\xAC ?\n] [?¬ ?\n])
        (tab-mark     ?\t   [?\x25B8 ?\t] [?▸ ?\t])))

(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C-c a") #'org-agenda)

(setq warning-minimum-level :emergency)

;(set-face-attribute 'default nil :font "FiraCode Nerd Font" :height 100)

(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(use-package helm
             :defer t
             :bind (("C-x C-f" . helm-find-files)
                    ("C-x b" . helm-mini)
                    ("M-x" . helm-M-x)
                    ("C-x g" . magit-status)))

;; Appearance
(use-package all-the-icons) ;; Run M-x all-the-icons-install-fonts
(use-package nerd-icons
             :custom (nerd-icons-font-family "FiraCode Nerd Font"))
(use-package doom-themes
             :init (load-theme 'doom-bluloco-dark t))
(use-package doom-modeline
             :init (doom-modeline-mode 1)
             :custom ((doom-modeline-height 15)))
(use-package rainbow-delimiters
             :ensure t
             :delight
             :commands rainbow-delimiters-mode
             :init
             (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

;; Keybindings
;; I don't get "general" yet...
;; (use-package general
;;   :config
;;   (general-create-definer thcipriani/leader-keys
;;     :keymaps '(normal insert visual emacs)
;;     :prefix "SPC"
;;     :global-prefix "C-SPC")
;;
;;   (thcipriani/leader-keys
;;    "t" '(:ignore t :which-key "toggles")
;;    "tf" '(recentf-open-file :which-key "open recent file")))

;;Vim4Eva

;; https://github.com/emacs-evil/evil
(use-package evil
             :init
             (setq evil-want-C-u-scroll t)
             (setq evil-want-integration t)
             (setq evil-want-keybinding nil))

(use-package neotree)

;; https://github.com/emacs-evil/evil-collection
(use-package evil-collection
             :after evil
             :config
             (evil-collection-init))

;; evil-leader
(use-package evil-leader
             :after evil
             :config
             (global-evil-leader-mode t)
             (evil-leader/set-leader ",")
             (evil-leader/set-key
               "q" 'delete-window
               "b" 'helm-mini
               "o" 'helm-occur
               "f" 'helm-find-files
               "x" 'helm-M-x
               "t" 'neotree-toggle
               "v" 'split-window-right
               "w" 'other-window
               "=" 'balance-windows
               "n" 'next-buffer
               "p" 'previous-buffer
               "an" 'deft)
             ;;"aj" 'org-journal-new-entry)
             (evil-mode 1))

;; Org-mode
;; https://orgmode.org
(defun joescottswanson/org-mode-setup ()
  (org-indent-mode 1)
  (variable-pitch-mode 1)
  (auto-fill-mode 0)
  (visual-line-mode 1))

(use-package org
             :hook (org-mode . joescottswanson/org-mode-setup)
             :config
             (setq org-log-into-drawer t)
             (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "NEXT-ACTION(n)" "|" "DONE(d)" "INVALID(i)" "REJECTED(r)")))
             (setq evil-auto-indent nil)
             (setq org-log-done 'time)
             (setq org-agenda-window-setup 'only-window); agenda takes whole window
             (setq org-agenda-restore-windows-after-quit t); restore window configuration on exit
             (setq org-overriding-columns-format "%10CATEGORY %80ITEM(Details) %TAGS(Context) %15DEADLINE %15SCHEDULED %7TODO(To Do) %5EFFORT(Time){:} %6CLOCKSUM{Total}"); format my columns the way i like them
             (setq org-agenda-files '("~/Dropbox/org/actions_list.org"
                                      "~/Dropbox/org/meetings.org"
                                      "~/Dropbox/org/refile.org"))
             (setq org-refile-targets '((nil :maxlevel . 2)
                                        (org-agenda-files :maxlevel . 2))) ; allows 9 levels deep of all headings in all org-agenda-files to be refile targets
             (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go
             (setq org-refile-use-outline-path t)                  ; Show full paths for refiling
             (setq org-agenda-custom-commands
                   '(
                     ("dh" "Daily habits"
                      ((agenda ""))
                      ((org-agenda-show-log t)
                       (org-agenda-ndays 7)
                       (org-agenda-log-mode-items '(state))
                       (org-agenda-skip-function '(org-agenda-skip-entry-if 'notregexp ":DAILY:"))))
                      ("D" "Daily Action List" ; https://www.youtube.com/watch?v=UqtBXrzXPgQ
                       ((todo "WAITING"
                              ((org-agenda-overriding-header "Waiting for Others\n")))
                        (agenda ""
                                ((org-agenda-block-separator nil)
                                 (org-agenda-span 1)
                                 (org-deadline-warning-days 0)
                                 (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                 (org-agenda-sorting-strategy
                                   (quote ((agenda time-up priority-down tag-up))))
                                 (org-agenda-overriding-header "\nDaily Agenda\n")))
                        (agenda "" ((org-agenda-block-separator nil)
                                    (org-agenda-entry-types '(:deadline))
                                    (org-agenda-span 'month)
                                    (org-deadline-warning-days 0)
                                    (org-agenda-show-all-dates nil)
                                    (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                    (org-agenda-overriding-header "\nUpcoming Deadlines\n")))))
                     ("nw" "Next at work"
                       ((tags "TODO={WAITING}+WORK"
                              ((org-agenda-overriding-header "Waiting for Others at Work\n")))
                        (agenda "" ((org-agenda-block-separator nil)
                                    (org-agenda-entry-types '(:deadline))
                                    (org-agenda-span 'month)
                                    (org-deadline-warning-days 0)
                                    (org-agenda-show-all-dates nil)
                                    (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                    (org-agenda-overriding-header "\nUpcoming Deadlines\n")))
                        (agenda "" ((org-agenda-block-separator nil)
                                    (org-agenda-entry-types '(:scheduled))
                                    (org-agenda-span 'day)
                                    (org-deadline-warning-days 0)
                                    (org-agenda-show-all-dates nil)
                                    (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                    (org-agenda-overriding-header "\nScheduled\n")))
                        (tags "TODO={NEXT-ACTION}+WORK"
                                ((org-agenda-block-separator nil)
                                 (org-agenda-sorting-strategy
                                   (quote ((agenda time-up priority-down tag-up))))
                                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                                 (org-agenda-overriding-header "\nNext at Work\n")))
                        ))
                     ("nh" "Next at home"
                       ((tags "TODO={WAITING}+HOME"
                              ((org-agenda-overriding-header "Waiting for Others at Home\n")))
                        (agenda "" ((org-agenda-block-separator nil)
                                    (org-agenda-entry-types '(:deadline))
                                    (org-agenda-span 'month)
                                    (org-deadline-warning-days 0)
                                    (org-agenda-show-all-dates nil)
                                    (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                    (org-agenda-overriding-header "\nUpcoming Deadlines\n")))
                        (agenda "" ((org-agenda-block-separator nil)
                                    (org-agenda-entry-types '(:scheduled))
                                    (org-agenda-span 'day)
                                    (org-deadline-warning-days 0)
                                    (org-agenda-show-all-dates nil)
                                    (org-agenda-day-face-function (lambda (date) 'org-agenda-date))
                                    (org-agenda-overriding-header "\nScheduled\n")))
                        (tags "TODO={NEXT-ACTION}+HOME"
                                ((org-agenda-block-separator nil)
                                 (org-agenda-sorting-strategy
                                   (quote ((agenda time-up priority-down tag-up))))
                                 (org-agenda-skip-function '(org-agenda-skip-entry-if 'deadline 'scheduled))
                                 (org-agenda-overriding-header "\nNext at Home\n")))
                        ))
                     ("tw" "waiting"
                      ((tags "TODO={WAITING}")))
                     ("tp" "Projects"
                      ((tags "TODO=<>+CATEGORY=\"projects\"")))
                     ("ts" "Someday/Maybe"
                      ((tags "CATEGORY=\"someday-maybe\"")))
                     ("ta" "All TODOS" tags-todo "*"
                      ((agenda ""))
                       ((org-agenda-ndays 7)
                        (org-deadline-warning-days 10)))
                     ))
             (define-key global-map "\C-ca" 'org-agenda))

;; Fix <s
(use-package 'org-tempo)

(use-package org-modern
             :hook ((org-mode . org-modern-mode)
                    (org-agenda-finalize . org-modern-agenda)))

(use-package deft
             :defer t
             :commands (deft)
             :config (setq deft-directory "~/Dropbox/obsidian-notes"
                           deft-extensions '("md" "org"))
             deft-use-filename-as-title t
             deft-use-filter-string-for-filename t
             deft-file-naming-rules '((noslash . "-")
                                      (nospace . "-")))

;; Org capture - adds a TODO item to refile.org
(setq org-capture-templates
      '(("t" "Todo" entry (file "~/Dropbox/org/refile.org") "* TODO %u %?")
        ("m" "Meeting" entry (file "~/Dropbox/org/meetings.org") "* %^t %?")
        ("s" "Slipbox" entry (file "~/Dropbox/org/notes_inbox.org") "* %?\n")
        ))

;; Org roam
;(setq org-roam-directory (file-truename "~/Dropbox/org/org-roam/"))
;(org-roam-db-autosync-mode) ; updates the org roam db when we change files
;(setq org-roam-capture-templates
;      '(("m" "main" plain
;         "%?"
;         :if-new (file+head "main/${slug}.org"
;                            "#+title: ${title}\n")
;         :immediate-finish t
;         :unnarrowed t)
;        ("r" "reference" plain "%?"
;         :if-new
;         (file+head "reference/${title}.org" "#+title: ${title}\n")
;         :immediate-finish t
;         :unnarrowed t)
;        ("a" "article" plain "%?"
;         :if-new
;         (file+head "articles/${title}.org" "#+title: ${title}\n#+filetags: :article:\n")
;         :immediate-finish t
;         :unnarrowed t))) ; ripped off from https://jethrokuan.github.io/org-roam-guide/

; function to grab the type of node [articles|reference|main]
;(cl-defmethod org-roam-node-type ((node org-roam-node))
;  "Return the TYPE of NODE."
;  (condition-case nil
;      (file-name-nondirectory
;       (directory-file-name
;        (file-name-directory
;         (file-relative-name (org-roam-node-file node) org-roam-directory))))
;    (error "")))

; displays the type of node in my org-roam mode
;(setq org-roam-node-display-template
;      (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

;; set up org mode synching via Dropbox across devices: https://christiantietze.de/posts/2019/03/sync-emacs-org-files/
; auto-save org mode files
(add-hook 'auto-save-hook 'org-save-all-org-buffers)

(use-package cl-lib
             :ensure t )
(defun make-capture-frame ()
  "Create a new frame and run org-capture."
  (interactive)
  (let ((frame (make-frame '((name . "capture")
                            (width . 120)
                            (height . 15)))))
  (select-frame-by-name "capture")
  (delete-other-windows)
  ;; (setq word-wrap 1)
  ;; (setq truncate-lines nil)
  ;; Using the second argument to org-capture, we bypass interactive selection
  ;; and use the existing template defined above.
  ; (org-capture nil "t")
      (cl-letf (((symbol-function 'switch-to-buffer-other-window)
               (lambda (buf &rest _) (switch-to-buffer buf)))
              ((symbol-function 'pop-to-buffer)
               (lambda (buf &rest _) (switch-to-buffer buf)))
              ((symbol-function 'display-buffer)
               (lambda (buf &rest _) (switch-to-buffer buf))))
          (org-capture))))

(defadvice org-capture-finalize
           (after delete-capture-frame activate)
           "Advise capture-finalize to close the frame"
           (if (equal "capture" (frame-parameter nil 'name))
             (delete-frame)))


(defadvice org-capture-destroy
           (after delete-capture-frame activate)
           "Advise capture-destroy to close the frame"
           (if (equal "capture" (frame-parameter nil 'name))
             (delete-frame)))

(load "server")
(setq server-socket-dir "~/.emacs.d/server")
(unless (server-running-p)
  (server-start))

; start in full screen
(custom-set-variables
   '(initial-frame-alist (quote ((fullscreen . maximized)))))

; start from actions list
(find-file "~/Dropbox/org/actions_list.org")

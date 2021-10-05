;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Faisal"
      user-mail-address "falqas@gmail.com")

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
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(require 'org-journal)


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

(menu-bar-mode 1)

(use-package mixed-pitch
:hook
(org-mode . mixed-pitch-mode))

(set-face-attribute 'variable-pitch nil :family "Source Sans Pro" )
(set-face-attribute 'fixed-pitch nil :family "IBM Plex Mono")
(set-face-attribute 'default nil :family "Ubuntu Mono")

(bind-key "C-+" 'text-scale-increase)
(bind-key "C--" 'text-scale-decrease)
(bind-key "C-0" 'text-scale-adjust)

;; hides asterisks & slashes for bold & italic
(setq org-hide-emphasis-markers t)

    (font-lock-add-keywords 'org-mode
                            '(("^ +\\([-*]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; bullets
(setq
    org-superstar-headline-bullets-list '("•")
)
(require 'org-inlinetask)
(setq org-inlinetask-show-first-star t)
;; Less gray please.
(set-face-attribute 'org-inlinetask nil
                    :foreground nil
		      :inherit 'bold)
;; (with-eval-after-load 'org-superstar
;;  (set-face-attribute 'org-superstar-first nil
;;                      :foreground "#9000e1"))
;; Set different bullets, with one getting a terminal fallback.
;; (setq org-superstar-headline-bullets-list
;;     '("◉" ("▷" ?▷) "▷" "▷"))
;; Set up a different marker for graphic display.
;; (setq org-superstar-first-inlinetask-bullet ?🞸)
;; Stop cycling bullets to emphasize hierarchy of headlines.
;; (setq org-superstar-cycle-headline-bullets nil)
;; A simple period works fine, too.
;; (setq org-superstar-leading-fallback ?.)


;; Override org-mode TODO keywords
(add-hook! org-load
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@/!)" "|" "DONE(d!)" "CANC(c@)"))))


(global-set-key "\C-ca" 'org-agenda)

;; Custom agenda views (work vs private)
(defun org-focus-private() "Set focus on private things."
       (interactive)
       (setq org-agenda-files '("~/Dropbox/G_Learning/Evergreen/private.org")))
(defun org-focus-work() "Set focus on work things."
       (interactive)
       (setq org-agenda-files '("~/Dropbox/G_Learning/Evergreen/work.org")))
(defun org-focus-all() "Set focus on all things."
       (interactive)
       (setq org-agenda-files '("~/Dropbox/G_Learning/Evergreen/work.org"
                                "~/Dropbox/G_Learning/Evergreen/private.org")))

(global-set-key (kbd "<f6>") 'org-capture)
(remove-hook 'text-mode-hook #'spell-fu-mode)


(after! org
  (setq org-capture-templates
        (quote(


      ;   (("p" "Private templates")
      ;    ("pt" "TODO entry" entry
      ;     (file+headline "~/Dropbox/G_Learning/Evergreen/private.org" "Capture")
      ;     (file "~/Dropbox/G_Learning/Evergreen/tpl-todo.txt"))
      ;    ("pj" "Journal entry" entry (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/journal.org") "* %U - %^{Activity} %?")
      ;    ("pb" "Add book to read" entry (file+headline "~/Dropbox/G_Learning/Evergreen/private.org" "Books to read") (file "~/Dropbox/G_Learning/Evergreen/tpl-book.txt")
      ;     :empty-lines-after 2)
      ;
           ("G" "Define a goal" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-goal.txt") :empty-lines-after 2)

     ("N" "NEXT entry" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-next.txt") :empty-lines-before 1)

     ("T" "TODO entry" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-todo.txt") :empty-lines-before 1)

     ("W" "WAITING entry" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-waiting.txt") :empty-lines-before 1)

     ("S" "SOMEDAY entry" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-someday.txt") :empty-lines-before 1)

     ("P" "PROJ entry" entry (file+headline "~/Dropbox/G_Learning/Evergreen/capture.org" "Capture") (file "~/Dropbox/G_Learning/Evergreen/tpl-proj.txt") :empty-lines-before 1)


     ("B" "Book on the to-read-list" entry (file+headline "~/Dropbox/G_Learning/Evergreen/private.org" "Books to read") (file "~/Dropbox/G_Learning/Evergreen/tpl-book.txt") :empty-lines-after 2)


     ("p" "Create today's plan")

     ;("pP" "Daily plan private" plain (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/plan-private.org") (file "~/Dropbox/G_Learning/Evergreen/tpl-dailyplan.txt") :immediate-finish t )

     ;("pW" "Daily plan work" plain (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/plan-work.org") (file "~/Dropbox/G_Learning/Evergreen/tpl-dailyplan.txt") :immediate-finish t)
     ("pD" "Daily plan (all)" plain (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/plan-all.org") (file "~/Dropbox/G_Learning/Evergreen/tpl-dailyplan.txt") :jump-to-captured
 t)

     ("j" "Journal entry")
     ("jP" "Journal entry private " entry (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/journal-private.org") "** %^{Heading}")
      ("jW" "Journal entry work " entry (file+olp+datetree "~/Dropbox/G_Learning/Evergreen/journal-work.org") "** %^{Heading}")


          
          ))))



(defun my/copy-idlink-to-clipboard() "Copy an ID link with the
headline to killring, if no ID is there then create a new unique
ID.  This function works only in org-mode or org-agenda buffers.

The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
       (interactive)
       (when (eq major-mode 'org-agenda-mode) ;if we are in agenda mode we switch to orgmode
	 (org-agenda-show)
	 (org-agenda-goto))
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
	 (setq mytmphead (nth 4 (org-heading-components)))
         (setq mytmpid (funcall 'org-id-get-create))
	 (setq mytmplink (format "[[id:%s][%s]]" mytmpid mytmphead))
	 (kill-new mytmplink)
	 (message "Copied %s to killring (clipboard)" mytmplink)
       ))
(global-set-key (kbd "<f5>") 'my/copy-idlink-to-clipboard)


; Convert selection to checkbox
(defun org-set-line-checkbox (arg)
  (interactive "P")
  (let ((n (or arg 1)))
    (when (region-active-p)
      (setq n (count-lines (region-beginning)
                           (region-end)))
      (goto-char (region-beginning)))
    (dotimes (i n)
      (beginning-of-line)
      (insert "- [ ] ")
      (forward-line))
    (beginning-of-line)))


 '(diary-list-entries-hook
   (quote
    (diary-include-other-diary-files diary-sort-entries)))
  '(org-agenda-custom-commands
   (quote
    (
     ("A" . "Agendas")
     ("AT" "Daily overview"
      ((tags-todo "URGENT"
		  ((org-agenda-overriding-header "Urgent Tasks")))
       (tags-todo "RADAR"
		  ((org-agenda-overriding-header "On my radar")))
       (tags-todo "PHONE+TODO=\"NEXT\""
		  ((org-agenda-overriding-header "Phone Calls")))
       (tags-todo "Depth=\"Deep\"/NEXT"
                  ((org-agenda-overriding-header "Next Actions requiring deep work")))
       (agenda ""
	       ((org-agenda-overriding-header "Heute")
		(org-agenda-span 1)
		(org-agenda-sorting-strategy
		 (quote
		  (time-up priority-down)))))
      nil nil))
     ("AW" "Weekly overview" agenda ""
      ((org-agenda-overriding-header "Weekly overview")))
     ("AM" "Monthly overview" agenda ""
      ((org-agenda-overriding-header "Monthly overview"))
       (org-agenda-span
	(quote month))
       (org-deadline-warning-days 0)
       (org-agenda-sorting-strategy
	(quote
	 (time-up priority-down tag-up))))
     ("W" . "Weekly Review Helper")
     ("Wn" "New tasks" tags "NEW"
      ((org-agenda-overriding-header "NEW Tasks")))
     ("Wd" "Check DELEGATED tasks" todo "DELEGATED"
      ((org-agenda-overriding-header "DELEGATED tasks")))
     ("Ww" "Check WAITING tasks" todo "WAITING"
      ((org-agenda-overriding-header "WAITING tasks")))
     ("Ws" "Check SOMEDAY tasks" todo "SOMEDAY"
      ((org-agenda-overriding-header "SOMEDAY tasks")))
     ("Wf" "Check finished tasks" todo "DONE|CANCELLED|FORWARDED"
      ((org-agenda-overriding-header "Finished tasks")))
     ("WP" "Planing ToDos (unscheduled) only" todo "TODO|NEXT"
      ((org-agenda-overriding-header "Planungsübersicht")
       (org-agenda-skip-function
	(quote
	 (org-agenda-skip-entry-if
	  (quote scheduled)
	  (quote deadline)))))))
    ))
 '(org-agenda-file
   (quote
    ("~/Dropbox/G_Learning/Evergreen/work.org" "~/Dropbox/G_Learning/Evergreen/private.org" "~/Dropbox/G_Learning/Evergreen/gcal-personal.org" "~/Dropbox/G_Learning/Evergreen/mylife.org")))
 '(org-agenda-include-diary t)
 '(org-attach-use-inheritance t)
 '(org-babel-load-languages (quote ((emacs-lisp . t) (dot . t) (shell . t))))

(setq org-journal-dir "~/Dropbox/G_Learning/Evergreen/"
      org-journal-date-format "%A, %d %B %Y"
      org-journal-file-format "%Y-%m-%d.org"
      )
(setq org-roam-directory "~/Dropbox/G_Learning/Evergreen/")
(setq org-log-done 'time)

;; headlines
;;

(let* ((variable-tuple
          (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
         (base-font-color     (face-foreground 'default nil 'default))
         (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

;; To get org-roam capture to work
(setq xterm-set-window-title t)
(defadvice! fix-xterm-set-window-title (&optional terminal)
  :before-while #'xterm-set-window-title
  (not (display-graphic-p terminal)))

;; In order to include entries from the Emacs diary into Org mode’s agenda, you only need to customize the variable

(setq org-agenda-include-diary t)


;; google calendar integration
(require 'org-gcal)
(setq org-gcal-client-id "1011651967257-8vkr06u2ukp7dfq0905320k48q9bg4aq.apps.googleusercontent.com"
    org-gcal-client-secret "3HlHhyezXf-DCsc4VQCll5XM"
     org-gcal-fetch-file-alist '(("falqas@gmail.com" .  "~/Dropbox/G_Learning/Evergreen/gcal-personal.org")))
                                ;; ("another-mail@gmail.com" .  "~/task.org")))


;; autosave on idle
(setq super-save-auto-save-when-idle t)



;; Archives all done tasks
(defun org-archive-done-tasks ()
  (interactive)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/+DONE" 'agenda)
  (org-map-entries
   (lambda ()
     (org-archive-subtree)
     (setq org-map-continue-from (org-element-property :begin (org-element-at-point))))
   "/+CANCELED" 'agenda))

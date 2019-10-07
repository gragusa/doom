;; ;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-


(setq
 ;;doom-font (font-spec :family "SF Mono" :size 20)
 ;;doom-big-font (font-spec :family "SF Mono" :size 36)
 ;;doom-variable-pitch-font (font-spec :family "Avenir Next" :size 18)
 org-agenda-skip-scheduled-if-done t
 projectile-project-search-path '("~/Dropbox/repositories/")
 dired-dwim-target t
 org-ellipsis " ▾ "
 org-bullets-bullet-list '("·")
 org-tags-column -80
 org-directory "~/Dropbox/Org/"
 org-default-notes-file "~/Dropbox/Org/inbox.org"
 org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
 org-log-done 'time
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-capture-templates '(("x" "Note" entry
                          (file+olp+datetree "journal.org")
                          "**** [ ] %U %?" :prepend t :kill-buffer t)
                         ("t" "Task" entry
                          (file+headline "tasks.org" "Inbox")
                          "* [ ] %?\n%i" :prepend t :kill-buffer t))
 ;;+doom-dashboard-banner-file (expand-file-name "logo.png" doom-private-dir)
 +org-capture-todo-file "tasks.org"
 org-super-agenda-groups '((:name "Today"
                                  :time-grid t
                                  :scheduled today)
                           (:name "Due today"
                                  :deadline today)
                           (:name "Important"
                                  :priority "A")
                           (:name "Overdue"
                                  :deadline past)
                           (:name "Due soon"
                                  :deadline future)
                           (:name "Big Outcomes"
                                  :tag "bo")))

(after! org
  (set-face-attribute 'org-link nil
                      :weight 'normal
                      :foreground "cyan"
                      :underline '(:color "dark cyan" :line-width 2 :style line)
                      :background nil)
  (set-face-attribute 'org-code nil
                      :foreground "#a9a1e1"
                      :background nil)
  (set-face-attribute 'org-date nil
                      :foreground "#5B6268"
                      :background nil)
  (set-face-attribute 'org-level-1 nil
                      :foreground "steelblue2"
                      :background nil
                      :height 1.05
                      :weight 'normal)
  (set-face-attribute 'org-level-2 nil
                      :foreground "slategray2"
                      :background nil
                      :height 1.02
                      :weight 'normal)
  (set-face-attribute 'org-level-3 nil
                      :foreground "SkyBlue2"
                      :background nil
                      :height 1.01
                      :weight 'normal)
  (set-face-attribute 'org-level-4 nil
                      :foreground "DodgerBlue2"
                      :background nil
                      :height 1.0
                      :weight 'normal)
  (set-face-attribute 'org-level-5 nil
                      :weight 'normal)
  (set-face-attribute 'org-level-6 nil
                      :weight 'normal)
  (set-face-attribute 'org-document-title nil
                      :foreground "SlateGray1"
                      :background nil
                      :height 1.1
                      :weight 'bold)
  (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

;; iTerm send string to
;; This should only work on OSX
(when (eq system-type 'darwin)
  (load-file "~/.doom.d/iterm.elc")
  )

(when (eq system-type 'gnu/linux)
  (load-file "~/.doom.d/turnip.elc")
  )

;; Use fira font
(setq doom-font (font-spec :family "Fira Code" :size 18))

;; ;; Useful key
;;
(map! :ne "M-/" #'comment-or-uncomment-region)

(global-set-key [f1] 'replace-string)
(global-set-key [f2] 'split-window-horizontally)
(global-set-key [f3] 'split-window-vertically)
(global-set-key [f4] 'delete-window)

(global-set-key [(C-s-right)] 'windmove-right)
(global-set-key [(C-s-left)] 'windmove-left)

(global-set-key [(C-s-up)] 'windmove-up)
(global-set-key [(C-s-down)] 'windmove-down)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(global-set-key (kbd "C-s-,") 'previous-buffer)
(global-set-key (kbd "C-s-.") 'next-buffer)

;;Additional keybinding
(map! :leader
      (:prefix-map ("f" . "file")
        :desc " toggle" "n" #'treemacs)
      )

(after! julia-mode
  ;(setq path-to-julia-repl "/usr/local/bin/julia")
  ;(add-to-list 'load-path path-to-julia-repl)
  ;;(add-hook 'julia-mode-hook 'julia-repl-mode)
 (when (eq system-type 'darwin)
  (define-key julia-mode-map
     (kbd "M-RET") 'iterm-send-text)
  )

 (when (eq system-type 'gnu/linux)
   (define-key julia-mode-map
     (kbd "M-RET") 'gragusa/turnip-send-region-or-line)
  )
)

;; Flyspell
;;
(define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
(define-key flyspell-mouse-map [mouse-3] #'undefined)

;; Org-Mode
;;
(add-hook
 'org-mode-hook
 (lambda()
   (add-to-list 'org-latex-packages-alist '("" "minted"))
   (setq org-export-allow-bind-keywords t
         org-latex-listings 'minted)
   (setq org-latex-pdf-process
         '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
           "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
           "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

   (setq org-latex-minted-options
         '(("fontsize" "\\scriptsize")
           ("obeytabs" "true")
           ("bgcolor" "gray!10")
           ("frame" "none")
           ("linenos" "true")
           ("mathescape" "true")
           ))
   ))

(add-hook
 'org-beamer-mode-hook
 (lambda()
   (define-key org-mode-map
     (kbd "<f5>") 'org-beamer-export-to-pdf)))

;; Partially disable smartparens in org-mode
(after! (:and org smartparens)
(sp-with-modes 'org-mode
  (sp-local-pair "*" "*" :unless '(:add sp-in-code-p sp-point-before-word-p sp-in-math-p sp-point-after-word-p +org-sp-point-at-bol-p))
  (sp-local-pair "_" "_" :unless '(:add sp-in-code-p sp-point-before-word-p sp-in-math-p sp-point-after-word-p +org-sp-point-at-bol-p))
  (sp-local-pair "=" "=" :unless '(:add sp-in-code-p sp-point-before-word-p sp-in-math-p sp-point-after-word-p +org-sp-point-at-bol-p)))
)

(after! (:and org recentf)
    ;; Don't clobber recentf with agenda files
    (defun +org-is-agenda-file (filename)
      (cl-find (file-truename filename) org-agenda-files
               :key #'file-truename
               :test #'equal))
    (add-to-list 'recentf-exclude #'+org-is-agenda-file))


;; mode-map
;;
;;

(defun gragusa/org-babel-indent-src-bock ()
  (interactive)
  (org-babel-mark-block)
  (indent-region (region-beginning) (region-end))
  )

(after! org
  (map! :map org-mode-map
        :leader
        (:prefix ("c" . "code")
          :desc "execute src blk"       "c" #'org-babel-execute-src-block
          :desc "indent  src blk"       "i" #'gragusa/org-babel-indent-src-bock
          :desc "execute src blk (asy)" "a" #'ob-async-org-babel-execute-src-block
          )
        )

  (map! :map evil-org-mode-map
        :n "gr" #'org-babel-execute-src-block
        )

  (setq inferior-julia-program-name "/usr/local/bin/julia")
  (setq inferior-STA-program-name "/usr/local/bin/stata")
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (dot . t)
     (latex . t)
     (matlab . t)
     (maxima . t)
     (R . t)
     (stata . t)
     (julia . t)
     (python . t)
     (jupyter . t)))
  )

(after! python
  (setq elpy-syntax-check-command "epylint"
        elpy-modules '(elpy-module-company
                       elpy-module-eldoc
                       elpy-module-pyvenv
                       elpy-module-yasnippet
                       elpy-module-sane-defaults))
  (elpy-enable)
  (setq python-shell-interpreter "python"
        python-shell-interpreter-args "-i")

  (defun elpy--region-without-indentation (beg end)
  "Return the current region as a string, but without indentation."
  (let ((region (buffer-substring beg end))
        (indent-level nil))
    (catch 'return
      (with-temp-buffer
        (insert region)
        (goto-char (point-min))
        (while (< (point) (point-max))
          (cond
           ((and (not indent-level)
                 (not (looking-at "[ \t]*$")))
            (setq indent-level (current-indentation)))
           ((and indent-level
                 (not (looking-at "[ \t]*$"))
                 (< (current-indentation)
                    indent-level))
            (error "Can't adjust indentation, consecutive lines indented less than starting line")))
          (forward-line))
        (indent-rigidly (point-min)
                        (point-max)
                        (- indent-level))
        (buffer-string)))))

  (defun gragusa/send-line-or-region ()
    (interactive)
    (if (region-active-p)
        (call-interactively 'elpy-shell-send-region-or-buffer)
      (python-shell-send-string (elpy--region-without-indentation
                                 (line-beginning-position)
                                 (line-end-position)))))
  (setq split-height-threshold nil)
  (setq split-width-threshold 160)

  (map! :map elpy-mode-map
        (
         :desc "send region" "<M-return>" #'gragusa/send-line-or-region
         :desc "send region" "<M-s-return>" #'elpy-shell-send-defun
         )
        ))

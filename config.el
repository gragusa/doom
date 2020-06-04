;; ;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-


(setq
 ;;doom-font (font-spec :family "SF Mono" :size 20)
 ;;doom-big-font (font-spec :family "SF Mono" :size 36)
 ;;doom-variable-pitch-font (font-spec :family "Avenir Next" :size 18)
 org-agenda-skip-scheduled-if-done t
 projectile-project-search-path '("~/Dropbox/repositories/")
 dired-dwim-target t
 org-ellipsis "…"
 org-bullets-bullet-list '("∴")
 org-tags-column -80
 org-directory "~/Dropbox/Org/"
 org-default-notes-file "~/Dropbox/Org/inbox.org"
 org-agenda-files (ignore-errors (directory-files +org-dir t "\\.org$" t))
 org-log-done 'time
 org-refile-targets (quote ((nil :maxlevel . 1)))
 org-startup-indented t
 org-hide-emphasis-markers t
 org-fontify-done-headline t
 org-hide-leading-stars t
 ;;org-pretty-entities nil
 org-odd-levels-only t
 org-src-tab-acts-natively t
 ;; Fix src code block indentation
 org-src-preserve-indentation nil
 org-edit-src-content-indentation 0
 pdf-sync-backward-display-action t
 pdf-sync-forward-display-action t
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
;; (when (eq system-type 'darwin)
;;   (load-file "~/.doom.d/iterm.elc")
;;   )

;; (when (eq system-type 'gnu/linux)
;;   (load-file "~/.doom.d/turnip.elc")
;;   )

(when (eq system-type 'gnu/linux)
;;  (load-file "~/.doom.d/turnip.elc")
  (setq x-ctrl-keysym 'super)
  (setq x-meta-keysym 'ctrl)
  (setq x-super-keysym 'meta)
  (global-set-key [(M-s-right)] 'windmove-right)
  (global-set-key [(M-s-left)] 'windmove-left)
  (global-set-key [(M-s-up)] 'windmove-up)
  (global-set-key [(M-s-down)] 'windmove-down)
  (map! :nei "s-x" #'execute-extended-command)
  (map! :nei "M-/" #'comment-or-uncomment-region)
  (map! :nei "s-/" #'comment-or-uncomment-region)
  (map! :nei "s-c" #'kill-ring-save)
  (map! :nei "s-v" #'yank)
;;  (map! :ne "s-x" #'kill-region)
  (map! :nei "s-z" #'undo-tree-undo)
  (map! :nei "S-z" #'undo-tree-undo)
  (map! :nei "s-s" #'save-buffer)
  )

(when (eq system-type 'darwin)
  ;;  (load-file "~/.doom.d/turnip.elc")
  ;;  (setq x-meta-keysym 'super)
  ;;  (setq x-super-keysym 'meta)
  (global-set-key [(M-s-right)] 'windmove-right)
  (global-set-key [(M-s-left)] 'windmove-left)
  (global-set-key [(M-s-up)] 'windmove-up)
  (global-set-key [(M-s-down)] 'windmove-down)
  (map! :ne "s-/" #'comment-or-uncomment-region)
  )


;; Use fira font
(setq doom-font (font-spec :family "Fira Code" :size 22))



;; ;; Useful key


(global-set-key [f1] 'replace-string)
(global-set-key [f2] 'split-window-horizontally)
(global-set-key [f3] 'split-window-vertically)
(global-set-key [f4] 'delete-window)


(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)


;;Additional keybinding
(map! :leader
      (:prefix-map ("f" . "file")
        :desc " toggle" "n" #'treemacs)
      )

(after! julia-mode
  (setq path-to-julia-repl "/usr/local/bin/julia")
;;  (add-to-list 'load-path l)
  (add-hook 'julia-mode-hook #'julia-repl-mode)

)

(after! julia-repl

   (defun julia-repl-send-line-and-back ()
     (interactive)
    (let ((win (selected-window)))
      (julia-repl-send-line)
      (select-window win)
      ;;(forward-line 1)
      )
    )
 (defun julia-repl-send-region-or-line-and-back ()
     (interactive)
    (let ((win (selected-window)))
      (julia-repl-send-region-or-line)
      (select-window win)
      ;;(forward-line 1)
      )
    )
 (defun julia-repl-includet-buffer-and-back ()
     (interactive)
    (let ((win (selected-window)))
      (julia-repl-includet-buffer)
      (select-window win)
      ;;(forward-line 1)
      )
    )
 (defun julia-repl-activate-parent-and-back (arg)
     (interactive "P")
     (let ((win (selected-window)))
       (julia-repl-activate-parent arg)
       (select-window win)
       ;;(forward-line 1)
      )
    )

 ;; To make these commands to work I had to comment out stuff in emacs.d/config.el
 ;;
 (define-key julia-repl-mode-map
   (kbd "<s-return>") #'julia-repl-send-region-or-line-and-back)
 (define-key julia-repl-mode-map
   (kbd "<M-return>") #'julia-repl-send-region-or-line-and-back)
 (define-key julia-repl-mode-map
   (kbd "<M-s-return>") #'julia-repl-includet-buffer-and-back)
 (define-key julia-repl-mode-map
   (kbd "C-c C-t") #'julia-repl-includet-buffer-and-back)
 (define-key julia-repl-mode-map
   (kbd "C-c C-a") #'julia-repl-activate-parent-and-back)


)

;; Flyspell
;;
(define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
(define-key flyspell-mouse-map [mouse-3] #'undefined)

;; Org-Mode
;;
;;
;;
;; The next setting prettifies src blocks. Inspired by a comment in i use markdown rather than org-mode for my notes : emacs I looked at the now builtin mode prettify-symbols-mode.
(setq-default prettify-symbols-alist '(("#+BEGIN_SRC" . "⋖")
                                       ("#+END_SRC" . "⋗")
                                       ("#+begin_src" . "⋖")
                                       ("#+end_src" . "⋗")
                                       (">=" . "≥")
                                       ("=>" . "⇨")))
(setq prettify-symbols-unprettify-at-point 'right-edge)
(add-hook 'org-mode-hook 'prettify-symbols-mode)

(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "∶"))))))
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([+]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "∶"))))))
(add-hook 'org-mode-hook
          (lambda()
            (require 'ox-latex)
            (visual-line-mode)
            (add-to-list 'org-latex-packages-alist '("" "minted"))
            (setq org-export-allow-bind-keywords t
                  org-latex-listings 'minted)
            (setq org-latex-pdf-process
                  '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
                    "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
            (add-to-list 'org-latex-classes
                         '("foils"
                           "\\documentclass{foils}"
                           ("\\foilhead[-1cm]{%s}" . "\\foilhead[-1cm]*(%s)"))
                         )
            (setq org-latex-minted-options
                  '(("fontsize" "\\scriptsize")
                    ("obeytabs" "true")
                    ("bgcolor" "gray!10")
                    ("frame" "none")
                    ("linenos" "true")
                    ("mathescape" "true")
                    ))
   ))

;; (when (member "Symbola" (font-family-list))
;;   (set-fontset-font t 'unicode "Symbola" nil 'prepend))

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


(set-popup-rule! "^\\*Org Agenda" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^CAPTURE.*\\.org$" :side 'bottom :size 0.90 :select t :ttl nil)
(set-popup-rule! "^\\*Julia" :side 'right :size 0.50 :select t :ttl nil)

(add-hook 'term-mode-hook #'eterm-256color-mode)


;; LanguageServer.jl
;;
(require 'cl-generic)

(defcustom julia-default-depot ""
  "The default depot path, used if `JULIA_DEPOT_PATH' is unset"
  :type 'string
  :group 'julia-config)

(defcustom julia-default-environment "~/.julia/environment/v1.3"
  "The default julia environment"
  :type 'string
  :group 'julia-config)

(defun julia/get-depot-path ()
  (if-let (env-depot (getenv "JULIA_DEPOT_PATH"))
      (expand-file-name env-depot)
    (if (equal julia-default-depot "")
        julia-default-depot
      (expand-file-name julia-default-depot))))

(defun julia/get-environment (dir)
  (expand-file-name (if dir (or (locate-dominating-file dir "JuliaProject.toml")
                                (locate-dominating-file dir "Project.toml")
                                julia-default-environment)
                      julia-default-environment)))

;; Make project.el aware of Julia projects
(defun julia/project-try (dir)
  (let ((root (or (locate-dominating-file dir "JuliaProject.toml")
                 (locate-dominating-file dir "Project.toml"))))
    (and root (cons 'julia root))))
(add-hook 'project-find-functions 'julia/project-try)

(cl-defmethod project-roots ((project (head julia)))
  (list (cdr project)))

(defun julia/get-language-server-invocation (interactive)
  `("julia"
    ,(expand-file-name "~/.doom.d/eglot-julia/eglot.jl")
    ,(julia/get-environment (buffer-file-name))
    ,(julia/get-depot-path)))

;; From here
;; https://github.com/hlissner/doom-emacs/issues/3269
;; Fix problem with project-root
(defun project-root (project)
    (car (project-roots project)))




;; Setup eglot with julia
;;(require 'eglot-jl)
;;(setq eglot-jl-julia-flags "-J ~/.julia/.ds/ds.so")
(setq eglot-connect-timeout 1000)
;;(add-to-list 'eglot-server-programs
;;              '(julia-mode . eglot-jl--ls-invocation))

          ;; function instead of strings to find project dir at runtime
;;          '(julia-mode . julia/get-language-server-invocation))
;;   (add-hook 'julia-mode-hook 'eglot-ensure))
(setq julia-repl-switches "-J /home/gragusa/.julia/.ds/ds.so")
(setq inferior-julia-args "-J /home/gragusa/.julia/.ds/ds.so")

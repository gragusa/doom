;; ;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here



;; Use fira font
(setq doom-font (font-spec :family "Fira Code" :size 14))

;; ;; Useful key
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

;; ;; Another example would be to translate strike through text to \structure{strike through text} with the following filter.
;; ;; from: https://orgmode.org/worg/exporters/beamer/ox-beamer.html
;; (defun my-beamer-structure (contents backend info)
;;   (when (eq backend 'beamer)
;;     (replace-regexp-in-string "\\`\\\\[A-Za-z0-9]+" "\\\\structure" contents)))

;; (add-to-list 'org-export-filter-strike-through-functions 'my-beamer-structure)

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
)

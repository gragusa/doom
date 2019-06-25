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

(map! (:map override
        :nm "p" #'paste-and-indent-after
        :nm "P" #'paste-and-indent-before
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



;; (defun sp-org-point-after-curlybracket-p (id action _context)
;;   "Return t if point follows a curly bracket, nil otherwise.
;; This predicate is only tested on \"insert\" action.
;; ID, ACTION, CONTEXT."
;;   (when (eq action 'insert)
;;     (let ((trigger (sp-get-pair id :trigger)))
;;       (looking-back (concat "\\}" (regexp-quote (if trigger trigger id))) nil))))


;; Disable smartparens in org-mode when
(after! (:and org smartparens)

(sp-with-modes 'org-mode
  (sp-local-pair "_" "_" :unless '(:add sp-in-code-p sp-point-before-word-p sp-in-math-p sp-point-after-word-p +org-sp-point-at-bol-p))
    (sp-local-pair "=" "=" :unless '(:add sp-in-code-p sp-point-before-word-p sp-in-math-p sp-point-after-word-p +org-sp-point-at-bol-p))))



;; Some function
(defun undo-collapse-begin (marker)
  "Mark the beginning of a collapsible undo block.
This must be followed with a call to undo-collapse-end with a marker
eq to this one."
  (push marker buffer-undo-list))

(defun undo-collapse-end (marker)
  "Collapse undo history until a matching marker."
  (cond
    ((eq (car buffer-undo-list) marker)
     (setq buffer-undo-list (cdr buffer-undo-list)))
    (t
     (let ((l buffer-undo-list))
       (while (not (eq (cadr l) marker))
         (cond
           ((null (cdr l))
            (error "undo-collapse-end with no matching marker"))
           ((eq (cadr l) nil)
            (setf (cdr l) (cddr l)))
           (t (setq l (cdr l)))))
       ;; remove the marker
       (setf (cdr l) (cddr l))))))

 (defmacro with-undo-collapse (&rest body)
  "Execute body, then collapse any resulting undo boundaries."
  (declare (indent 0))
  (let ((marker (list 'apply 'identity nil)) ; build a fresh list
        (buffer-var (make-symbol "buffer")))
    `(let ((,buffer-var (current-buffer)))
       (unwind-protect
            (progn
              (undo-collapse-begin ',marker)
              ,@body)
         (with-current-buffer ,buffer-var
           (undo-collapse-end ',marker))))))

(defun paste-and-indent-after ()
  (interactive)
  (with-undo-collapse
    (evil-paste-after 1)
    (evil-indent (evil-get-marker ?\[) (evil-get-marker ?\]))))
(defun paste-and-indent-before ()
  (interactive)
  (with-undo-collapse
    (evil-paste-before 1)
    (evil-indent (evil-get-marker ?\[) (evil-get-marker ?\]))))

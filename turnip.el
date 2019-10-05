;;; turnip.el --- description -*- lexical-binding: t; -*-


(defun gragusa/turnip-send-region-or-line()
  "Send current line to the last tmux pane."
  (interactive)
   (if (use-region-p)
       (turnip-send-region
        (region-beginning)
        (region-end)
        (turnip:normalize-and-check-target-pane turnip:last-pane)
        nil
        )
     (turnip-send-region
      (save-excursion
        (beginning-of-line)
        (point)
        )
      (save-excursion
        (beginning-of-line 2)
        (point)
        )
        (turnip:normalize-and-check-target-pane turnip:last-pane)
      )
     )
  )

(setq turnip-send-region-before-keys '("c-a" "c-h" "c-k"))

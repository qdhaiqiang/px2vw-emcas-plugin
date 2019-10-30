
(defun kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (kill-thing-at-point 'word))

(defun convert-to-vw (px-v)
  (format "%.2f" (float (/ (* (string-to-number px-v) 100) 1440))))

(defun convert-to-vh (px-v)
  (format "%.2f" (float (/ (* (string-to-number px-v) 100) 900))))

(defun px->vw ()
  "Convert word at point (or selected region) to vw."
  (interactive)
  (let* ((char (if (use-region-p)
                     (cons (region-beginning) (region-end))
                   (thing-at-point 'symbol))))
    (if (and (not (string-blank-p char)) (string-match "px" char))
      (progn
        (setq word (current-word char))
        (setq px-v (substring word 0 (- (length word) 2)))
        (kill-word-at-point)
        (insert (concat (convert-to-vw px-v) unit)))
      (print "there's no px value to converting"))))

;;(global-set-key (kbd "C-c w") 'px->vw)
(provide 'px-to-vw-vh)

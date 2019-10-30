
(defvar viewpoint-width 1440) 
(defvar viewpoint-height 900) 

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
  (format "%.2f" (/ (float (* (string-to-number px-v) 100)) viewpoint-width)))

(defun convert-to-vh (px-v)
  (format "%.2f" (/ (float (* (string-to-number px-v) 100)) viewpoint-height )))

(defun px->vw ()
  "Convert word at point (or selected region) from px to vw."
  (interactive)
  (let* ((char (if (use-region-p)
                   (cons (region-beginning) (region-end))
                 (thing-at-point 'symbol))))
    (when (and char (not (string-blank-p char)) )
      (if (string-match "px" char)
          (progn
            (setq word (current-word char))
            (setq px-v (substring word 0 (- (length word) 2)))
            (kill-word-at-point)
            (insert (concat (convert-to-vw px-v) "vw")))
        (print "there's no px value to converting")))))

;;(global-set-key (kbd "C-c w") 'px->vw)
;;(global-set-key [f9] 'px->vw)

(defun region-px->vw (pos1 pos2)
  "当前选中region或者paragraph中的px转化为vw，可能还需要考虑:
   1. 1px的情况
   2. 其他我不知道的规则"
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) )
       (list (car bds) (cdr bds)))))
  (save-restriction
    (narrow-to-region pos1 pos2)
    (goto-char (point-min))
    (while (search-forward-regexp "\\([0-9.]+\\)\\(px\\)" nil t)
      (let* ((px-digit-str (match-string 1))
             (px-digit (string-to-number px-digit-str))
             (vw-digit (format
                        "%.2f"
                        (/
                         (* 100.0 px-digit)
                         1400.0))))
        (replace-match (concat vw-digit  "vw") t nil)))))

(provide 'px2vw)

;;; px2vw.el --- convert px to vw in css
;;; Commentary:
;;; Code:

(defvar viewpoint-width 1440.0)

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
                        "%.4f"
                        (/
                         (* 100.0 px-digit)
                         viewpoint-width))))
        (replace-match (concat vw-digit  "vw") t nil)))))
 
;;(global-set-key (kbd "C-c w") 'px->vw)
;;(global-set-key [f9] 'px->vw)

(provide 'px2vw)

;;; px2vw.el ends here

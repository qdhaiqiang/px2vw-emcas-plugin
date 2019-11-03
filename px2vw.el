;;; px2vw.el --- convert px to vw in css
;;; Commentary:
;;; Code:

(defvar viewpoint-width 1440.0)


(defun region-px->vw (pos1 pos2)
  "当前选中region或者paragraph中的px转化为vw，可能还需要考虑:
   1.1px的情况
   2.其他我不知道的规则"
  (interactive ;; interactive函数生成本函数的参数1. 开始位置 2. 结束位置; 考虑两种情况：region 和 paragraph
   (if (use-region-p) ;; 是否用户已经选择了某个region
       (list (region-beginning) (region-end))
     (let ((bds (bounds-of-thing-at-point 'paragraph)) ) ;;如果不是region的话，找到当前paragraph
       (list (car bds) (cdr bds)))))
  (save-restriction ;;保证替换操作不影响开始和结束位置
    (narrow-to-region pos1 pos2) ;; 设定我们关心的一个范围，此范围以外的文本我们不关心
    (goto-char (point-min))    ;; 回到关心区域的起始位置
    (while (search-forward-regexp "\\([0-9.]+\\)\\(px\\)" nil t) ;; 正则查找，注意我们以后两个分组，第一个分组获得数值
      (let* ((px-digit-str (match-string 1)) ;; 从第一个分组拿到数值
             (px-digit (string-to-number px-digit-str))  ;; 数值->string
             (vw-digit (format     ;; 计算
                        "%.4f"
                        (/
                         (* 100.0 px-digit)
                         viewpoint-width))))
        (replace-match (concat vw-digit  "vw") t nil))))) ;;替换Hello!
 
;;(global-set-key (kbd "C-c w") 'px->vw)
;;(global-set-key [f9] 'px->vw)

(provide 'px2vw)

;;; px2vw.el ends here

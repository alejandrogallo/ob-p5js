(defcustom org-babel-default-header-args:p5js
  '((:exports . "results")
    (:results . "verbatim html replace value")
    (:eval . "t")
    (:width . "100%"))
  "P5js default header arguments")

(defcustom org-babel-header-args:p5js
 '((width . :any)
   (height . :any)
   (center . :any))
  "p5js-specific header arguments.")

(defcustom p5js-src "https://cdn.jsdelivr.net/npm/p5@1.4.2/lib/p5.js"
  "The source of p5js")

(defcustom p5js-iframe-class "org-p5js"
  "Default class for iframes containing a p5js sketch")

(defun p5js--create-sketch-body (params body)
  (format "
<html>
<head>
  <script src=%S></script>
  <script>
    %s
  </script>
</head>
<body>
  %s
</body>
</html>
" p5js-src body (p5js--maybe-center params "<main></main>")))

(defun p5js--maybe-center (params body)
  (if (alist-get :center params)
      (format "<center>%s</center>" body)
    body))

(defun p5js--create-iframe (params body &optional width height)
  (let ((sketch (base64-encode-string (p5js--create-sketch-body params body))))
    (p5js--maybe-center params
                        (format "<iframe class=\"%s\"
                                         frameBorder='0'
                                         %s
                                         src=\"data:text/html;base64,%s\">
                                         </iframe>"
                                p5js-iframe-class
                                (concat (if width
                                            (format "width=\"%s\" " width)
                                          "")
                                        (if height
                                            (format "height=\"%s\" " height)
                                          ""))
                                sketch))))

(defun org-babel-execute:p5js (body params)
  (let ((width (alist-get :width params))
        (height (alist-get :height params)))
    (p5js--create-iframe params body width height)))

(define-derived-mode p5js-mode
    js-mode "p5js"
    "Major mode for p5js")

(provide 'ob-p5js)

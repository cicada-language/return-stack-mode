;;; return-stack-mode.el -- major mode for editing return-stack code

;; Copyright (C) 2015, XIE Yuheng <xyheme@gmail.com>

;; Author: XIE Yuheng <xyheme@gmail.com>

;; Permission to use, copy, modify, and/or distribute this software
;; for any purpose with or without fee is hereby granted,
;; provided that the above copyright notice
;; and this permission notice appear in all copies.

;; THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
;; WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
;; MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
;; ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
;; WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
;; ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
;; OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

(require 'xyh-emacs-lib)
(provide 'return-stack-mode)

;; a syntax-table is a char-table
;; ``forward-word'' should act as finely as possible,
;; however, my highlighting must use
;; ``word-start'' and ``word-end''
;; to match the zero-length-string of start/end of a return-stack-word,
;; of which the constituent is from ascii.33 to ascii.126
;; so, I have to redefine the functions such as ``forward-word''.
(make-syntaxes return-stack-mode-syntax-table
               ;; default is word constituent
               ;; whitespace characters:
               (   '(0 . 32)    "-"  )
               (      127       "-"  ))

;; (make-syntaxes return-stack-mode-syntax-table
;;                ;; note that, if modify one syntax entry twice
;;                ;; the second will shadow the first
;;                ;; whitespace characters:
;;                (   '(0 . 32)    "-"  )
;;                (      127       "-"  )
;;                ;; symbol constituent:
;;                ;; the following functions need this:
;;                ;; ``forward-word'' and so on ...
;;                ;; (  '(33 . 47)    "_"  )
;;                ;; (  '(58 . 64)    "_"  )
;;                ;; (  '(91 . 96)    "_"  )
;;                ;; ( '(123 . 126)   "_"  )
;;                ;; open/close delimiter:
;;                ;; the following functions need this:
;;                ;; ``forward-sexp'' ``backward-sexp''
;;                ;; ``mark-sexp'' and so on ...
;;                (  ?\(    "("  )
;;                (  ?\)    ")"  )
;;                (  ?\[    "("  )
;;                (  ?\]    ")"  )
;;                (  ?\{    "("  )
;;                (  ?\}    ")"  )
;;                )

(make-syntaxes return-stack-mode-syntax-table-with-symbol&with-open/close-delimiter
               ;; note that, if modify one syntax entry twice
               ;; the second will shadow the first
               ;; whitespace characters:
               (   '(0 . 32)    "-"  )
               (      127       "-"  )
               ;; symbol constituent:
               ;; the following functions need this:
               ;; ``forward-word'' and so on ...
               (  '(33 . 47)    "_"  )
               (  '(58 . 64)    "_"  )
               (  '(91 . 96)    "_"  )
               ( '(123 . 126)   "_"  )
               ;; open/close delimiter:
               ;; the following functions need this:
               ;; ``forward-sexp'' ``backward-sexp''
               ;; ``mark-sexp'' and so on ...
               (  ?\(    "("  )
               (  ?\)    ")"  )
               (  ?\[    "("  )
               (  ?\]    ")"  )
               (  ?\{    "("  )
               (  ?\}    ")"  ))

(make-syntaxes return-stack-mode-syntax-table-with-symbol
               ;; note that, if modify one syntax entry twice
               ;; the second will shadow the first
               ;; whitespace characters:
               (   '(0 . 32)    "-"  )
               (      127       "-"  )
               ;; symbol constituent:
               ;; the following functions need this:
               ;; ``forward-word'' and so on ...
               (  '(33 . 47)    "_"  )
               (  '(58 . 64)    "_"  )
               (  '(91 . 96)    "_"  )
               ( '(123 . 126)   "_"  ))

(make-syntaxes return-stack-mode-syntax-table-with-open/close-delimiter
               ;; note that, if modify one syntax entry twice
               ;; the second will shadow the first
               ;; whitespace characters:
               (   '(0 . 32)    "-"  )
               (      127       "-"  )
               ;; open/close delimiter:
               ;; the following functions need this:
               ;; ``forward-sexp'' ``backward-sexp''
               ;; ``mark-sexp'' and so on ...
               (  ?\(    "("  )
               (  ?\)    ")"  )
               (  ?\[    "("  )
               (  ?\]    ")"  )
               (  ?\{    "("  )
               (  ?\}    ")"  ))

(defun return-stack-rebinding-functions-with-symbol-help (rebinding)
  `(define-key a-keymap ,(car rebinding)
     '(lambda ()
       (interactive)
       (with-syntax-table
           return-stack-mode-syntax-table-with-symbol
         (,(cadr rebinding))))))
(defmacro return-stack-rebinding-functions-with-symbol (&rest lis)
  (cons 'progn
        (mapcar
         (function return-stack-rebinding-functions-with-symbol-help)
         lis)))

(defun return-stack-rebinding-functions-with-open/close-delimiter-help (rebinding)
  `(define-key a-keymap ,(car rebinding)
     '(lambda ()
       (interactive)
       (with-syntax-table
           return-stack-mode-syntax-table-with-open/close-delimiter
         (,(cadr rebinding))))))
(defmacro return-stack-rebinding-functions-with-open/close-delimiter (&rest lis)
  (cons 'progn
        (mapcar
         (function return-stack-rebinding-functions-with-open/close-delimiter-help)
         lis)))

(defun return-stack-rebinding-functions-with-symbol&with-open/close-delimiter-help (rebinding)
  `(define-key a-keymap ,(car rebinding)
     '(lambda ()
       (interactive)
       (with-syntax-table
           return-stack-mode-syntax-table-with-symbol&with-open/close-delimiter
         (,(cadr rebinding))))))
(defmacro return-stack-rebinding-functions-with-symbol&with-open/close-delimiter (&rest lis)
  (cons 'progn
        (mapcar
         (function return-stack-rebinding-functions-with-symbol&with-open/close-delimiter-help)
         lis)))

(defun say-this-key-is-not-bound ()
  (interactive)
  (message "this key is not bound!"))

(setq return-stack-mode-map
      (let ((a-keymap (make-keymap)))

        ;; rebinding functions which look syntax-table
        (return-stack-rebinding-functions-with-symbol&with-open/close-delimiter
         ((kbd "s-s") forward-sexp)
         ((kbd "s-w") backward-sexp)
         ;; ((kbd "s-a") mark-sexp)
         ((kbd "s-e") in->)
         ((kbd "s-q") <-out)
         ((kbd "s-d") out->)
         ((kbd "M-f") forward-word)
         ((kbd "M-b") backward-word))
        (return-stack-rebinding-functions-with-symbol
         ((kbd "M-d") (lambda () (kill-word 1)))
         ((kbd "M-DEL") (lambda () (backward-kill-word 1))))

        ;; no bother:
        (define-key a-keymap (kbd "M-t") 'say-this-key-is-not-bound)
        (define-key a-keymap (kbd "M-o") 'say-this-key-is-not-bound)
        (define-key a-keymap (kbd "M-l") 'say-this-key-is-not-bound)
        (define-key a-keymap (kbd "M-c") 'say-this-key-is-not-bound)

        ;; for indentation:
        (define-key a-keymap (kbd "M-u") 'move-line-backword)
        (define-key a-keymap (kbd "M-i") 'move-line-foreword)
        (define-key a-keymap (kbd "<tab>") '(lambda () (interactive) nil))

        ;; for comment:
        (define-key a-keymap (kbd "<menu> <menu>")
          '(lambda () (interactive)
            (insert "<< ")
            (point-to-register 666)
            (insert " -- >>")
            (jump-to-register 666)))

        a-keymap))


(make-faces
 (return-stack-number-face           ((default (:foreground "#fd971f" :bold t))))
 (return-stack-bool-face             ((default (:foreground "#fd971f" :bold t))))
 (return-stack-variable-face         ((default (:foreground "#fd971f"))))
 (return-stack-constant-face         ((default (:foreground "#fd971f" :bold t))))

 (return-stack-comment-face          ((default (:foreground "#FF8888"))))
 (return-stack-end-face              ((default (:foreground "#00ffff" :bold t))))
 (return-stack-exception-face        ((default (:foreground "#00ffff" :bold t))))
 (return-stack-syntax-key-word-face  ((default (:foreground "#f92672" :bold t))))

 (return-stack-sentence-reader-face  ((default (:foreground "#ffff00" :bold t))))
 (return-stack-word-to-define-face   ((default (:foreground "#ef5939" :bold t))))
 (return-stack-lexicographer-face    ((default (:foreground "#ae81ff" :bold t))))
 (return-stack-type-face             ((default (:foreground "#fd971f"))))
 (return-stack-char-face             ((default (:foreground "#e6db78"))))
 (return-stack-string-face           ((default (:foreground "#e6db74"))))
 (return-stack-wody-face             ((default (:foreground "#a6e22e" :bold t))))

 (return-stack-fetch-local-variable-1-face ((default (:foreground "#83EA83" :bold t))))
 (return-stack-fetch-local-variable-2-face ((default (:foreground "#5CDD5C" :bold t))))
 (return-stack-fetch-local-variable-3-face ((default (:foreground "#3DCD3D" :bold t))))
 (return-stack-fetch-local-variable-4-face ((default (:foreground "#1DBB1D" :bold t))))

 (return-stack-save-local-variable-1-face ((default (:foreground "#FF4C4C" :bold t))))
 (return-stack-save-local-variable-2-face ((default (:foreground "#dc322f" :bold t))))
 (return-stack-save-local-variable-3-face ((default (:foreground "#D41C1C" :bold t))))
 (return-stack-save-local-variable-4-face ((default (:foreground "#AF0B0B" :bold t))))
 (return-stack-save-local-variable-@-face ((default (:foreground "#AE7C3B" :bold t))))

 (return-stack-square-brackets-face ((default (:foreground "#93a8c6"))))
 (return-stack-parentheses-face     ((default (:foreground "#b0b1a3"))))
 (return-stack-curly-braces-face    ((default (:foreground "#aebed8"))))

 ;;;; 
 (return-stack-line-face   ((default (:foreground "#ae81ff" :bold t))))
 (return-stack-jo-face     ((default (:foreground "#ef5939" :bold t))))
 (return-stack-the-jo-face ((default (:foreground "#fd971f" :bold t))))
 (return-stack-bar-ket-face   ((default (:foreground "#dc322f" :bold t)))) 
 )


;; non blank:
;; (not (in (0 . 32) 127))
;; alphabet or number:
;; (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))


(setq
 return-stack-font-lock-keywords
 `(;; in the following, order matters

   ;; string
   (,(rx (minimal-match
          (seq word-start
               (group "\""
                      (one-or-more (not (in 34)))
                      "\"")
               word-end)))
     (1 'return-stack-string-face))

   ;; comment
   (;; ,(rx (minimal-match
    ;;       (seq (minimal-match
    ;;             (seq word-start
    ;;                  (group "<<")
    ;;                  word-end
    ;;                  (minimal-match (group (zero-or-more anything)))))
    ;;            ;; (minimal-match
    ;;            ;;  (seq word-start
    ;;            ;;       (group ">>")
    ;;            ;;       word-end))
    ;;            (seq word-start
    ;;                 (group ">>")
    ;;                 word-end)
    ;;            )))
    ,(rx (seq (minimal-match
               (seq word-start
                    (group "<<")
                    word-end
                    (minimal-match (group (zero-or-more anything)))))
              ;; (minimal-match
              ;;  (seq word-start
              ;;       (group ">>")
              ;;       word-end))
              (seq word-start
                   (group ">>")
                   word-end)))
     (1 'return-stack-comment-face t)
     (2 'return-stack-comment-face t)
     (3 'return-stack-comment-face t))

   ;; very special words
   (,(rx word-start
         (group "("
                (or "end"
                    "<>")
                ")")
         word-end)
     (1 'return-stack-end-face))
   
   (,(rx word-start
         (group "("
                (or ;; "literal"
                 "branch"
                 "address"
                 "jo"
                 ;; "char"
                 ;; "string"
                 "false?branch"
                 "if"
                 "else"
                 "then"
                 )
                ")")
         word-end)
     (1 'return-stack-syntax-key-word-face))


   ;; lexicographer & reader for lexicographer
   (,(rx (seq word-start
              (group (or ":"))
              (one-or-more " ")
              (group (one-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-sentence-reader-face)
     (2 'return-stack-word-to-define-face))

   (,(rx word-start
         (group (or ";"))
         word-end)
     (1 'return-stack-sentence-reader-face)
     (,(rx word-start
           (group (one-or-more (not (in (0 . 32) 127))))
           word-end)
       nil
       nil
       (1 'return-stack-lexicographer-face)))

   ;; number
   (,(rx word-start
         (group (zero-or-one "-")
                (one-or-more (in (?0 . ?9))))
         word-end)
     (1 'return-stack-number-face))

   ;; constant
   (,(rx word-start
         (group ":"
                (one-or-more (not (in (0 . 32) 127)))
                ":")
         word-end)
     (1 'return-stack-constant-face))
   (,(rx word-start
         (group "+"
                (one-or-more (not (in (0 . 32) 127)))
                "+")
         word-end)
     (1 'return-stack-constant-face))

   ;; variable
   (,(rx (seq word-start
              (group "*"
                     (one-or-more (not (in (0 . 32) 127)))
                     "*")
              word-end))
     (1 'return-stack-variable-face))

   ;; important-noun
   (,(rx word-start
         (group (or "false"
                    "true"
                    ))
         word-end)
     (1 'return-stack-bool-face))

   ;; char
   (,(rx (seq word-start
              (group "'"
                     (zero-or-more (not (in (0 . 32) 127)))
                     "'")
              word-end))
     (1 'return-stack-char-face))

   ;; exception   
   (,(rx (seq word-start
              (group "("
                     "!"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127)))
                     ")")
              word-end))
     (1 'return-stack-exception-face))
   
   ;; fetch-local-variable
   (,(rx (seq word-start
              (group ":"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-fetch-local-variable-1-face))
   (,(rx (seq word-start
              (group "::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-fetch-local-variable-2-face))
   (,(rx (seq word-start
              (group ":::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-fetch-local-variable-3-face))
   (,(rx (seq word-start
              (group "::::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-fetch-local-variable-4-face))
   
   ;; save-local-variable
   (,(rx (seq word-start
              (group ">:"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-save-local-variable-1-face))
   (,(rx (seq word-start
              (group "@:"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-save-local-variable-@-face))
   (,(rx (seq word-start
              (group ">::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-save-local-variable-2-face))
   (,(rx (seq word-start
              (group ">:::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-save-local-variable-3-face))
   (,(rx (seq word-start
              (group ">::::"
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127))))
              word-end))
     (1 'return-stack-save-local-variable-4-face))

   ;; wody
   (,(rx (seq word-start
              (group
               (or
                (seq (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     (zero-or-more (not (in (0 . 32) 127)))
                     (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     ":")
                (seq (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))
                     ":")))
              word-end))
     (1 'return-stack-wody-face))


   ;; type
   (,(rx (seq word-start
              (group "<"
                     (one-or-more (not (in (0 . 32) 127)))
                     ">")
              word-end))
     (1 'return-stack-type-face))



   ;;;;
   (,(rx word-start
         (group (one-or-more "-"))
         word-end)
     (1 'return-stack-line-face))
   
   (,(rx (seq (group "[")
              (zero-or-more (in (0 . 32) 127))
              (group (one-or-more (not (in (0 . 32) 127))))
              (zero-or-more (in (0 . 32) 127))
              (group "]")
              ))
     (1 'return-stack-bar-ket-face)
     (2 'return-stack-the-jo-face)
     (3 'return-stack-bar-ket-face))

   (,(rx 
         (group "("
                (one-or-more (not (in (0 . 32) 127)))
                ")")
         )
     (1 'return-stack-jo-face))

   ))


(defvar return-stack-mode-hook nil)


;;;###autoload
(add-to-list 'auto-mode-alist '("\\.cn$" . return-stack-mode))

(defun return-stack-mode ()
  "major mode for editing return-stack language files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table return-stack-mode-syntax-table)
  (use-local-map return-stack-mode-map)
  (set (make-local-variable 'font-lock-defaults)
       '(return-stack-font-lock-keywords))
  (set (make-local-variable 'comment-start) "<<")
  (set (make-local-variable 'comment-end)   ">>")
  (set (make-local-variable 'comment-style) 'aligned)
  (setq major-mode 'return-stack-mode)
  (setq mode-name "return-stack")
  (turn-off-indent)
  (run-hooks 'return-stack-mode-hook))

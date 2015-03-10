;;;;; this is bloody hack
;;;;; sorry for this
;;;;; for I still have no patience with emacs-lisp
;;;;; I will write a better text editor
;;;;; and do good hack then







;;; return-stack-mode.el -- major mode for editing return-stack code


;; Copyright (C) 2014, XIE Yuheng <xyheme@gmail.com>

;; Author: XIE Yuheng <xyheme@gmail.com>
;; Version: 2014.05.31

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


;;; Superfluous words :

;; you know what !!
;; when I first finish this mode,
;; my return-stack code suddenly become so lovely,
;; too lovely,
;; I just stare at them for a while,
;; and can not even write down a new word !


;;; Usage :

;; Do not insert ascii TAB char in return-stack-mode.

;; add the following to your ``.emacs'' :
;; (add-to-list 'load-path "{path to the directory that contain xyh-emacs-lib.el}")
;; (add-to-list 'load-path "{path to the directory that contain return-stack-mode.el}")
;; (require 'return-stack-mode)

;; note that
;; auto-indentation is not supported by return-stack-mode.el
;; because auto-indentation functions written by other people
;; always do not satisfy my need,
;; while I provide the following functions to help you to indent your code :
;; ``turn-on-indent'' ``turn-off-indent''
;; ``move-line-foreword'' ``move-line-backword''
;; these four functions are defined in ``xyh-emacs-lib.el''

;; if you want to use other colors to highlight the code
;; just uncomment the ``color-test'' parts in
;; ``make-faces'' and ``setq return-stack-font-lock-keywords''
;; restart emacs, and add the following words into
;; a buffer with ``return-stack-mode'',
;; you will see these words highlighted,
;; then you could just make your choices
;; and hack the definitions of syntax highlighting :

;; ;; << basic color : >>
;; ;; basic-ff0000-red
;; ;; basic-00ff00-green
;; ;; basic-0000ff-blue

;; ;; << basic molokai : >>
;; ;; molokai-f92672-pink
;; ;; molokai-fd971f-orange
;; ;; molokai-a6e22e-chartreuse
;; ;; molokai-ae81ff-purple
;; ;; molokai-e6db74-darkgoldenrod

;; ;; << basic molokai & solarized : >>
;; ;; DarkGreen
;; ;; solarized-859900-green
;; ;; DarkOliveGreen4
;; ;; molokai-808000-olive
;; ;; molokai-a6e22e-chartreuse
;; ;; solarized-b58900-yellow
;; ;; molokai-fd971f-orange
;; ;; molokai-e6db74-darkgoldenrod
;; ;; solarized-cb4b16-orange
;; ;; solarized-dc322f-red
;; ;; Firebrick
;; ;; molokai-800000-maroon
;; ;; molokai-960050-wine
;; ;; molokai-008080-teal
;; ;; solarized-2aa198-cyan
;; ;; solarized-268bd2-blue
;; ;; molokai-00ffff-aqua
;; ;; molokai-66d9ef-blue
;; ;; solarized-6c71c4-violet
;; ;; CadetBlue
;; ;; molokai-7070f0-slateblue
;; ;; molokai-ae81ff-purple
;; ;; Pink4
;; ;; molokai-d33682-palevioletred
;; ;; molokai-f92672-pink

;; ;; l1-depth-light-707183
;; ;; l2-depth-light-7388d6
;; ;; l3-depth-light-909183
;; ;; l4-depth-light-709870
;; ;; l5-depth-light-907373
;; ;; l6-depth-light-6276ba
;; ;; l7-depth-light-858580
;; ;; l8-depth-light-80a880
;; ;; l9-depth-light-887070

;; ;; l1-depth-dark--grey55
;; ;; l2-depth-dark--93a8c6
;; ;; l3-depth-dark--b0b1a3
;; ;; l4-depth-dark--97b098
;; ;; l5-depth-dark--aebed8
;; ;; l6-depth-dark--b0b0b3
;; ;; l7-depth-dark--90a890
;; ;; l8-depth-dark--a2b6da
;; ;; l9-depth-dark--9cb6ad

;; by the way, I use molokai-theme in emacs, I recommend it.



;;; the way I use return-stack-mode :
;; (add-to-list 'load-path "~/.emacs.d/return-stack-mode/")
;; (require 'return-stack-mode)
;; (require 'inferior-return-stack-mode)

;; ;; (define-prefix-command 'C-s-map)
;; ;; (global-set-key (kbd "C-s") 'C-s-map)
;; (defun switch-to-buffer-*return-stack* ()
;;   (interactive)
;;   (if (member-string? "*return-stack*" (mapcar 'buffer-name (buffer-list)))
;;       (let ()
;;         (switch-to-buffer "*return-stack*")
;;         (local-set-key (kbd "C-s C-d") 'previous-buffer))
;;     (let ()
;;       (run-return-stack "return-stack"))))
;; (global-set-key (kbd "C-s C-d") 'switch-to-buffer-*return-stack>>

;; (add-hook 'return-stack-mode-hook
;;  (lambda ()
;;    (local-set-key (kbd "C-h") 'hippie-expand)
;;    (local-set-key (kbd "M-q") 'query-replace)
;;    (local-set-key (kbd "C-c C-e")
;;                   'return-stack-send-region-and-split-window)
;;    (local-set-key (kbd "C-<tab>")
;;                   'return-stack-send-line-and-split-window-and-goto-next-line)))


;;; Bugs:

;; 1 :
;; sometimes, when using ``<<'' at the beginning, and ``>>'' at the end,
;; to comment many lines of code,
;; syntax highlighting of the comment will fail.
;; to kill this bug,
;; one HAVE TO scan almost the whole buffer very frequently,
;; this will make the performance unacceptable (to me).
;; And I will wait for a better text editor to solve this problem.
;; I will NOT provide ``\'' and ``end-of-line'' as a another pair
;; to make comment in return-stack,
;; NOR will I comment many continuous lines
;; with many ``<<'' ``>>'' pairs in my return-stack code.
;; because my friends and I will write a new text editor to solve this !!



;;; Code :

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






(make-faces
 (return-stack-end-face             ((default (:foreground "#00ffff" :bold t))))
 (return-stack-syntax-key-word-face  ((default (:foreground "#f92672" :bold t))))

 (return-stack-number-face           ((default (:foreground "Pink4"))))

 (return-stack-sentence-reader-face  ((default (:foreground "#ffff00" :bold t))))

 (return-stack-jo-face     ((default (:foreground "#ef5939" :bold t))))
 (return-stack-the-jo-face ((default (:foreground "#fd971f" :bold t))))
 
 (return-stack-lexicographer-face    ((default (:foreground "#ae81ff" :bold t))))

 (return-stack-variable-face             ((default (:foreground "#fd971f"))))
 (return-stack-type-face             ((default (:foreground "#fd971f"))))

 (return-stack-line-face   ((default (:foreground "#ae81ff" :bold t))))

   (return-stack-bound-variable-one-face   ((default (:foreground "#268bd2" :bold t))))
 (return-stack-bound-variable-two-face   ((default (:foreground "#66d9ef" :bold t))))
 (return-stack-bound-variable-three-face ((default (:foreground "#008080" :bold t))))
 (return-stack-bound-variable-four-face  ((default (:foreground "#2aa198" :bold t))))

 (return-stack-lambda-argument-one-face   ((default (:foreground "#cb4b16" :bold t))))

 (return-stack-bar-ket-face   ((default (:foreground "#dc322f" :bold t))))

 (return-stack-lambda-argument-three-face ((default (:foreground "#800000" :bold t))))
 (return-stack-lambda-argument-four-face  ((default (:foreground "Firebrick" :bold t))))


 (return-stack-wody-face            ((default (:foreground "#a6e22e" :bold t))))

 (return-stack-square-brackets-face  ((default (:foreground "#93a8c6"))))
 (return-stack-parentheses-face      ((default (:foreground "#b0b1a3"))))
 (return-stack-curly-braces-face     ((default (:foreground "#aebed8"))))
 ;; 97b098




 ;; color-test:

 ;; (Firebrick       ((default (:foreground "Firebrick"))))
 ;; (Pink4           ((default (:foreground "Pink4"))))
 ;; (DarkGreen       ((default (:foreground "DarkGreen"))))
 ;; (DarkOliveGreen4 ((default (:foreground "DarkOliveGreen4"))))
 ;; (CadetBlue       ((default (:foreground "CadetBlue"))))
 ;; (Firebrick       ((default (:foreground "Firebrick"))))

 ;; (basic-0000ff-blue     ((default (:foreground "#0000ff"))))
 ;; (basic-00ff00-green    ((default (:foreground "#00ff00"))))
 ;; (basic-ff0000-red      ((default (:foreground "#ff0000"))))

 ;; (molokai-ffffff-white         ((default (:foreground "#ffffff"))))
 ;; (molokai-f8f8f0-fg            ((default (:foreground "#f8f8f0"))))
 ;; (molokai-ff0000-red           ((default (:foreground "#ff0000"))))
 ;; (molokai-f92672-pink          ((default (:foreground "#f92672"))))
 ;; (molokai-ef5939-orange+5      ((default (:foreground "#ef5939"))))
 ;; (molokai-fd971f-orange        ((default (:foreground "#fd971f"))))
 ;; (molokai-ffff00-yellow        ((default (:foreground "#ffff00"))))
 ;; (molokai-e6db74-darkgoldenrod ((default (:foreground "#e6db74"))))
 ;; (molokai-c4be89-wheat         ((default (:foreground "#c4be89"))))
 ;; (molokai-808000-olive         ((default (:foreground "#808000"))))
 ;; (molokai-a6e22e-chartreuse    ((default (:foreground "#a6e22e"))))
 ;; (molokai-00ff00-lime          ((default (:foreground "#00ff00"))))
 ;; (molokai-008000-green         ((default (:foreground "#008000"))))
 ;; (molokai-1e0010-darkwine      ((default (:foreground "#1e0010"))))
 ;; (molokai-800000-maroon        ((default (:foreground "#800000"))))
 ;; (molokai-960050-wine          ((default (:foreground "#960050"))))
 ;; (molokai-008080-teal          ((default (:foreground "#008080"))))
 ;; (molokai-00ffff-aqua          ((default (:foreground "#00ffff"))))
 ;; (molokai-66d9ef-blue          ((default (:foreground "#66d9ef"))))
 ;; (molokai-7070f0-slateblue     ((default (:foreground "#7070f0"))))
 ;; (molokai-ae81ff-purple        ((default (:foreground "#ae81ff"))))
 ;; (molokai-d33682-palevioletred ((default (:foreground "#d33682"))))

 ;; (solarized-002b36-base03  ((default (:foreground "#002b36"))))
 ;; (solarized-073642-base02  ((default (:foreground "#073642"))))
 ;; (solarized-586e75-base01  ((default (:foreground "#586e75"))))
 ;; (solarized-657b83-base00  ((default (:foreground "#657b83"))))
 ;; (solarized-839496-base0   ((default (:foreground "#839496"))))
 ;; (solarized-93a1a1-base1   ((default (:foreground "#93a1a1"))))
 ;; (solarized-eee8d5-base2   ((default (:foreground "#eee8d5"))))
 ;; (solarized-fdf6e3-base3   ((default (:foreground "#fdf6e3"))))
 ;; (solarized-b58900-yellow  ((default (:foreground "#b58900"))))
 ;; (solarized-cb4b16-orange  ((default (:foreground "#cb4b16"))))
 ;; (solarized-dc322f-red     ((default (:foreground "#dc322f"))))
 ;; (solarized-d33682-magenta ((default (:foreground "#d33682"))))
 ;; (solarized-6c71c4-violet  ((default (:foreground "#6c71c4"))))
 ;; (solarized-268bd2-blue    ((default (:foreground "#268bd2"))))
 ;; (solarized-2aa198-cyan    ((default (:foreground "#2aa198"))))
 ;; (solarized-859900-green   ((default (:foreground "#859900"))))

 ;; (l1-depth-light-707183 ((default (:foreground "#707183"))))
 ;; (l1-depth-dark--grey55 ((default (:foreground "#grey55" ))))
 ;; (l2-depth-light-7388d6 ((default (:foreground "#7388d6"))))
 ;; (l2-depth-dark--93a8c6 ((default (:foreground "#93a8c6"))))
 ;; (l3-depth-light-909183 ((default (:foreground "#909183"))))
 ;; (l3-depth-dark--b0b1a3 ((default (:foreground "#b0b1a3"))))
 ;; (l4-depth-light-709870 ((default (:foreground "#709870"))))
 ;; (l4-depth-dark--97b098 ((default (:foreground "#97b098"))))
 ;; (l5-depth-light-907373 ((default (:foreground "#907373"))))
 ;; (l5-depth-dark--aebed8 ((default (:foreground "#aebed8"))))
 ;; (l6-depth-light-6276ba ((default (:foreground "#6276ba"))))
 ;; (l6-depth-dark--b0b0b3 ((default (:foreground "#b0b0b3"))))
 ;; (l7-depth-light-858580 ((default (:foreground "#858580"))))
 ;; (l7-depth-dark--90a890 ((default (:foreground "#90a890"))))
 ;; (l8-depth-light-80a880 ((default (:foreground "#80a880"))))
 ;; (l8-depth-dark--a2b6da ((default (:foreground "#a2b6da"))))
 ;; (l9-depth-light-887070 ((default (:foreground "#887070"))))
 ;; (l9-depth-dark--9cb6ad ((default (:foreground "#9cb6ad"))))

 )


;; non blank:
;; (not (in (0 . 32) 127))
;; alphabet or number:
;; (not (in (0 . 47) (58 . 64) (91 . 96) (123 . 127)))

(setq
 return-stack-font-lock-keywords
 `(;; in the following, order matters
 
   (,(rx word-start
         (group (or "(end)"))
         word-end)
     (1 'return-stack-end-face))

   (,(rx word-start
         (group (one-or-more "-"))
         word-end)
     (1 'return-stack-line-face))
        
   (,(rx (seq word-start
              (group "[")
              (one-or-more " ")
              (group (one-or-more (not (in (0 . 32) 127))))
              (one-or-more " ")
              (group "]")
              
              word-end))
     (1 'return-stack-bar-ket-face)
     (2 'return-stack-the-jo-face)
     (3 'return-stack-bar-ket-face))

   (,(rx word-start         
         (group "("
                (one-or-more (not (in (0 . 32) 127)))
                ")")
         word-end)
     (1 'return-stack-jo-face))

   ))








;;; return-stack.el --- "return-stack mode" -- editing using quarter-plane screen model

;; Copyright (C) 1985, 1994, 2001-2014 Free Software Foundation, Inc.

;; Author: K. Shane Hartman
;; Maintainer: emacs-devel@gnu.org
;; Keywords: convenience wp

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This code provides the return-stack-mode commands documented in the Emacs
;; manual.  The screen is treated as a semi-infinite quarter-plane with
;; support for rectangle operations and `etch-a-sketch' character
;; insertion in any of eight directions.

;;; Code:

(defgroup return-stack nil
  "Editing text-based return-stacks (\"ASCII art\")."
  :prefix "return-stack-"
  :group 'wp)

(defcustom return-stack-rectangle-ctl ?+
  "Character `return-stack-draw-rectangle' uses for top left corners."
  :type 'character
  :group 'return-stack)
(defcustom return-stack-rectangle-ctr ?+
  "Character `return-stack-draw-rectangle' uses for top right corners."
  :type 'character
  :group 'return-stack)
(defcustom return-stack-rectangle-cbr ?+
  "Character `return-stack-draw-rectangle' uses for bottom right corners."
  :type 'character
  :group 'return-stack)
(defcustom return-stack-rectangle-cbl ?+
  "Character `return-stack-draw-rectangle' uses for bottom left corners."
  :type 'character
  :group 'return-stack)
(defcustom return-stack-rectangle-v   ?|
  "Character `return-stack-draw-rectangle' uses for vertical lines."
  :type 'character
  :group 'return-stack)
(defcustom return-stack-rectangle-h   ?-
  "Character `return-stack-draw-rectangle' uses for horizontal lines."
  :type 'character
  :group 'return-stack)


;; return-stack Movement Commands

(defvar return-stack-desired-column 0
  "Desired current column for return-stack mode.
When a cursor is on a wide-column character (e.g. Chinese,
Japanese, Korean), this may may be different from `current-column'.")


(defun return-stack-update-desired-column (adjust-to-current)
  "Maybe update `return-stack-desired-column'.
If the value of `return-stack-desired-column' is more than one column
from `current-column', or if the argument ADJUST-TO-CURRENT is
non-nil, set it to the current column.  Return `current-column'."
  (let ((current-column (current-column)))
    (if (or adjust-to-current
            (< return-stack-desired-column (1- current-column))
            (> return-stack-desired-column (1+ current-column)))
        (setq return-stack-desired-column current-column))
    current-column))

(defun return-stack-beginning-of-line (&optional arg)
  "Position point at the beginning of the line.
With ARG not nil, move forward ARG - 1 lines first.
If scan reaches end of buffer, stop there without error."
  (interactive "^P")
  (if arg (forward-line (1- (prefix-numeric-value arg))))
  (beginning-of-line)
  (setq return-stack-desired-column 0))

(defun return-stack-end-of-line (&optional arg)
  "Position point after last non-blank character on current line.
With ARG not nil, move forward ARG - 1 lines first.
If scan reaches end of buffer, stop there without error."
  (interactive "^P")
  (if arg (forward-line (1- (prefix-numeric-value arg))))
  (beginning-of-line)
  (skip-chars-backward " \t" (prog1 (point) (end-of-line)))
  (setq return-stack-desired-column (current-column)))

(defun return-stack-forward-column (arg &optional interactive)
  "Move cursor right, making whitespace if necessary.
With argument, move that many columns."
  (interactive "^p\nd")
  (let (deactivate-mark)
    (return-stack-update-desired-column interactive)
    (setq return-stack-desired-column (max 0 (+ return-stack-desired-column arg)))
    (let ((current-column (move-to-column return-stack-desired-column t)))
      (if (and (> current-column return-stack-desired-column)
               (< arg 0))
          ;; It seems that we have just tried to move to the right
          ;; column of a multi-column character.
          (forward-char -1)))))

(defun return-stack-backward-column (arg &optional interactive)
  "Move cursor left, making whitespace if necessary.
With argument, move that many columns."
  (interactive "^p\nd")
  (return-stack-update-desired-column interactive)
  (return-stack-forward-column (- arg)))

(defun return-stack-move-down (arg)
  "Move vertically down, making whitespace if necessary.
With argument, move that many lines."
  (interactive "^p")
  (let (deactivate-mark)
    (return-stack-update-desired-column nil)
    (return-stack-newline arg)
    (let ((current-column (move-to-column return-stack-desired-column t)))
      (if (> current-column return-stack-desired-column)
          (forward-char -1)))))

(defvar return-stack-vertical-step 0
  "Amount to move vertically after text character in return-stack mode.")

(defvar return-stack-horizontal-step 1
  "Amount to move horizontally after text character in return-stack mode.")

(defun return-stack-move-up (arg)
  "Move vertically up, making whitespace if necessary.
With argument, move that many lines."
  (interactive "^p")
  (return-stack-update-desired-column nil)
  (return-stack-move-down (- arg)))

(defun return-stack-movement-right ()
  "Move right after self-inserting character in return-stack mode."
  (interactive)
  (return-stack-set-motion 0 1))

(defun return-stack-movement-left ()
  "Move left after self-inserting character in return-stack mode."
  (interactive)
  (return-stack-set-motion 0 -1))

(defun return-stack-movement-up ()
  "Move up after self-inserting character in return-stack mode."
  (interactive)
  (return-stack-set-motion -1 0))

(defun return-stack-movement-down ()
  "Move down after self-inserting character in return-stack mode."
  (interactive)
  (return-stack-set-motion 1 0))

(defun return-stack-movement-nw (&optional arg)
  "Move up and left after self-inserting character in return-stack mode.
With prefix argument, move up and two-column left."
  (interactive "P")
  (return-stack-set-motion -1 (if arg -2 -1)))

(defun return-stack-movement-ne (&optional arg)
  "Move up and right after self-inserting character in return-stack mode.
With prefix argument, move up and two-column right."
  (interactive "P")
  (return-stack-set-motion -1 (if arg 2 1)))

(defun return-stack-movement-sw (&optional arg)
  "Move down and left after self-inserting character in return-stack mode.
With prefix argument, move down and two-column left."
  (interactive "P")
  (return-stack-set-motion 1 (if arg -2 -1)))

(defun return-stack-movement-se (&optional arg)
  "Move down and right after self-inserting character in return-stack mode.
With prefix argument, move down and two-column right."
  (interactive "P")
  (return-stack-set-motion 1 (if arg 2 1)))

(defun return-stack-set-motion (vert horiz)
  "Set VERTICAL and HORIZONTAL increments for movement in return-stack mode.
The mode line is updated to reflect the current direction."
  (setq return-stack-vertical-step vert
        return-stack-horizontal-step horiz)
  (setq mode-name
        (format "return-stack:%s"
                (nth (+ 2 (% horiz 3) (* 5 (1+ (% vert 2))))
                     '(wnw nw up ne ene Left left none right Right
                           wsw sw down se ese))))
  (force-mode-line-update)
  (message ""))

(defun return-stack-move ()
  "Move in direction of `return-stack-vertical-step' and `return-stack-horizontal-step'."
  (if (/= return-stack-vertical-step 0)
      (return-stack-move-down return-stack-vertical-step))
  (if (/= return-stack-horizontal-step 0)
      (return-stack-forward-column return-stack-horizontal-step)))

(defun return-stack-motion (arg)
  "Move point in direction of current return-stack motion in return-stack mode.
With ARG do it that many times.  Useful for delineating rectangles in
conjunction with diagonal return-stack motion.
Use \"\\[command-apropos] return-stack-movement\" to see commands which control motion."
  (interactive "^p")
  (return-stack-move-down (* arg return-stack-vertical-step))
  (return-stack-forward-column (* arg return-stack-horizontal-step)))

(defun return-stack-motion-reverse (arg)
  "Move point in direction opposite of current return-stack motion in return-stack mode.
With ARG do it that many times.  Useful for delineating rectangles in
conjunction with diagonal return-stack motion.
Use \"\\[command-apropos] return-stack-movement\" to see commands which control motion."
  (interactive "^p")
  (return-stack-motion (- arg)))

(defun return-stack-mouse-set-point (event)
  "Move point to the position of EVENT, making whitespace if necessary."
  (interactive "e")
  (let ((position (event-start event)))
    (unless (posn-area position) ; Ignore EVENT unless in text area
      (let* ((window (posn-window position))
             (frame  (if (framep window) window (window-frame window)))
             (pair   (posn-x-y position))
             (start-pos (window-start window))
             (start-pair (posn-x-y (posn-at-point start-pos)))
             (dx (- (car pair) (car start-pair)))
             (dy (- (cdr pair) (cdr start-pair)))
             (char-ht (frame-char-height frame))
             (spacing (when (display-graphic-p frame)
                        (or (with-current-buffer (window-buffer window)
                              line-spacing)
                            (frame-parameter frame 'line-spacing)))))
        (cond ((floatp spacing)
               (setq spacing (truncate (* spacing char-ht))))
              ((null spacing)
               (setq spacing 0)))
        (goto-char start-pos)
        (return-stack-move-down      (/ dy (+ char-ht spacing)))
        (return-stack-forward-column (/ dx (frame-char-width frame)))))))


;; return-stack insertion and deletion.

(defun return-stack-insert (ch arg)
  (let* ((width (char-width ch))
         ;; We must be sure that the succeeding insertion won't delete
         ;; the just inserted character.
         (return-stack-horizontal-step
          (if (and (= return-stack-vertical-step 0)
                   (> width 1)
                   (< (abs return-stack-horizontal-step) 2))
              (* return-stack-horizontal-step 2)
            return-stack-horizontal-step)))
    (while (> arg 0)
      (setq arg (1- arg))
      (if (/= return-stack-desired-column (current-column))
          (move-to-column return-stack-desired-column t))
      (let ((col (+ return-stack-desired-column width)))
        (or (eolp)
            (let ((pos (point)))
              (move-to-column col t)
              (delete-region pos (point)))))
      (insert ch)
      (forward-char -1)
      (return-stack-move))))

(defun return-stack-self-insert (arg)
  "Insert this character in place of character previously at the cursor.
The cursor then moves in the direction you previously specified
with the commands `return-stack-movement-right', `return-stack-movement-up', etc.
Use \"\\[command-apropos] return-stack-movement\" to see those commands."
  (interactive "p")
  (return-stack-update-desired-column (not (eq this-command last-command)))
  (return-stack-insert last-command-event arg)) ; Always a character in this case.

(defun return-stack-clear-column (arg)
  "Clear out ARG columns after point without moving."
  (interactive "p")
  (let* ((original-col (current-column))
         (target-col (max 0 (+ original-col arg)))
         pos)
    (move-to-column target-col t)
    (setq pos (point))
    (move-to-column original-col)
    (delete-region pos (point))
    (save-excursion
     (indent-to (max target-col original-col))))
  (setq return-stack-desired-column (current-column)))

(defun return-stack-backward-clear-column (arg)
  "Clear out ARG columns before point, moving back over them."
  (interactive "p")
  (return-stack-clear-column (- arg)))

(defun return-stack-clear-line (arg)
  "Clear out rest of line; if at end of line, advance to next line.
Cleared-out line text goes into the kill ring, as do newlines that are
advanced over.  With argument, clear out (and save in kill ring) that
many lines."
  (interactive "P")
  (if arg
      (progn
       (setq arg (prefix-numeric-value arg))
       (kill-line arg)
       (newline (if (> arg 0) arg (- arg))))
    (if (looking-at "[ \t]*$")
        (kill-ring-save (point) (progn (forward-line 1) (point)))
      (kill-region (point) (progn (end-of-line) (point))))))

(defun return-stack-newline (arg)
  "Move to the beginning of the following line.
With argument, moves that many lines (up, if negative argument);
always moves to the beginning of a line."
  (interactive "^p")
  (let ((start (point))
        (lines-left (forward-line arg)))
    (if (and (eobp)
             (> (point) start))
        (newline))
    (if (> lines-left 0)
        (newline lines-left))))

(defun return-stack-open-line (arg)
  "Insert an empty line after the current line.
With positive argument insert that many lines."
  (interactive "p")
  (save-excursion
   (end-of-line)
   (open-line arg)))

(defun return-stack-duplicate-line ()
  "Insert a duplicate of the current line, below it."
  (interactive)
  (save-excursion
   (let ((contents
          (buffer-substring
           (progn (beginning-of-line) (point))
           (progn (return-stack-newline 1) (point)))))
     (forward-line -1)
     (insert contents))))

;; Like replace-match, but overwrites.
(defun return-stack-replace-match (newtext fixedcase literal)
  (let (ocolumn change pos)
    (goto-char (setq pos (match-end 0)))
    (setq ocolumn (current-column))
    ;; Make the replacement and undo it, to see how it changes the length.
    (let ((buffer-undo-list nil)
          list1)
      (replace-match newtext fixedcase literal)
      (setq change (- (current-column) ocolumn))
      (setq list1 buffer-undo-list)
      (while list1
        (setq list1 (primitive-undo 1 list1))))
    (goto-char pos)
    (if (> change 0)
        (delete-region (point)
                       (progn
                         (move-to-column (+ change (current-column)) t)
                         (point))))
    (replace-match newtext fixedcase literal)
    (if (< change 0)
        (insert-char ?\s (- change)))))

;; return-stack Tabs

(defcustom return-stack-tab-chars "!-~"
  "A character set which controls behavior of commands.
\\[return-stack-set-tab-stops] and \\[return-stack-tab-search].
The syntax for this variable is like the syntax used inside of `[...]'
in a regular expression--but without the `[' and the `]'.
It is NOT a regular expression, any regexp special characters will be quoted.
It defines a set of \"interesting characters\" to look for when setting
\(or searching for) tab stops, initially \"!-~\" (all printing characters).
For example, suppose that you are editing a table which is formatted thus:
| foo		| bar + baz | 23  *
| bubbles	| and + etc | 97  *
and that `return-stack-tab-chars' is \"|+*\".  Then invoking
\\[return-stack-set-tab-stops] on either of the previous lines would result
in the following tab stops
                :     :     :     :
Another example - \"A-Za-z0-9\" would produce the tab stops
  :               :	:     :

Note that if you want the character `-' to be in the set, it must be
included in a range or else appear in a context where it cannot be
taken for indicating a range (e.g. \"-A-Z\" declares the set to be the
letters `A' through `Z' and the character `-').  If you want the
character `\\' in the set it must be preceded by itself: \"\\\\\".

The command \\[return-stack-tab-search] is defined to move beneath (or to) a
character belonging to this set independent of the tab stops list."
  :type 'string
  :group 'return-stack)

(defun return-stack-set-tab-stops (&optional arg)
  "Set value of `tab-stop-list' according to context of this line.
This controls the behavior of \\[return-stack-tab].  A tab stop is set at
every column occupied by an \"interesting character\" that is preceded
by whitespace.  Interesting characters are defined by the variable
`return-stack-tab-chars', see its documentation for an example of usage.
With ARG, just (re)set `tab-stop-list' to its default value.  The tab
stops computed are displayed in the minibuffer with `:' at each stop."
  (interactive "P")
  (save-excursion
    (let (tabs)
      (if arg
          (setq tabs (or (default-value 'tab-stop-list)
                         (indent-accumulate-tab-stops (window-width))))
        (let ((regexp (concat "[ \t]+[" (regexp-quote return-stack-tab-chars) "]")))
          (beginning-of-line)
          (let ((bol (point)))
            (end-of-line)
            (while (re-search-backward regexp bol t)
              (skip-chars-forward " \t")
              (setq tabs (cons (current-column) tabs)))
            (if (null tabs)
                (error "No characters in set %s on this line"
                       (regexp-quote return-stack-tab-chars))))))
      (setq tab-stop-list tabs)
      (let ((blurb (make-string (1+ (nth (1- (length tabs)) tabs)) ?\ )))
        (while tabs
          (aset blurb (car tabs) ?:)
          (setq tabs (cdr tabs)))
        (message blurb)))))

(defun return-stack-tab-search (&optional arg)
  "Move to column beneath next interesting char in previous line.
With ARG move to column occupied by next interesting character in this
line.  The character must be preceded by whitespace.
\"interesting characters\" are defined by variable `return-stack-tab-chars'.
If no such character is found, move to beginning of line."
  (interactive "^P")
  (let ((target (current-column)))
    (save-excursion
      (if (and (not arg)
               (progn
                 (beginning-of-line)
                 (skip-chars-backward
                  (concat "^" (regexp-quote return-stack-tab-chars))
                  (point-min))
                 (not (bobp))))
          (move-to-column target))
      (if (re-search-forward
           (concat "[ \t]+[" (regexp-quote return-stack-tab-chars) "]")
           (line-end-position)
           'move)
          (setq target (1- (current-column)))
        (setq target nil)))
    (if target
        (move-to-column target t)
      (beginning-of-line))))

(defun return-stack-tab (&optional arg)
  "Tab transparently (just move point) to next tab stop.
With prefix arg, overwrite the traversed text with spaces.  The tab stop
list can be changed by \\[return-stack-set-tab-stops] and \\[edit-tab-stops].
See also documentation for variable `return-stack-tab-chars'."
  (interactive "^P")
  (let* ((opoint (point)))
    (move-to-tab-stop)
    (if arg
        (let (indent-tabs-mode
              (column (current-column)))
          (delete-region opoint (point))
          (indent-to column)))))

;; return-stack Rectangles

(defvar return-stack-killed-rectangle nil
  "Rectangle killed or copied by \\[return-stack-clear-rectangle] in return-stack mode.
The contents can be retrieved by \\[return-stack-yank-rectangle]")

(defun return-stack-clear-rectangle (start end &optional killp)
  "Clear and save rectangle delineated by point and mark.
The rectangle is saved for yanking by \\[return-stack-yank-rectangle] and replaced
with whitespace.  The previously saved rectangle, if any, is lost.  With
prefix argument, the rectangle is actually killed, shifting remaining text."
  (interactive "r\nP")
  (setq return-stack-killed-rectangle (return-stack-snarf-rectangle start end killp)))

(defun return-stack-clear-rectangle-to-register (start end register &optional killp)
  "Clear rectangle delineated by point and mark into REGISTER.
The rectangle is saved in REGISTER and replaced with whitespace.  With
prefix argument, the rectangle is actually killed, shifting remaining text.

Interactively, reads the register using `register-read-with-preview'."
  (interactive (list (region-beginning) (region-end)
                     (register-read-with-preview "Rectangle to register: ")
                     current-prefix-arg))
  (set-register register (return-stack-snarf-rectangle start end killp)))

(defun return-stack-snarf-rectangle (start end &optional killp)
  (let ((column (current-column))
        (indent-tabs-mode nil))
    (prog1 (save-excursion
             (if killp
                 (delete-extract-rectangle start end)
               (prog1 (extract-rectangle start end)
                      (clear-rectangle start end))))
           (move-to-column column t))))

(defun return-stack-yank-rectangle (&optional insertp)
  "Overlay rectangle saved by \\[return-stack-clear-rectangle]
The rectangle is positioned with upper left corner at point, overwriting
existing text.  With prefix argument, the rectangle is inserted instead,
shifting existing text.  Leaves mark at one corner of rectangle and
point at the other (diagonally opposed) corner."
  (interactive "P")
  (if (not (consp return-stack-killed-rectangle))
      (error "No rectangle saved")
    (return-stack-insert-rectangle return-stack-killed-rectangle insertp)))

(defun return-stack-yank-at-click (click arg)
  "Insert the last killed rectangle at the position clicked on.
Also move point to one end of the text thus inserted (normally the end).
Prefix arguments are interpreted as with \\[yank].
If `mouse-yank-at-point' is non-nil, insert at point
regardless of where you click."
  (interactive "e\nP")
  (or mouse-yank-at-point (mouse-set-point click))
  (return-stack-yank-rectangle arg))

(defun return-stack-yank-rectangle-from-register (register &optional insertp)
  "Overlay rectangle saved in REGISTER.
The rectangle is positioned with upper left corner at point, overwriting
existing text.  With prefix argument, the rectangle is
inserted instead, shifting existing text.  Leaves mark at one corner
of rectangle and point at the other (diagonally opposed) corner.

Interactively, reads the register using `register-read-with-preview'."
  (interactive (list (register-read-with-preview "Rectangle from register: ")
                     current-prefix-arg))
  (let ((rectangle (get-register register)))
    (if (not (consp rectangle))
        (error "Register %c does not contain a rectangle" register)
      (return-stack-insert-rectangle rectangle insertp))))

(defun return-stack-insert-rectangle (rectangle &optional insertp)
  "Overlay RECTANGLE with upper left corner at point.
Optional argument INSERTP, if non-nil causes RECTANGLE to be inserted.
Leaves the region surrounding the rectangle."
  (let ((indent-tabs-mode nil))
    (if (not insertp)
        (save-excursion
          (delete-rectangle (point)
                            (progn
                              (return-stack-forward-column (length (car rectangle)))
                              (return-stack-move-down (1- (length rectangle)))
                              (point)))))
    (push-mark)
    (insert-rectangle rectangle)))

(defun return-stack-current-line ()
  "Return the vertical position of point.  Top line is 1."
  (+ (count-lines (point-min) (point))
     (if (= (current-column) 0) 1 0)))

(defun return-stack-draw-rectangle (start end)
  "Draw a rectangle around region."
  (interactive "*r")                    ; start will be less than end
  (let* ((sl     (return-stack-current-line))
         (sc     (current-column))
         (pvs    return-stack-vertical-step)
         (phs    return-stack-horizontal-step)
         (c1     (progn (goto-char start) (current-column)))
         (r1     (return-stack-current-line))
         (c2     (progn (goto-char end) (current-column)))
         (r2     (return-stack-current-line))
         (right  (max c1 c2))
         (left   (min c1 c2))
         (top    (min r1 r2))
         (bottom (max r1 r2)))
    (goto-char (point-min))
    (forward-line (1- top))
    (move-to-column left t)
    (return-stack-update-desired-column t)

    (return-stack-movement-right)
    (return-stack-insert return-stack-rectangle-ctl 1)
    (return-stack-insert return-stack-rectangle-h (- right return-stack-desired-column))

    (return-stack-movement-down)
    (return-stack-insert return-stack-rectangle-ctr 1)
    (return-stack-insert return-stack-rectangle-v (- bottom (return-stack-current-line)))

    (return-stack-movement-left)
    (return-stack-insert return-stack-rectangle-cbr 1)
    (return-stack-insert return-stack-rectangle-h (- return-stack-desired-column left))

    (return-stack-movement-up)
    (return-stack-insert return-stack-rectangle-cbl 1)
    (return-stack-insert return-stack-rectangle-v (- (return-stack-current-line) top))

    (return-stack-set-motion pvs phs)
    (goto-char (point-min))
    (forward-line (1- sl))
    (move-to-column sc t)))


;; return-stack Keymap, entry and exit points.

(defalias 'return-stack-delete-char 'delete-char)

(defvar return-stack-mode-map
  (let ((map (make-keymap)))
    (define-key map [remap self-insert-command] 'return-stack-self-insert)
    (define-key map [remap self-insert-command] 'return-stack-self-insert)
    (define-key map [remap completion-separator-self-insert-command]
      'return-stack-self-insert)
    (define-key map [remap completion-separator-self-insert-autofilling]
      'return-stack-self-insert)
    (define-key map [remap forward-char] 'return-stack-forward-column)
    (define-key map [remap right-char] 'return-stack-forward-column)
    (define-key map [remap backward-char] 'return-stack-backward-column)
    (define-key map [remap left-char] 'return-stack-backward-column)
    (define-key map [remap delete-char] 'return-stack-clear-column)
    ;; There are two possibilities for what is normally on DEL.
    (define-key map [remap backward-delete-char-untabify]
      'return-stack-backward-clear-column)
    (define-key map [remap delete-backward-char] 'return-stack-backward-clear-column)
    (define-key map [remap kill-line] 'return-stack-clear-line)
    (define-key map [remap open-line] 'return-stack-open-line)
    (define-key map [remap newline] 'return-stack-newline)
    (define-key map [remap newline-and-indent] 'return-stack-duplicate-line)
    (define-key map [remap next-line] 'return-stack-move-down)
    (define-key map [remap previous-line] 'return-stack-move-up)
    (define-key map [remap move-beginning-of-line] 'return-stack-beginning-of-line)
    (define-key map [remap move-end-of-line] 'return-stack-end-of-line)
    (define-key map [remap mouse-set-point] 'return-stack-mouse-set-point)
    (define-key map "\C-c\C-d" 'return-stack-delete-char)
    (define-key map "\e\t" 'return-stack-toggle-tab-state)
    (define-key map "\t" 'return-stack-tab)
    (define-key map "\e\t" 'return-stack-tab-search)
    (define-key map "\C-c\t" 'return-stack-set-tab-stops)
    (define-key map "\C-c\C-k" 'return-stack-clear-rectangle)
    (define-key map "\C-c\C-w" 'return-stack-clear-rectangle-to-register)
    (define-key map "\C-c\C-y" 'return-stack-yank-rectangle)
    (define-key map "\C-c\C-x" 'return-stack-yank-rectangle-from-register)
    (define-key map "\C-c\C-r" 'return-stack-draw-rectangle)
    (define-key map "\C-c\C-c" 'return-stack-mode-exit)
    (define-key map "\C-c\C-f" 'return-stack-motion)
    (define-key map "\C-c\C-b" 'return-stack-motion-reverse)
    (define-key map "\C-c<" 'return-stack-movement-left)
    (define-key map "\C-c>" 'return-stack-movement-right)
    (define-key map "\C-c^" 'return-stack-movement-up)
    (define-key map "\C-c." 'return-stack-movement-down)
    (define-key map "\C-c`" 'return-stack-movement-nw)
    (define-key map "\C-c'" 'return-stack-movement-ne)
    (define-key map "\C-c/" 'return-stack-movement-sw)
    (define-key map "\C-c\\" 'return-stack-movement-se)
    (define-key map [(control ?c) left]  'return-stack-movement-left)
    (define-key map [(control ?c) right] 'return-stack-movement-right)
    (define-key map [(control ?c) up]    'return-stack-movement-up)
    (define-key map [(control ?c) down]  'return-stack-movement-down)
    (define-key map [(control ?c) home]  'return-stack-movement-nw)
    (define-key map [(control ?c) prior] 'return-stack-movement-ne)
    (define-key map [(control ?c) end]   'return-stack-movement-sw)
    (define-key map [(control ?c) next]  'return-stack-movement-se)
    map)
  "Keymap used in `return-stack-mode'.")

(defcustom return-stack-mode-hook nil
  "If non-nil, its value is called on entry to return-stack mode.
return-stack mode is invoked by the command \\[return-stack-mode]."
  :type 'hook
  :group 'return-stack)

(defvar return-stack-mode-old-local-map)
(defvar return-stack-mode-old-mode-name)
(defvar return-stack-mode-old-major-mode)
(defvar return-stack-mode-old-truncate-lines)

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.return$" . return-stack-mode))

;;;###autoload
(defun return-stack-mode ()
  "Switch to return-stack mode, in which a quarter-plane screen model is used.
\\<return-stack-mode-map>
Printing characters replace instead of inserting themselves with motion
afterwards settable by these commands:

 Move left after insertion:            \\[return-stack-movement-left]
 Move right after insertion:           \\[return-stack-movement-right]
 Move up after insertion:              \\[return-stack-movement-up]
 Move down after insertion:            \\[return-stack-movement-down]

 Move northwest (nw) after insertion:  \\[return-stack-movement-nw]
 Move northeast (ne) after insertion:  \\[return-stack-movement-ne]
 Move southwest (sw) after insertion:  \\[return-stack-movement-sw]
 Move southeast (se) after insertion:  \\[return-stack-movement-se]

 Move westnorthwest (wnw) after insertion:  C-u \\[return-stack-movement-nw]
 Move eastnortheast (ene) after insertion:  C-u \\[return-stack-movement-ne]
 Move westsouthwest (wsw) after insertion:  C-u \\[return-stack-movement-sw]
 Move eastsoutheast (ese) after insertion:  C-u \\[return-stack-movement-se]

The current direction is displayed in the mode line.  The initial
direction is right.  Whitespace is inserted and tabs are changed to
spaces when required by movement.  You can move around in the buffer
with these commands:

 Move vertically to SAME column in previous line: \\[return-stack-move-down]
 Move vertically to SAME column in next line:     \\[return-stack-move-up]
 Move to column following last
  non-whitespace character:                       \\[return-stack-end-of-line]
 Move right, inserting spaces if required:        \\[return-stack-forward-column]
 Move left changing tabs to spaces if required:   \\[return-stack-backward-column]
 Move in direction of current return-stack motion:     \\[return-stack-motion]
 Move opposite to current return-stack motion:         \\[return-stack-motion-reverse]
 Move to beginning of next line:                  \\[next-line]

You can edit tabular text with these commands:

 Move to column beneath (or at) next interesting
  character (see variable `return-stack-tab-chars'):   \\[return-stack-tab-search]
 Move to next stop in tab stop list:              \\[return-stack-tab]
 Set tab stops according to context of this line: \\[return-stack-set-tab-stops]
   (With ARG, resets tab stops to default value.)
 Change the tab stop list:                        \\[edit-tab-stops]

You can manipulate text with these commands:
 Clear ARG columns after point without moving:    \\[return-stack-clear-column]
 Delete char at point:                            \\[return-stack-delete-char]
 Clear ARG columns backward:                      \\[return-stack-backward-clear-column]
 Clear ARG lines, advancing over them:            \\[return-stack-clear-line]
  (the cleared text is saved in the kill ring)
 Open blank line(s) beneath current line:         \\[return-stack-open-line]

You can manipulate rectangles with these commands:
  Clear a rectangle and save it:                  \\[return-stack-clear-rectangle]
  Clear a rectangle, saving in a named register:  \\[return-stack-clear-rectangle-to-register]
  Insert currently saved rectangle at point:      \\[return-stack-yank-rectangle]
  Insert rectangle from named register:           \\[return-stack-yank-rectangle-from-register]
  Draw a rectangular box around mark and point:   \\[return-stack-draw-rectangle]
  Copies a rectangle to a register:               \\[copy-rectangle-to-register]
  Undo effects of rectangle overlay commands:     \\[undo]

You can return to the previous mode with \\[return-stack-mode-exit], which
also strips trailing whitespace from every line.  Stripping is suppressed
by supplying an argument.

Entry to this mode calls the value of `return-stack-mode-hook' if non-nil.

Note that return-stack mode commands will work outside of return-stack mode, but
they are not by default assigned to keys."
  (interactive)


  (if (eq major-mode 'return-stack-mode)
      (error "You are already editing a return-stack")

      (set-syntax-table return-stack-mode-syntax-table)
      (set (make-local-variable 'font-lock-defaults)
           '(return-stack-font-lock-keywords))
      
      (set (make-local-variable 'return-stack-mode-old-local-map) (current-local-map))
      (use-local-map return-stack-mode-map)
      (set (make-local-variable 'return-stack-mode-old-mode-name) mode-name)
      (set (make-local-variable 'return-stack-mode-old-major-mode) major-mode)
      (setq major-mode 'return-stack-mode)
      (set (make-local-variable 'return-stack-killed-rectangle) nil)
      (set (make-local-variable 'tab-stop-list) (default-value 'tab-stop-list))
      (set (make-local-variable 'return-stack-tab-chars)
           (default-value 'return-stack-tab-chars))
      (make-local-variable 'return-stack-vertical-step)
      (make-local-variable 'return-stack-horizontal-step)
      (set (make-local-variable 'return-stack-mode-old-truncate-lines) truncate-lines)
      (setq truncate-lines t)
      (return-stack-set-motion 0 1)

      ;; edit-return-stack-hook is what we used to run, return-stack-mode-hook is in doc.
      (run-hooks 'edit-return-stack-hook 'return-stack-mode-hook)
      (message "Type %s in this buffer to return it to %s mode."
               (substitute-command-keys "\\[return-stack-mode-exit]")
               return-stack-mode-old-mode-name)))

(defun return-stack-mode-exit (&optional nostrip)
  "Undo `return-stack-mode' and return to previous major mode.
With no argument, strip whitespace from end of every line in return-stack buffer;
  otherwise, just return to previous mode.
Runs `return-stack-mode-exit-hook' at the end."
  (interactive "P")
  (if (not (eq major-mode 'return-stack-mode))
      (error "You aren't editing a return-stack")
    (if (not nostrip) (delete-trailing-whitespace))
    (setq mode-name return-stack-mode-old-mode-name)
    (use-local-map return-stack-mode-old-local-map)
    (setq major-mode return-stack-mode-old-major-mode)
    (kill-local-variable 'tab-stop-list)
    (setq truncate-lines return-stack-mode-old-truncate-lines)
    (force-mode-line-update)
    (run-hooks 'return-stack-mode-exit-hook)))

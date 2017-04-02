;;; helpful.el --- a better *help* buffer            -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Wilfred Hughes

;; Author: Wilfred Hughes <me@wilfred.me.uk>
;; Keywords: help, lisp

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

(defvar-local helpful--sym nil)

(defun helpful--buffer (symbol)
  "Return a buffer to show help for SYMBOL in."
  (let ((buf (get-buffer-create
              (format "*helpful: %s" symbol))))
    (with-current-buffer buf
      (setq helpful--sym symbol))))

(defun helpful--update (fn-symbol)
  "Update the current *insight* buffer to the latest state of FN-SYMBOL."
  (let ((inhibit-read-only t)
        (start-pos (point)))
    (erase-buffer)
    (insert
     (format "Symbol: %s\n" fn-symbol))
    (goto-char start-pos)))

(defun helpful (symbol)
  "Show Help for SYMBOL."
  (interactive
   (list (completing-read "Symbol: " obarray
                          nil nil nil nil
                          (symbol-name (symbol-at-point)))))
  (switch-to-buffer (helpful--buffer symbol))
  (helpful-mode)
  (setq-local helpful--sym symbol)
  (helpful--update symbol))

(define-derived-mode helpful-mode special-mode "Helpful")

(defun helpful-update ()
  (interactive)
  (helpful--update helpful--sym))

(define-key helpful-mode-map (kbd "g") #'helpful-update)


(provide 'helpful)
;;; helpful.el ends here

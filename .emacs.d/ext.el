;; switch between template / scss / Backbone view
(defun controller2template (path)
  (setq path (replace-regexp-in-string "src/js/desktop/nomic/view" "src/template" path))
  (setq path (replace-regexp-in-string ".js$" ".html" path))
  path)

(defun template2scss (path)
  (setq path (replace-regexp-in-string "src/template" "src/scss/desktop" path))
  (setq path (replace-regexp-in-string ".html$" ".scss" path))
  (setq path (replace-regexp-in-string "/\\([a-z]+\\).scss$" "/_\\1.scss" path))
  path)

(defun scss2controller (path)
  (setq path (replace-regexp-in-string "src/scss/desktop" "src/js/desktop/nomic/view" path))
  (setq path (replace-regexp-in-string ".scss$" ".js" path))
  (setq path (replace-regexp-in-string "/_\\([a-z]+\\).js$" "/\\1.js" path))
  path)

(defun toggle-controller-template ()
  (interactive)
  (setq path (buffer-file-name))
  (cond ((string-match ".html$" path) (find-file (template2scss path)))
        ((string-match ".scss$" path) (find-file (scss2controller path)))
        ((string-match ".js$" path) (find-file (controller2template path)))
        ))

(global-set-key (kbd "C-x ,") 'toggle-controller-template)


;; find things at point
(defun find-shared-lib (basedir path)
  (setq path (replace-regexp-in-string "^sharedLib" "src/js/shared/lib" path))
  (setq path (format "%s/%s.js" basedir path))
  (find-file path))

(defun find-model (basedir path)
  (setq path (replace-regexp-in-string "^service" "src/js/shared/nomic/service" path))
  (setq path (format "%s/%s.js" basedir path))
  (find-file path))

(defun find-view (basedir path)
  (setq path (replace-regexp-in-string "^view" "src/js/desktop/nomic/view" path))
  (setq path (format "%s/%s.js" basedir path))
  (find-file path))

(defun find-template (basedir path)
  (setq path (replace-regexp-in-string "^template" "src/template" path))
  (setq path (format "%s/%s" basedir path))
  (find-file path))

(defun find-thing ()
  (interactive)
  (setq basedir (car (split-string buffer-file-name "/src/")))
  (setq path (thing-at-point 'filename))
  (cond ((string-match "^service/" path) (find-model basedir path))
        ((string-match "^view/" path) (find-view basedir path))
        ((string-match "^template/" path) (find-template basedir path))
        ((string-match "^sharedLib/" path) (find-shared-lib basedir path))
        (t (message (format "%s: %s" "Failed to locate" path)))
        ))
(global-set-key (kbd "C-x n d") 'find-thing)

(defun trim-string (string)
  "Remove white spaces in beginning and ending of STRING.
White space here is any of: space, tab, emacs newline (line feed, ASCII 10)."
  (replace-regexp-in-string "\\`[ \t\n]*" "" (replace-regexp-in-string "[ \t\n]*\\'" "" string)))
(defun insert-todo ()
  (interactive)
  (insert
   (concat
    "//TODO:"
    (trim-string (shell-command-to-string "date +%Y-%m-%d"))
    ":gsilk: "
   )))
(global-set-key (kbd "C-x n o") 'insert-todo)

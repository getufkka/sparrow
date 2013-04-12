(setq max-lisp-eval-depth 10000)
(setq debug-on-error t)
(setq lintnode-autostart t)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default c-basic-offset 4)

;; Automatically load makefile-mode when opening "Makefile"
(add-to-list 'auto-mode-alist '(".*Makefile\\'" . makefile-mode))

(add-to-list 'load-path "~/.emacs.d")
(require 'thrift-mode)

(require 'nginx-mode)

(require 'yaml-mode)

; markdown
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))

(add-to-list 'load-path "~/.emacs.d/clojure-mode")
(require 'clojure-mode)

;; ===== nrepl =====
(add-to-list 'load-path "~/.emacs.d/nrepl")
(require 'nrepl)
;; Enable eldoc in clojure buffers:
(add-hook 'nrepl-interaction-mode-hook
          'nrepl-turn-on-eldoc-mode)
;; Stop the error buffer from popping up while working
;; in the REPL buffer:
(setq nrepl-popup-stacktraces nil)
;; Make C-c C-z switch to the *nrepl* buffer in the current window
(add-to-list 'same-window-buffer-names "*nrepl*")

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets")

(require 'ido)
    (ido-mode t)
    (setq ido-enable-flex-matching t) ;; enable fuzzy matching

(add-to-list 'load-path
	     "~/.emacs.d/plugins/color-theme")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)))

(add-to-list 'load-path
	     "~/.emacs.d/plugins")
(require 'xcscope)
(require 'cmake-mode)

(require 'protobuf-mode)
(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))

; ----- auto-complete -----
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
; Load the default configuration
(require 'auto-complete-config)
; Make sure we can find the dictionaries
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/dict")
; Use dictionaries by default(setq-default ac-sources (add-to-list 'ac-sources 'ac-source-dictionary))
(global-auto-complete-mode t)
; Start auto-completion after 2 characters of a word(setq ac-auto-start 2)
; case sensitivity is important when finding matches
(setq ac-ignore-case nil)
(define-key ac-complete-mode-map "\t" 'ac-complete)

; Go
(add-to-list 'load-path "." t)
(require 'go-mode-load)

; yasnippet
(global-set-key (kbd "C-x y n") 'yas/new-snippet)
(global-set-key (kbd "C-x y r") 'yas/reload-all)
(global-set-key (kbd "C-x y v") 'yas/visit-snippet-file)

; --- useful ---
; M-q fill-paragraph

(setq ruby-indent-level 2)
(setq inhibit-splash-screen t)

; --- experimental ---
; (keyboard-translate ?\C(global-set-key (kbd C-h) 'backward-word)-
; (global-set-key (kbd "C-h") 'backward-sentence)
; (global-set-key (kbd "C-t") 'forward-sentence)
;(keyboard-translate ?\C-p ?\C-k)
;(keyboard-translate ?\C-h ?\C-p)
;(keyboard-translate ?\C-t ?\C-n)
;(keyboard-translate ?\C-c ?\M-f)
;(keyboard-translate ?\C-m ?\C-f)
;(keyboard-translate ?\C-i ?\C-x)
; (global-set-key (kbd C-h) 'backward-word)
(put 'set-goal-column 'disabled nil)

(setq auto-mode-alist
      (append
       ;; File name (within directory) starts with a dot.
       '(("/\\.[^/]*\\'" . shell-script-mode)
	 ;; File name has no dot.
	 ("/[^\\./]*\\'" . fundamental-mode))
	 auto-mode-alist))

(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))
(global-set-key (kbd "C-c +") 'increment-number-at-point)

(add-to-list 'load-path "~/.emacs.d/egg" t)
(require 'egg)
(load-file "~/.emacs.d/egg/egg-grep.el")

(add-to-list 'load-path "~/.emacs.d/scss-mode" t)
(require 'scss-mode)

(add-to-list 'load-path "~/.emacs.d/lua" t)
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(menu-bar-mode -1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(css-indent-offset 2)
 '(js2-auto-insert-catch-block t)
 '(js2-enter-indents-newline t)
 '(js2-indent-on-enter-key t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(erb-exec-face ((t (:foreground "green"))))
 '(erb-face ((((class color) (min-colors 8)) (:foreground "yellow"))))
 '(erb-out-delim-face ((t (:foreground "red"))))
 '(erb-out-face ((t (:foreground "yellow"))))
 '(minibuffer-prompt ((t (:foreground "blue"))))
 '(vertical-border ((((type tty)) (:inherit mode-line-inactive)))))

(menu-bar-mode 0)

(setq load-path (append (list (expand-file-name "~/.emacs.d/js2")) load-path))
;; (autoload 'js2-mode "js2-mode" nil t)
;; (add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(setq js-indent-level 4)

(setq scss-compile-at-save nil)

;; auto mode setting
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; git
(defun reload-init-el ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c r") 'reload-init-el)
(global-set-key (kbd "C-c g") 'vc-git-grep)
(global-set-key (kbd "C-x w") 'whitespace-mode)
(global-set-key (kbd "C-x p") 'eval-buffer)
(global-set-key (kbd "C-x /") 'comment-or-uncomment-region)

(put 'upcase-region 'disabled nil)

(load-file "~/.emacs.d/ext.el")

(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(autoload 'espresso-mode "espresso")



(add-to-list 'load-path "~/.emacs.d/ac-nrepl" t)
(require 'ac-nrepl)
 (add-hook 'nrepl-mode-hook 'ac-nrepl-setup)
 (add-hook 'nrepl-interaction-mode-hook 'ac-nrepl-setup)
 (eval-after-load "auto-complete"
   '(add-to-list 'ac-modes 'nrepl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))
(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

(add-hook 'nrepl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'nrepl-interaction-mode-hook 'set-auto-complete-as-completion-at-point-function)

(define-key nrepl-interaction-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)


(add-to-list 'load-path "~/.emacs.d/dash" t)
(add-to-list 'load-path "~/.emacs.d/s" t)
(add-to-list 'load-path "~/.emacs.d/projectile" t)
(require 'projectile)
(projectile-global-mode)

(autoload 'find-file-in-project "find-file-in-project" "Find file in project." t)
(global-set-key (kbd "C-x n f") 'find-file-in-project)

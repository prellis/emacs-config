;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Needed for Emacs v 22.x
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(setenv "GNUSERV_SHOW_EMACS" "1")
;;(setq gnuserv-frame (selected-frame))
;;(require 'gnuserv)
;;(gnuserv-start)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs Perforce Library (slow)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;(load-library "p4")

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Path Info
(setq exec-path (append '("C:/utils/Cygwin/bin") exec-path))
(setenv "PATH" (concat "C:/utils/Cygwin/bin;" (getenv "PATH")))

;; Find command
(setq find-program "C:/utils/Cygwin/bin/find.exe")
(setq grep-program "C:/utils/Cygwin/bin/grep.exe")

;; Emacs Package Manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;(add-to-list 'load-path "~/.emacs.d/git")
;;(require 'git)
;;(require 'git-blame)

;; nxhtml and php-mode are non-standard emacs installs
(autoload 'nxhtml-mumamo-mode "nxhtml/autostart.el" nil t)
(add-hook 'nxhtml-mumamo-mode-hook (lambda () (mumamo-alt-php-tags-mode 1)))
(add-to-list 'auto-mode-alist '("\\.php$" . nxhtml-mumamo-mode))
;;(add-to-list 'auto-mode-alist '("\\.inc$" . nxhtml-mumamo-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; gas-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(require 'gas-mode)
;(add-to-list 'auto-mode-alist '("\\.S\\'" . gas-mode))
;(add-to-list 'auto-mode-alist '("\\.s\\'" . gas-mode))
;(add-to-list 'auto-mode-alist '("\\.inc$" . gas-mode))

;(add-hook 'gas-mode-hook
;          (lambda ()
;            (setq gas-opcode-column 4)
;            (setq gas-argument-column 12)
;            (setq gas-comment-column 36)
            ;; remove trailing whitespaces
;            (add-hook 'before-save-hook
;                      'delete-trailing-whitespace nil t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rust-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'rust-mode)
;; (setq rust-format-on-save t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; c-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'cc-mode)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq c-basic-offset 2)
            (setq substatement-open 0)
;;            (setq-default c-block-comment-prefix "* ")
            (setq-default c-block-comment-prefix " ")
            (c-set-offset 'substatement-open 0)
            (c-set-offset 'statement-case-open 0)
            (c-set-offset 'brace-list-open 0)
            (c-set-offset 'arglist-close
                          '(c-lineup-arglist-close-under-paren))
            (c-set-offset 'arglist-intro '(+))))


(font-lock-add-keywords 'cc-mode
  '(("uint8" . font-lock-keyword-face)
    ("uint16" . font-lock-keyword-face)
    ("uint32" . font-lock-keyword-face)
    ("boolean" . font-lock-keyword-face)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PHP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'php-mode-hook
	  (lambda ()
	    (require 'cc-mode)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SCons files should use python mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("SConscript" . python-mode))
(add-to-list 'auto-mode-alist '("*SCons*" . python-mode))
(add-to-list 'auto-mode-alist '("*scons*" . python-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PlantUML
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'iimage)
(autoload 'iimage-mode "iimage" "Support Inline image minor mode." t)
(autoload 'turn-on-iimage-mode "iimage" "Turn on Inline image minor mode." t)
(add-to-list 'iimage-mode-image-regex-alist '("@startuml\s+\\(.+\\)" . 1))

;; Rendering plantuml
(defun plantuml-render-buffer ()
  (interactive)
  (message "PLANTUML Start rendering")
  (shell-command (concat
                  (shell-quote-argument "C:/Program Files (x86)/Java/jre1.8.0_102/bin/")
                  "java -jar C:/users/pellis/Downloads/plantuml.jar "
                  (shell-quote-argument buffer-file-name)))
  (message (concat "PLANTUML Rendered:  " (buffer-name))))

;; Image reloading
(defun reload-image-at-point ()
  (interactive)
  (message "reloading image at point in the current buffer...")
  (image-refresh (get-text-property (point) 'display)))

;; Image resizing and reloading
(defun resize-image-at-point ()
  (interactive)
  (message "resizing image at point in the current buffer123...")
  (let* ((image-spec (get-text-property (point) 'display))
         (file (cadr (member :file image-spec))))
    (message (concat "resizing image..." file))
    (shell-command (format "convert -resize %d %s %s "
                           (* (window-width (selected-window)) (frame-char-width))
                           file file))
    (reload-image-at-point)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc Settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; My custom settings group
(defgroup NonStandard nil "Custom variables from .emacs" :group 'emacs)

;; Delete trailing whitespace option
(defcustom delete-whitespace-on-save t
  "Controls behavior when saving file.  Value should be nil or non-nil."
  :type 'boolean
  :group 'NonStandard)

;; Delete trailing whitespace save hook
(add-hook 'before-save-hook
          (lambda ()
            (unless (eq delete-whitespace-on-save nil)
              (message "Deleting whitespace when saving")
              (delete-trailing-whitespace))))

;; Menu and Title Bar Customization
(setq frame-title-format "%b (%f)")
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Supress the GNU startup message
(setq inhibit-startup-message t)

;; Default file-encoding to Unix
(setq default-buffer-file-coding-system 'unix)

(setq default-directory "C:/Users/pellis/OneDrive - Qualcomm/Documents")

;; Turn on font-lock (Required for syntax highlighting)
(global-font-lock-mode 1)

(global-auto-revert-mode 1)

(setq font-lock-maximum-size 512000)

;; Show the matching parenthesis
(setq show-paren-delay '1)
(setq show_paren-mode t)

;; Emacs will wrap lines over 77 chars long
(setq fill-column 77)

;; Emacs starts up with a 78 char width
(set-frame-width (selected-frame) 78)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Load the default saved emacs session
;; (desktop-load-default)

;; Disabled functions
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook
          (lambda ()
            (setq org-plantuml-jar-path
                  (expand-file-name "C:/users/pellis/Downloads/plantuml.jar"))
            (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
            (org-babel-do-load-languages 'org-babel-load-languages
                                         '((plantuml . t)))
            (setq org-ditaa-jar-path "C:/users/pellis/Downloads/ditaa.jar")
            (org-babel-do-load-languages 'org-babel-load-languages
                                         '((ditaa . t)))
            (setq explicit-shell-file-name "C:/Program Files/Git/bin/sh.exe")
            (org-babel-do-load-languages 'org-babel-load-languages
                                         '((shell . t)))
            (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))
            (org-babel-do-load-languages 'org-babel-load-languages
                                         '((dot . t)))))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; FiraCode font was obtained from https://github.com/tonsky/FiraCode/

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(grep-command "grep -nie ")
 '(grep-find-command
   "find . -name \"*.[cChHsS]\" -print0 | xargs -0 -e grep -nie ")
 '(markdown-command
   "C:/Users/pellis/AppData/Local/Pandoc/pandoc.exe --standalone -t html5")
 '(org-beamer-environments-extra '(("onlyenv" "O" "\\begin{onlyenv}%a" "\\end{onlyenv}")))
 '(org-confirm-babel-evaluate nil)
 '(package-selected-packages
   '(graphviz-dot-mode markdown-mode lua-mode plantuml-mode rust-mode magit))
 '(revert-without-query '("1"))
 '(shell-file-name "C:/Program Files/Git/bin/sh.exe")
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style 'forward nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "SystemWindow" :foreground "SystemWindowText" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Fira Code Retina")))))

(global-set-key (kbd "M-<return>") 'complete-tag)

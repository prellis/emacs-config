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

(setq default-directory "C:/Users/pellis/")

;;title bar customization
(setq frame-title-format "%b (%f)")

;; Supress the GNU startup message
(setq inhibit-startup-message t)

;; Disable toolbar
(tool-bar-mode -1)

;; Turn on font-lock (Required for syntax highlighting)
(global-font-lock-mode 1)
(setq font-lock-maximum-size 512000)

;; Path Info
(setq exec-path (append '("C:/utils/Cygwin/bin") exec-path))
(setenv "PATH" (concat "C:/utils/Cygwin/bin;" (getenv "PATH")))

;; Find command
(setq find-program "C:/utils/Cygwin/bin/find.exe")
(setq grep-program "C:/utils/Cygwin/bin/grep.exe")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-mode stuff conditionally loaded when cmode is turned on
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(defun activate-ctypes-on-cmode () 
;  ;; ctypes stuff:
;  (require 'ctypes)
;  (ctypes-read-file nil nil t t)
;  (setq ctypes-write-types-at-exit t)
;  (ctypes-auto-parse-mode 1)
;  )

;; nxhtml and php-mode are non-standard emacs installs
(autoload 'nxhtml-mumamo-mode "nxhtml/autostart.el" nil t)
(add-hook 'nxhtml-mumamo-mode-hook (lambda () (mumamo-alt-php-tags-mode 1)))
(add-to-list 'auto-mode-alist '("\\.php$" . nxhtml-mumamo-mode))
;;(add-to-list 'auto-mode-alist '("\\.inc$" . nxhtml-mumamo-mode))


(require 'gas-mode)
(add-to-list 'auto-mode-alist '("\\.S\\'" . gas-mode))
(add-to-list 'auto-mode-alist '("\\.s\\'" . gas-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . gas-mode))

(add-hook 'gas-mode-hook
          (lambda ()
            (setq gas-opcode-column 4)
            (setq gas-argument-column 12)
            (setq gas-comment-column 36)
            ;; remove trailing whitespaces
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))


(add-hook 'php-mode-hook
	  (lambda ()
	    (require 'cc-mode)))

(add-hook 'c-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
             '(("\\<\\(FIXME\\):" 1 font-lock-warning-face prepend)
               ("\\<\\(TODO\\):" 1 font-lock-warning-face prepend)
               ("\\<\\(TRUE\\|FALSE\\)" 0 font-lock-constant-face prepend)
               ("\\(!\\)" 0 font-lock-warning-face)
               ("\\(&&\\|||\\|==\\|!=\\)" 0 font-lock-keyword-face)
               ("\\<boolean\\>" 0 font-lock-type-face)
               ("\\<uint32\\>" 0 font-lock-type-face)
               ("\\<int32\\>" 0 font-lock-type-face)
               ("\\<uint16\\>" 0 font-lock-type-face)
               ("\\<int16\\>" 0 font-lock-type-face)
               ("\\<uint8\\>" 0 font-lock-type-face)
               ("\\<int8\\>" 0 font-lock-type-face)
               ("\\<\\(\\w+_type\\|\\w+_t\\)\\>" 0 font-lock-type-face)))
            ;; remove trailing whitespaces
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))

(add-hook 'c-mode-hook
          (lambda ()
            ;; c stuff
            (setq c-basic-offset 2)
            (setq substatement-open 0)
;;            (setq-default c-block-comment-prefix "* ")
            (setq-default c-block-comment-prefix " ")
            ;; c spacing stuff
            (c-set-offset 'substatement-open 0)
            (c-set-offset 'statement-case-open 0)
            (c-set-offset 'brace-list-open 0)
            (c-set-offset 'arglist-close 
                          '(c-lineup-arglist-close-under-paren))
            (c-set-offset 'arglist-intro '(+))))

; Remove c-mode
;(remove-hook 'c-mode-hook 'activate-ctypes-on-cmode)
;(add-hook 'c-mode-hook 'activate-ctypes-on-cmode)
;(add-hook 'c++-mode-hook 'activate-ctypes-on-cmode)

;; Default file-encoding to Unix
(setq default-buffer-file-coding-system 'unix)

;; Show the matching parenthesis
(setq show-paren-delay '1)
(show-paren-mode t)

;; Emacs will wrap lines over 77 chars long
(setq fill-column 77)

;; Emacs starts up with a 78 char width
(set-frame-width (selected-frame) 78)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

;; Load the default saved emacs session
(desktop-load-default)

;; Disabled functions
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; The following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done 'time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                               EOF                                    ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(grep-command "grep -nie ")
 '(grep-find-command "find . -name \"*.[cChHsS]\" -print0 | xargs -0 -e grep -nie ")
 '(revert-without-query (quote ("1")))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "SystemWindow" :foreground "SystemWindowText" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "outline" :family "Anonymous Pro")))))

(global-set-key (kbd "M-<return>") 'complete-tag)



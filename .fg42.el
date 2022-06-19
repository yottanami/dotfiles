;;; FG42 --- The mighty editor for the emacsians -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2010-2020 Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Version: 3.0.0
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;; Code:
;;; FG42 --- The mighty editor for the emacsians -*- lexical-binding: t; -*-
;;
;; Copyright (c) 2010-2020 Sameer Rahmani <lxsameer@gnu.org>
;;
;; Author: Sameer Rahmani <lxsameer@gnu.org>
;; URL: https://gitlab.com/FG42/FG42
;; Version: 3.0.0
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;; Code:

;; Uncomment this line for debugging
;; (setq debug-on-error t)

(require 'fg42/flags)
(require 'cubes/editor)
(require 'cubes/org)
(require 'cubes/elisp)
(require 'cubes/region-expansion)
(require 'cubes/wm)
(require 'cubes/modeline)
(require 'cubes/autocompletion)
(require 'cubes/golang)
(require 'cubes/project)
(require 'cubes/irc)
(require 'cubes/terminal)
(require 'cubes/java)
(require 'cubes/python)
(require 'cubes/snippets)

(require 'cubes/git)
(require 'cubes/bookmark)
(require 'cubes/terraform)
(require 'cubes/graph)


(defvar global-font-size 12)

(custom-set-faces
 '(mini-modeline-mode-line
   ((((background light))
     :background "#aa0000" :height 0.1 :box nil)
    (t
     :background "#bd93f9" :height 0.1 :box nil))))


(use-flags
 (fg42/merge-with-default-flags
  wm
  python
  golang
  rcirc
  vterm
  company
  lsp
  flycheck
  fg42/region-expansion-cube))


;TODO: Move this blog to a macro or something ===========
(when-wm
 (setq global-font-size 10)
 (custom-set-faces
  '(mini-modeline-mode-line
    ((((background light))
      :background "#aa0000" :height 0.1 :box nil)
     (t
      :background "#6272a4" :height 0.1 :box nil))))
 (fg42/wm-cube :number-of-workspaces 9)

 ;; Change the resolution and monitors to your need
 (defvar monitors
   '(:hdmi-only
     ("--output HDMI-1 --primary"
      "--output eDP-1 --off")
     :hdmi-main
     ("--output DP-3-1-5 --primary"
      "--output eDP-1 --scale 0.5x0.5 --below DP-3-1-5")
     :edp-only
     ("--output eDP-1 --scale 0.5x0.5"
      "--output HDMI-1 --off --output DP-3-1-5 --off")))

 (require 'seq)
 (defun monitor-profiles ()
   (mapcar
    #'car
    (seq-partition monitors 2)))

 (defun monitor (mon)
   (interactive
    (list (completing-read
           "Monitor Profole: "
           (monitor-profiles))))

   (let ((cmd (mapconcat (lambda (x) (format "xrandr %s" x))
                         (plist-get monitors (intern (format "%s" mon)))
                         " && ")))
     (message "Setting monitor profile: %s" cmd)
     (async-shell-command cmd "*xrandr*")))

 (monitor :hdmi-main)

 (use-flags
  (fg42/merge-with-default-flags
   wm
   -python
   -golang
   rcirc
   vterm
   -company
   -projectile
   -lsp
   -flycheck
   fg42/region-expansion-cube)))


;; Both are part of the editor cube  but we want to override
;; their behavior

(fg42/org-cube)
(fg42/cursor-cube :type 'bar :color "#bd93f9")
(fg42/font-cube :font-name "Fira code" :font-size global-font-size)
(fg42/editor-cube)

;;(fg42/imenu-cube)
(fg42/elisp-cube)
(fg42/region-expansion-cube)
(fg42/graphviz-cube)
(fg42/company-cube)
(fg42/lsp-cube)
(fg42/c++-cube)
(fg42/python-cube)
(fg42/yaml-cube)
(fg42/flycheck-cube)

(fg42/golang-cube)
(fg42/projectile-cube)

(fg42/vterm-cube)
(fg42/git-cube)
(fg42/alert-cube)
(fg42/bookmark-cube)
(fg42/terraform-cube)
(fg42/java-cube)
(fg42/yasnippet-cube)

;; Themes should be the last cube and anything that wants to manipulate a face
;; has to use either `fg42/before-initializing-theme-hook' or
;; `fg42/after-initializing-theme-hook' hooks.
(fg42/dracula-theme-cube)
(set-face-attribute 'region nil :background "#888")

(when (file-exists-p "~/.fg42.user.el")
  (load "~/.fg42.user.el"))

(provide 'fg42.user)
;;; fg42.user.el ends here

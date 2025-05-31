;;; dashboard.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2025
;;
;; Author:  <novel2430@MAXSUN-b450m>
;; Maintainer:  <novel2430@MAXSUN-b450m>
;; Created: May 27, 2025
;;
;;
;;
;;
;;
(setq +doom-dashboard-ascii-banner-fn nil)

(defun my-weebery-is-always-greater ()
  (let* ((banner '("██╗  ██╗███████╗██╗     ██╗      ██████╗      " 
                   "██║  ██║██╔════╝██║     ██║     ██╔═══██╗     "
                   "███████║█████╗  ██║     ██║     ██║   ██║     "
                   "██╔══██║██╔══╝  ██║     ██║     ██║   ██║     "
                   "██║  ██║███████╗███████╗███████╗╚██████╔╝     "
                   "╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝ ╚═════╝      "
                   "                                              "
                   "   ███████╗███╗   ███╗ █████╗  ██████╗███████╗"
                   "   ██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝"
                   "   █████╗  ██╔████╔██║███████║██║     ███████╗"
                   "   ██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║"
                   "   ███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║"
                   "   ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝"))
         (longest-line (apply #'max (mapcar #'length banner))))
    (put-text-property
     (point)
     (dolist (line banner (point))
       (insert (+doom-dashboard--center
                +doom-dashboard--width
                (concat line (make-string (max 0 (- longest-line (length line))) 32)))
               "\n"))
     'face 'doom-dashboard-banner)))

(setq +doom-dashboard-ascii-banner-fn #'my-weebery-is-always-greater)

(assoc-delete-all "Reload last session" +doom-dashboard-menu-sections)
(assoc-delete-all "Jump to bookmark" +doom-dashboard-menu-sections)
(assoc-delete-all "Open private configuration" +doom-dashboard-menu-sections)
(assoc-delete-all "Open documentation" +doom-dashboard-menu-sections)

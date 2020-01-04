;; -*- lexical-binding: t -*-
(require 'files)

;;;###autoload
(defun pkgvi (&optional file)
  "Edit a copy of specified file. If no changes are made in the
file, nothing happens. Otherwise the original file is kept as
FILE.orig, and the modified file is saved as FILE. If pkgvi finds
FILE.orig, changes are only made to FILE without affecting
FILE.orig.

See also `pkgdiff'."
  (interactive "fFile to edit with a backup:")

  (unless (file-exists-p file)
    (error "pkgvi: %s: No such file" file))

  (let ((orig-file (concat file ".orig"))
        (notify-of-backup
         (lambda ()
           (message "pkgvi: Backup already exists. For a diff, type: M-x pkgdiff RET"))))

    (find-file file)
    (if (file-exists-p orig-file)
        (progn
          (funcall notify-of-backup)
          (add-hook 'after-save-hook notify-of-backup t t))

      ;; Save the original file to a variable so that we can create a
      ;; backup later. We don't use a temporary buffer for that
      ;; because we don't want it to be killed by user.
      (let ((orig-content (buffer-string)))

        ;; Now that we have switched to a buffer visiting the file,
        ;; install a buffer-local hook to after-save-hook so that,
        ;; when it's called it creates a backup of the original file.
        (let ((save-backup
               (lambda ()
                 (if (file-exists-p orig-file)
                     (funcall notify-of-backup)

                   (if (eq t (compare-strings (buffer-string) nil nil
                                              orig-content nil nil))
                       (message "pkgvi: File unchanged.")

                     (let ((orig-buffer (create-file-buffer orig-file)))
                       (save-current-buffer
                         (set-buffer orig-buffer)
                         (insert orig-content)
                         (write-file orig-file))
                       (kill-buffer orig-buffer))
                     (message "pkgvi: File was modified. For a diff, type: M-x pkgdiff RET"))))))

          (add-hook 'after-save-hook save-backup t t))))))

;;;###autoload
(defun pkgdiff (&optional file)
  "Show differences between the FILE and its backup FILE.orig. If
FILE is nil, the file associated with the current buffer is
chosen.

See also `pkgvi'."
  (interactive)

  (unless file
    (setq file (buffer-file-name)))

  (unless file
    (error "The current buffer isn't associated with any file."))

  (let ((orig-file (concat file ".orig")))
    (unless (file-exists-p orig-file)
      (error "The file has no backup: %s" file))

    (require 'ediff)
    (ediff-files orig-file file)))

(provide 'pkgdiff)

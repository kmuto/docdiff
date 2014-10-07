;; The following kind of elisp, which shows a docdiff of the current file
;; controlled with svn. Mozilla will jump to the current point.
;; Enjoy.
;;	--dancerj (7 Jan 2006, Junichi Uekawa <dancer@debian.org>)

(defun svndocdiff-current ()
  "Invoke svn docdiff for the current buffer,
and run mozilla-firefox -remote openfile(filename)
to preview the diff"
  (interactive)
  (let* ((currentname 
	  (buffer-file-name (current-buffer)))
	 (svnorigname
	  (concat default-directory
		  ".svn/text-base/" 
		  (file-name-nondirectory 
		   (buffer-file-name (current-buffer)))
		  ".svn-base"))
	 (diff-command
	  "/usr/bin/docdiff --html %s %s > %s")
	 (mozilla-command-line
	  "mozilla-firefox -remote 'openurl(file://%s#currentloc)'")
	 (moztmpfile-name
	  (concat default-directory
		  ".svn/.docdifftmp.html")))
    (insert "")
    (save-buffer)
    (backward-delete-char 1)
    (shell-command
     (format diff-command 
	     svnorigname 
	     currentname
	     moztmpfile-name)
     "*svndocdiff*" "*svndocdiff-err*")
    (shell-command
     (format mozilla-command-line
	     moztmpfile-name)
     "*svndocdiff*" "*svndocdiff-err*")))

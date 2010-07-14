;; qmake.el -- qmake mode for emacs
;;
;; Author: Carl Olsen
;;
;; Copyright (c) 2010, carl-olsen
;; All rights reserved.

;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions
;; are met:
;;
;;     * Redistributions of source code must retain the above
;;       copyright notice, this list of conditions and the following
;;       disclaimer.

;;     * Redistributions in binary form must reproduce the above
;;       copyright notice, this list of conditions and the following
;;       disclaimer in the documentation and/or other materials
;;       provided with the distribution.

;;     * Neither the name of the <ORGANIZATION> nor the names of its
;;       contributors may be used to endorse or promote products
;;       derived from this software without specific prior written
;;       permission.


;; THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
;; "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
;; LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
;; FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
;; COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
;; INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
;; SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
;; HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
;; STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
;; ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
;; OF THE POSSIBILITY OF SUCH DAMAGE.




;; -------------------------------------------------------
;; provides qmake-mode for emacs
;; qmake is Qt specific make file.
;; Since there exists no other (what i know of)
;; qmake mode for emacs, i decided to create on.
;; If you think this looks messy, its because
;; Im by know way any hacker when it comes to
;; lisp and in particular elisp. If you find
;; any errors or have any good suggestions,
;; don't hesitate to give me a mail
;;
;;-------------------------------------------------------
(provide 'qmake-mode)

(defvar qmake-mode-hook nil)

(defface qmake-face-platform
      '((t (:foreground "#190eef")))
      "Blue")

(setq qmake-indent-width 4)

(defvar qmake-functions-variables
  '("basename"
    "CONFIG"
    "contains"
    "count"
    "dirname"
    "error"
    "eval"
    "exists"
    "find"
    "for"
    "include"
    "infile"
    "isEmpty"
    "join"
    "member"
    "message"
    "prompt"
    "qoute"
    "sprintf"
    "system"
    "unique"
    "warning"
    "else"
    "unix"
    "win32"
    "mac")
  "Qmake function types"
  )

(defvar qmake-variables
  '("CONFIG"
    "DEFINES"
     "DEF_FILE"
     "DEPENDPATH"
     "DESTDIR"
     "DESTDIR_TARGET"
     "DLLDESTDIR"
     "DISTFILES"
     "DSP_TEMPLATE"
     "FORMS"
     "FORMS3"
     "HEADERS"
     "INCLUDEPATH"
     "INSTALLS"
     "LEXIMPLS"
     "LEXOBJECTS"
     "LEXSOURCES"
     "LIBS"
     "LITERAL_HASH"
     "MAKEFILE"
     "MAKEFILE_GENERATOR"
     "MOC_DIR"
     "OBJECTS"
     "OBJECTS_DIR"
     "OBJMOC"
     "POST_TARGETDEPS"
     "PRE_TARGETDEPS"
     "PRECOMPILED_HEADER"
     "QMAKE"
     "QMAKESPEC"
     "QMAKE_APP_FLAG"
     "QMAKE_APP_OR_DLL"
     "QMAKE_AR_CMD"
     "QMAKE_BUNDLE_DATA"
     "QMAKE_BUNDLE_EXTENSION"
     "QMAKE_CC"
     "QMAKE_CFLAGS_DEBUG"
     "QMAKE_CFLAGS_MT"
     "QMAKE_CFLAGS_MT_DBG"
     "QMAKE_CFLAGS_MT_DLL"
     "QMAKE_CFLAGS_MT_DLLDBG"
     "QMAKE_CFLAGS_RELEASE"
     "QMAKE_CFLAGS_SHLIB"
     "QMAKE_CFLAGS_THREAD"
     "QMAKE_CFLAGS_WARN_OFF"
     "QMAKE_CFLAGS_WARN_ON"
     "QMAKE_CLEAN"
     "QMAKE_CXX"
     "QMAKE_CXXFLAGS"
     "QMAKE_CXXFLAGS_DEBUG"
     "QMAKE_CXXFLAGS_MT"
     "QMAKE_CXXFLAGS_MT_DBG"
     "QMAKE_CXXFLAGS_MT_DLL"
     "QMAKE_CXXFLAGS_MT_DLLDBG"
     "QMAKE_CXXFLAGS_RELEASE"
     "QMAKE_CXXFLAGS_SHLIB"
     "QMAKE_CXXFLAGS_THREAD"
     "QMAKE_CXXFLAGS_WARN_OFF"
     "QMAKE_CXXFLAGS_WARN_ON"
     "QMAKE_EXTENSION_SHLIB"
     "QMAKE_EXT_MOC"
     "QMAKE_EXT_UI"
     "QMAKE_EXT_PRL"
     "QMAKE_EXT_LEX"
     "QMAKE_EXT_YACC"
     "QMAKE_EXT_OBJ"
     "QMAKE_EXT_CPP"
     "QMAKE_EXT_H"
     "QMAKE_FAILED_REQUIREMENTS"
     "QMAKE_FILETAGS"
     "QMAKE_FRAMEWORK_BUNDLE_NAME"
     "QMAKE_FRAMEWORK_VERSION"
     "QMAKE_INCDIR"
     "QMAKE_INCDIR_OPENGL"
     "QMAKE_INCDIR_QT"
     "QMAKE_INCDIR_THREAD"
     "QMAKE_INCDIR_X11"
     "QMAKE_LFLAGS"
     "QMAKE_LFLAGS_CONSOLE"
     "QMAKE_LFLAGS_CONSOLE_DLL"
     "QMAKE_LFLAGS_DEBUG"
     "QMAKE_LFLAGS_PLUGIN"
     "QMAKE_LFLAGS_QT_DLL"
     "QMAKE_LFLAGS_RELEASE"
     "QMAKE_LFLAGS_SHAPP"
     "QMAKE_LFLAGS_SHLIB"
     "QMAKE_LFLAGS_SONAME"
     "QMAKE_LFLAGS_THREAD"
     "QMAKE_LFLAGS_WINDOWS"
     "QMAKE_LFLAGS_WINDOWS_DLL"
     "QMAKE_LIBDIR"
     "QMAKE_LIBDIR_FLAGS"
     "QMAKE_LIBDIR_OPENGL"
     "QMAKE_LIBDIR_QT"
     "QMAKE_LIBDIR_X11"
     "QMAKE_LIBS"
     "QMAKE_LIBS_CONSOLE"
     "QMAKE_LIBS_OPENGL"
     "QMAKE_LIBS_OPENGL_QT"
     "QMAKE_LIBS_QT"
     "QMAKE_LIBS_QT_DLL"
     "QMAKE_LIBS_QT_OPENGL"
     "QMAKE_LIBS_QT_THREAD"
     "QMAKE_LIBS_RT"
     "QMAKE_LIBS_RTMT"
     "QMAKE_LIBS_THREAD"
     "QMAKE_LIBS_WINDOWS"
     "QMAKE_LIBS_X11"
     "QMAKE_LIBS_X11SM"
     "QMAKE_LIB_FLAG"
     "QMAKE_LINK_SHLIB_CMD"
     "QMAKE_POST_LINK"
     "QMAKE_PRE_LINK"
     "QMAKE_LN_SHLIB"
     "QMAKE_MAC_SDK"
     "QMAKE_MAKEFILE"
     "QMAKE_MOC_SRC"
     "QMAKE_QMAKE"
     "QMAKE_QT_DLL"
     "QMAKE_RESOURCE_FLAGS"
     "QMAKE_RUN_CC"
     "QMAKE_RUN_CC_IMP"
     "QMAKE_RUN_CXX"
     "QMAKE_RUN_CXX_IMP"
     "QMAKE_TARGET"
     "QMAKE_UIC"
     "QT"
     "QTPLUGIN"
     "RC_FILE"
     "RCC_DIR"
     "REQUIRES"
     "RES_FILE"
     "SOURCES"
     "SRCMOC"
     "SUBDIRS"
     "TARGET"
     "TARGET_EXT"
     "TARGET_x"
     "TARGET_x.y.z"
     "TEMPLATE"
     "TRANSLATIONS"
     "UICIMPLS"
     "UICOBJECTS"
     "UI_DIR"
     "UI_HEADERS_DIR"
     "UI_SOURCES_DIR"
     "VERSION"
     "VER_MAJ"
     "VER_MIN"
     "VER_PAT"
     "VPATH"
     "YACCIMPLS"
     "YACCOBJECTS"
     "YACCSOURCES")
  "Qmake variables"
  )

(defvar qmake-functions-regexp (regexp-opt qmake-functions-variables 'words))
(defvar qmake-variables-regexp (regexp-opt qmake-variables 'words))


(setq qmake-key-words
      (list
       '("#.*" . font-lock-comment-face)
       `(,qmake-functions-regexp . ,font-lock-function-name-face)
       `(,qmake-variables-regexp . ,font-lock-builtin-face)
       )
      )


(add-to-list 'auto-mode-alist '("\\.pro\\'" . qmake-mode))




(define-derived-mode qmake-mode fundamental-mode
  (setq font-lock-defaults '(qmake-key-words))
  (setq mode-name "qmake mode")
  (set (make-local-variable 'indent-line-function) 'qmake-ident-line)

)


(defun qmake-ident-line()
  "Trying to make a qmake identation"
(interactive)
(let ((savep (> (current-column) (current-indentation)))
      (indent (condition-case nil (max (qmake-calculate-indentation) 0)
                (error 0))))
  (if savep
      (save-excursion (indent-line-to indent))
    (indent-line-to indent)
    )
  )
)


(defun qmake-calculate-indentation()
   "This fucntion calculates the indentation for the "
   (beginning-of-line)

   (let (
         (new-indent (get-prev-line-indent))
         ( prev-indent (get-prev-line-indent) )
         )

     ;; If we are at the start of the line
     ;; there is no indentation.
     (if (bobp)
         0
       ;; Check if the previous line is a {
       ;; In that case add on a new indent width...
       (if (is-prev-curly-forward)
           (setq new-indent (+ prev-indent qmake-indent-width))
         )
       ;; If the current line is a } closing bracket,
       ;; remove identation width
       (if (looking-at "[ \t]*}")
           (setq new-indent (- prev-indent qmake-indent-width))
        )


       )


     (if (> 0 new-indent)
         (progn
           (message "Damn %d" new-indent)
           0)
       (progn
         (message "indent %d" new-indent)
         new-indent)
       )
     )
   )






(defun get-prev-line-indent()
  "Gets the previous line indentation"
  (progn
    (forward-line -1)
    (let (
          ( prev-indent (current-indentation))
          )
      (forward-line 1)
      prev-indent)
    )
  )






(defun is-prev-curly-forward()
  "Checks if the previous line contains a curly bracket, that is \"{\" "
  (interactive)
  (beginning-of-line)
  (forward-line -1)
  (if (looking-at "[ \t]*\\(}[a-z]*\\|\\([a-z]*\\)\\((.+,.+)\\|(.+)\\|(.+,.+,.+)\\)\\|\\)[ \t]*{")
      (progn
        (message "Curly forward")
        (forward-line 1)
        t)
    (progn
      (message "Ingen bracket")
      (forward-line 1)
      nil)
    )
  )








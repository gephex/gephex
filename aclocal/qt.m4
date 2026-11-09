dnl qt.m4 - locate Qt 5 through pkg-config.
dnl AM_PATH_QT(MINIMUM_VERSION, LIBEXT, [ACTION-IF-FOUND [, ACTION-IF-NOT-FOUND]])
AC_DEFUN([AM_PATH_QT],
[
AC_ARG_VAR([MOC], [path to the Qt 5 meta object compiler])
AC_ARG_VAR([UIC], [path to the Qt 5 user interface compiler])
PKG_CHECK_MODULES([QT], [Qt5Core >= $1 Qt5Gui Qt5Widgets],
                  [have_qt_pc=yes], [have_qt_pc=no])
if test "x$have_qt_pc" = "xyes"; then
  dnl Qt 5 built with reduce-relocations requires position independent code
  QT_CXXFLAGS="$QT_CFLAGS -fPIC"
  qt_host_bins=`$PKG_CONFIG --variable=host_bins Qt5Core`
  AC_PATH_PROGS([MOC], [moc-qt5 moc], [no], [$qt_host_bins:$PATH])
  AC_PATH_PROGS([UIC], [uic-qt5 uic], [no], [$qt_host_bins:$PATH])
  if test "x$MOC" = "xno" || test "x$UIC" = "xno"; then
    have_qt_pc=no
  fi
fi
AC_SUBST(QT_CXXFLAGS)
AC_SUBST(QT_LIBS)
AC_SUBST(MOC)
AC_SUBST(UIC)
if test "x$have_qt_pc" = "xyes"; then
  ifelse([$3], , :, [$3])
else
  ifelse([$4], , :, [$4])
fi
])

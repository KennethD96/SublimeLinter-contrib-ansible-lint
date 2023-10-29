@ECHO OFF
SETLOCAL

https://stackoverflow.com/a/5807218/7485823
CALL :lastarg xxx %*
CALL :skiplastarg yyy %*
wsl --shell-type login ansible-lint %yyy% $(wslpath -a "%XXX%")
GOTO :EOF

:: Return all but last arg in variable given in %1
:skiplastarg returnvar args ...
    SETLOCAL
        SET $return=%1
        SET SKIP_LAST_ARG=
        SHIFT
    :skiplastarg_2
        IF NOT "%~2"=="" SET "SKIP_LAST_ARG=%SKIP_LAST_ARG% %1"
        SHIFT
        IF NOT "%~1"=="" GOTO skiplastarg_2
    ENDLOCAL&CALL SET "%$return%=%SKIP_LAST_ARG:~1%"
GOTO :EOF

:: Return last arg in variable given in %1
:lastarg returnvar args ...
    SETLOCAL
      SET $return=%1
      SET LAST_ARG=
  SHIFT
    :LASTARG_2
      SET "LAST_ARG=%1"
      SHIFT
      IF NOT "%~1"=="" GOTO lastarg_2
    ENDLOCAL&call SET %$return%=%LAST_ARG%
GOTO :EOF

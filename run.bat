@ECHO OFF
REM Determine where is RUBY_BIN (where this script is)
PUSHD %~dp0.
SET RUBY_BIN=%CD%/Ruby200/bin
POPD

SET PATH=%RUBY_BIN%;%PATH%
SET RUBY_BIN=

ruby.exe -v
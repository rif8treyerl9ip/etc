#!/bin/bash

# 1GB以上のファイルを再帰的に検索し表示
forfiles -s -p . -c "cmd /c if @fsize gtr 1000000000 echo @FDATE @FSIZE @PATH"

# 100MB以上のファイルを再帰的に検索し表示
forfiles -s -p . -c "cmd /c if @fsize gtr 100000000 echo @FDATE @FSIZE @PATH"
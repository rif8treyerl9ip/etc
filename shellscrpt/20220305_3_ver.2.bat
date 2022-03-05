@REM copymoto: copy元
@REM copysaki: copy先
@REM task_name: yyyymmddの後につけたい文字列

set task_name=_管理
set copymoto=C:\Users\thyt\SELF_S\shellscrpt\test\

@REM copymotoの下にあるディレクトリでyyyymmdd.*のものをリダイレクト、こっちのほうが簡単なので...
dir %copymoto% /b /a:D /O:N | findstr /R "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*" > %copymoto%file1.txt

@REM コピー元から先週までの最新のフォルダへのパスを取得
for /F "tokens=1" %F in (%copymoto%file1.txt) do set Direc_name=%F
del %copymoto%file1.txt

@REM 今日の日付をyyyymmddで取得
set today_=%date:/=%
@REM 今日作成分のディレクトリを用意
mkdir %copymoto%%today_%%task_name%
@REM 今日分へのパスを環境変数に設定
set copysaki=C:\Users\thyt\SELF_S\shellscrpt\test\%today_%%task_name%

xcopy %copymoto%%Direc_name% %copysaki% /-Y /H /S

set task_name=_管理
set copymoto=C:\Users\thyt\SELF_S\shellscrpt\test\

@REM コピー元から先週までの最新のフォルダへのパスを取得
@REM ここで日本語ファイルも入ってきてしまうのでver.2で修正
for /F "tokens=1" %F in ('dir %copymoto% /b /a:D /O:N') do set Direc_name=%F


@REM 今日の日付をyyyymmddで取得
set today_=%date:/=%
@REM 今日作成分のディレクトリを用意
mkdir %copymoto%%today_%%task_name%
@REM 今日分へのパスを環境変数に設定
set copysaki=C:\Users\thyt\SELF_S\shellscrpt\test\%today_%%task_name%
echo %copysaki%

echo %copymoto%%Direc_name%

xcopy %copymoto%%Direc_name% %copysaki% /-Y /H /S

@REM xcopy %copymoto%\%Direc_name% %copysaki% /-Y

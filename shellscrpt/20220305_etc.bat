
rename test21 test212

for /F "tokens=1" %%F in ('dir FromPath /b /o:D /a:-d') do set Direc_name=%%F
for /F "tokens=1" %%F in ('dir . /b ') do echo %%F


set src_test=C:\Users\thyt\SELF_S\shellscrpt
for %i in (*.sh) do echo %i

dir . /b /a:-d

dir . /b /a:D

@REM yyyymmddで前方一致するディレクトリのみ取得
dir . /b /a:D | findstr /R "[0-9]{8}.*"

@REM 繰り返しを表す{}が使用できなかったので冗長
dir . /b /a:D | findstr /R "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*"



@REM copymotoの下にあるディレクトリでyyyymmdd.*のものをリダイレクト
@REM 繰り返しを表す{}が使用できなかったので冗長
dir %copymoto% /b /a:D /O:N | findstr /R "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*" > file1.txt

for /F "tokens=1" %F in (file1.txt) do set Direc_name=%F



set copymoto=C:\Users\thyt\SELF_S\shellscrpt\test\日本語ディレクトリ

cd %copymoto%
%copymoto%20220202

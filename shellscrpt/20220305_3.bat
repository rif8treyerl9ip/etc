set task_name=_�Ǘ�
set copymoto=C:\Users\thyt\SELF_S\shellscrpt\test\

@REM �R�s�[�������T�܂ł̍ŐV�̃t�H���_�ւ̃p�X���擾
@REM �����œ��{��t�@�C���������Ă��Ă��܂��̂�ver.2�ŏC��
for /F "tokens=1" %F in ('dir %copymoto% /b /a:D /O:N') do set Direc_name=%F


@REM �����̓��t��yyyymmdd�Ŏ擾
set today_=%date:/=%
@REM �����쐬���̃f�B���N�g����p��
mkdir %copymoto%%today_%%task_name%
@REM �������ւ̃p�X�����ϐ��ɐݒ�
set copysaki=C:\Users\thyt\SELF_S\shellscrpt\test\%today_%%task_name%
echo %copysaki%

echo %copymoto%%Direc_name%

xcopy %copymoto%%Direc_name% %copysaki% /-Y /H /S

@REM xcopy %copymoto%\%Direc_name% %copysaki% /-Y

@REM copymoto: copy��
@REM copysaki: copy��
@REM task_name: yyyymmdd�̌�ɂ�����������

set task_name=_�Ǘ�
set copymoto=C:\Users\thyt\SELF_S\shellscrpt\test\

@REM copymoto�̉��ɂ���f�B���N�g����yyyymmdd.*�̂��̂����_�C���N�g�A�������̂ق����ȒP�Ȃ̂�...
dir %copymoto% /b /a:D /O:N | findstr /R "^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9].*" > %copymoto%file1.txt

@REM �R�s�[�������T�܂ł̍ŐV�̃t�H���_�ւ̃p�X���擾
for /F "tokens=1" %F in (%copymoto%file1.txt) do set Direc_name=%F
del %copymoto%file1.txt

@REM �����̓��t��yyyymmdd�Ŏ擾
set today_=%date:/=%
@REM �����쐬���̃f�B���N�g����p��
mkdir %copymoto%%today_%%task_name%
@REM �������ւ̃p�X�����ϐ��ɐݒ�
set copysaki=C:\Users\thyt\SELF_S\shellscrpt\test\%today_%%task_name%

xcopy %copymoto%%Direc_name% %copysaki% /-Y /H /S

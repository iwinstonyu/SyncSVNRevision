@echo off

echo ����·��: %cd%
echo �ű�·��: %0
set scriptPath=%~dp0

echo ����ļ�: no_svn_revision.h
if not exist %scriptPath%no_svn_revision.h (goto failnosvnrevision)

echo ����ļ�: svn_revision.h
if not exist svn_revision.h ( 
	echo �ļ������ڣ���non_svn_revision.h����
	copy %scriptPath%no_svn_revision.h svn_revision.h 
)

echo ��ȡSVN�汾��Ϣ
subwcrev.exe ../ %scriptPath%svn_revision_template.h ./svn_revision_new.h
if %errorlevel% NEQ 0 (goto failsvn)

echo �Ƚ��¾ɰ汾��Ϣ�ļ�
fc /n svn_revision_new.h svn_revision.h
::
if %errorlevel% == 1 (
	goto cmpdiff
) else if %errorlevel% NEQ 0 (
	goto failcmp
) else (
	echo �汾�ļ��Ѿ�������
	goto end
)

:failnosvnrevision
echo ʧ��
goto exitonfail

:failsvn
echo ʧ��
goto exitonfail

:failcmp
echo ʧ��
goto exitonfail

:cmpdiff
echo �汾�и��£��������ļ�
copy /Y svn_revision_new.h svn_revision.h
goto end

:exitonfail
echo ɾ����ʱ�ļ�
if exist svn_revision_new.h del svn_revision_new.h
echo ͬ���汾��Ϣʧ��
exit 1

:end
echo ɾ����ʱ�ļ�
if exist svn_revision_new.h del svn_revision_new.h
@echo off

echo 运行路径: %cd%
echo 脚本路径: %0
set scriptPath=%~dp0

echo 检测文件: no_svn_revision.h
if not exist %scriptPath%no_svn_revision.h (goto failnosvnrevision)

echo 检测文件: svn_revision.h
if not exist svn_revision.h ( 
	echo 文件不存在，从non_svn_revision.h复制
	copy %scriptPath%no_svn_revision.h svn_revision.h 
)

echo 获取SVN版本信息
subwcrev.exe ../ %scriptPath%svn_revision_template.h ./svn_revision_new.h
if %errorlevel% NEQ 0 (goto failsvn)

echo 比较新旧版本信息文件
fc /n svn_revision_new.h svn_revision.h
::
if %errorlevel% == 1 (
	goto cmpdiff
) else if %errorlevel% NEQ 0 (
	goto failcmp
) else (
	echo 版本文件已经是最新
	goto end
)

:failnosvnrevision
echo 失败
goto exitonfail

:failsvn
echo 失败
goto exitonfail

:failcmp
echo 失败
goto exitonfail

:cmpdiff
echo 版本有更新，拷贝新文件
copy /Y svn_revision_new.h svn_revision.h
goto end

:exitonfail
echo 删除临时文件
if exist svn_revision_new.h del svn_revision_new.h
echo 同步版本信息失败
exit 1

:end
echo 删除临时文件
if exist svn_revision_new.h del svn_revision_new.h
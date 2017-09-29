// SyncSVNRevision.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <iostream>
// 这个头文件是运行脚本从Subversion获取到的版本信息
#include "svn_revision.h"
using namespace std;


int main()
{
#ifdef SVN_REVISION_WCREV
	cout << SVN_REVISION_WCREV << endl;
#endif

#ifdef SVN_REVISION_WCDATE
	cout << SVN_REVISION_WCDATE << endl;
#endif

#ifdef SVN_REVISION_WCMODS
	cout << SVN_REVISION_WCMODS << endl;
#endif

	system("pause");

    return 0;
}


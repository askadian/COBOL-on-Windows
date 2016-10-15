IF EXIST  %1.exe (DEL  %1.exe)
IF EXIST  %1.dll (DEL  %1.dll)
IF EXIST  %1.i (DEL  %1.i)
IF EXIST  %1.h (DEL  %1.h)

%comspec% /k ""C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"" amd64

cobc -std=ibm -x %1.exe %1.cbl
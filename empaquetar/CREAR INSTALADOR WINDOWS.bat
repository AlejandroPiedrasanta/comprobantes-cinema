@echo off
rem Crea en GENERADOR\INSTALADOR:
rem   - Comprobantes Cinema Portable.exe   (un solo archivo, se abre sin instalar)
rem   - Instalar Comprobantes Cinema (Windows) X.exe
rem Requisitos: Python con PySide6, Pillow y PyInstaller; Inno Setup 6.
cd /d "%~dp0"
set "SALIDA=..\..\INSTALADOR"

echo [1/3] Creando la version portable (un solo .exe)...
python -m PyInstaller --noconfirm --clean --distpath "%SALIDA%" --workpath build-portable portable.spec || goto error

echo [2/3] Empaquetando el programa para el instalador...
python -m PyInstaller --noconfirm --clean --distpath dist --workpath build comprobantes.spec || goto error

set "ISCC=%LOCALAPPDATA%\Programs\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=%ProgramFiles(x86)%\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" set "ISCC=%ProgramFiles%\Inno Setup 6\ISCC.exe"
if not exist "%ISCC%" (echo No se encontro Inno Setup 6. & goto error)

echo [3/3] Creando el instalador con Inno Setup...
"%ISCC%" /Q instalador_windows.iss || goto error

rem Borra los archivos temporales de la compilacion
rd /s /q build build-portable dist dist-portable 2>nul
if exist "%SALIDA%\Comprobantes Cinema" rd /s /q "%SALIDA%\Comprobantes Cinema"
echo.
echo Listo: en GENERADOR\INSTALADOR estan la version portable y el instalador.
pause
exit /b 0

:error
echo.
echo *** Hubo un error. Revisa los mensajes de arriba. ***
pause
exit /b 1

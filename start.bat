::Désactive l'affichage des commandes dans la console pour une exécution plus propre.
@echo off

:: Vérifie si le script est déjà en mode administrateur
net session>nul 2>&1
if %errorLevel% == 0 (
    goto :admin
) else (
    goto :getAdmin
)

:getAdmin
    
    :: Demande les droits administratifs
    
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    
    echo UAC.ShellExecute "cmd.exe", "/c %~s0", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    
    del "%temp%\getadmin.vbs"
    
    exit /B


:admin
    
    :: Exécute le script Python
    python run_as_admin.py

    :: Redémarre l'ordinateur
    shutdown /r /t 0

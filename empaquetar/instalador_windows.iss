; Instalador de Windows (Inno Setup 6). Se compila con "CREAR INSTALADOR WINDOWS.bat".
#define AppName "Comprobantes Cinema Productions"
#define AppVersion "2.1.0"
#define AppExe "Comprobantes Cinema.exe"

[Setup]
AppId={{4F5098BC-D578-40A3-8BDB-5CCAD9D12264}
AppName={#AppName}
AppVersion={#AppVersion}
AppVerName={#AppName} {#AppVersion}
AppPublisher=Cinema Productions
DefaultDirName={autopf}\{#AppName}
DefaultGroupName={#AppName}
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
OutputDir=..\..\INSTALADOR
OutputBaseFilename=Instalar Comprobantes Cinema (Windows) {#AppVersion}
SetupIconFile=..\recursos\icono.ico
UninstallDisplayIcon={app}\{#AppExe}
UninstallDisplayName={#AppName}
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

[Languages]
Name: "es"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Files]
Source: "dist\Comprobantes Cinema\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; Fuentes del diseño (solo para el usuario; no se quitan al desinstalar porque otros programas pueden usarlas)
Source: "..\recursos\fuentes\LEMONMILK-Bold.otf"; DestDir: "{autofonts}"; FontInstall: "LEMON MILK Bold (OpenType)"; Flags: onlyifdoesntexist uninsneveruninstall fontisnttruetype
Source: "..\recursos\fuentes\GetVoIP Grotesque.otf"; DestDir: "{autofonts}"; FontInstall: "GetVoIP Grotesque (OpenType)"; Flags: onlyifdoesntexist uninsneveruninstall fontisnttruetype
Source: "..\recursos\fuentes\MYRIADPRO-BOLD.OTF"; DestDir: "{autofonts}"; FontInstall: "Myriad Pro Bold (OpenType)"; Flags: onlyifdoesntexist uninsneveruninstall fontisnttruetype
Source: "..\recursos\fuentes\MYRIADPRO-REGULAR.OTF"; DestDir: "{autofonts}"; FontInstall: "Myriad Pro Regular (OpenType)"; Flags: onlyifdoesntexist uninsneveruninstall fontisnttruetype

[Icons]
Name: "{autoprograms}\{#AppName}"; Filename: "{app}\{#AppExe}"
Name: "{autodesktop}\{#AppName}"; Filename: "{app}\{#AppExe}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#AppExe}"; Description: "{cm:LaunchProgram,{#AppName}}"; Flags: nowait postinstall skipifsilent

[Code]
function PhotoCraftInstalado(): Boolean;
begin
  Result := FileExists(ExpandConstant('{commonpf64}\ArtCraft\PhotoCraft\photocraft-cli.exe')) or
            FileExists(ExpandConstant('{commonpf32}\ArtCraft\PhotoCraft\photocraft-cli.exe')) or
            FileExists(ExpandConstant('{localappdata}\Programs\ArtCraft\PhotoCraft\photocraft-cli.exe'));
end;

function InitializeSetup(): Boolean;
begin
  Result := True;
  if not PhotoCraftInstalado() then
    MsgBox('Aviso: no se encontró PhotoCraft en esta computadora.' + #13#10 + #13#10 +
           'El programa lo necesita para crear los comprobantes. Puedes instalar PhotoCraft después ' +
           'o indicar dónde está con el botón «PhotoCraft…» del programa.', mbInformation, MB_OK);
end;

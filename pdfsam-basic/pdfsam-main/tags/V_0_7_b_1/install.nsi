; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "pdfsam"
!define PRODUCT_VERSION "0.7b1"
!define PRODUCT_PUBLISHER "Andrea Vacondio"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"
!define PRODUCT_STARTMENU_REGVAL "NSIS:StartMenuDir"
!define TARGET_FILE "config.xml"
!define PRODUCT_DATE "23/06/2007"
!define LANGUAGE_TITLE "pdfsam language selection"
SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"

  
; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "G:\install.ico"
!define MUI_UNICON "G:\uninstall.ico"
!define MUI_LANGDLL_WINDOWTITLE "${LANGUAGE_TITLE}"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "doc\License.txt"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Start menu page
var ICONS_GROUP
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "PDF Split And Merge"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "${PRODUCT_UNINST_ROOT_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${PRODUCT_UNINST_KEY}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "${PRODUCT_STARTMENU_REGVAL}"
!insertmacro MUI_PAGE_STARTMENU Application $ICONS_GROUP
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
  !insertmacro MUI_LANGUAGE "English" # first language is the default language
  !insertmacro MUI_LANGUAGE "Italian"
  !insertmacro MUI_LANGUAGE "Russian"
  !insertmacro MUI_LANGUAGE "Swedish"
  !insertmacro MUI_LANGUAGE "Spanish"
  !insertmacro MUI_LANGUAGE "Portuguese"
  !insertmacro MUI_LANGUAGE "Dutch"
  !insertmacro MUI_LANGUAGE "French"
  !insertmacro MUI_LANGUAGE "Greek"
  !insertmacro MUI_LANGUAGE "Turkish"
  
; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "pdfsam-win32inst-v0_7_b1.exe"
InstallDir "$PROGRAMFILES\pdfsam"
ShowInstDetails show
ShowUnInstDetails show

!macro ReplaceBetweenXMLTab This AndThis With In
Push "${This}"
Push "${AndThis}"
Push "${With}"
Push "${In}"
 Call ReplaceBetween
!macroend

;display language selection dialog
Function .onInit

  !insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

Function WarnDirExists    
    IfFileExists $INSTDIR\*.* DirExists DirExistsOK
    DirExists:
    MessageBox MB_YESNO|MB_ICONQUESTION|MB_DEFBUTTON2 \
        "Installation directory already exists. Would you like to upgrate pdfsam?" \
        IDYES DirExistsOK
    Abort
    DirExistsOK:
    
  Delete "$INSTDIR\lib\itext-*.jar"
  Delete "$INSTDIR\lib\bcmail-jdk14-*.jar"
  Delete "$INSTDIR\lib\bcprov-jdk14-*.jar"
  Delete "$INSTDIR\lib\dom4j-*.jar"
  Delete "$INSTDIR\lib\jaxen-*.jar"
  Delete "$INSTDIR\lib\looks-*.jar"
  Delete "$INSTDIR\pdfsam-*.jar"
  Delete "$INSTDIR\pdfsam-starter.exe"
  Delete "$INSTDIR\lib\pdfsam-console-*.jar"
  Delete "$INSTDIR\lib\pdfsam-langpack.jar"
  Delete "$INSTDIR\doc\pdfsam-*-tutorial.pdf"
  Delete "$INSTDIR\plugins\merge\pdfsam-merge-*.jar"
  Delete "$INSTDIR\plugins\split\pdfsam-split-*.jar"
  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\pdfsam.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\readme.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\tutorial.lnk"
  Delete "$STARTMENU.lnk"  
FunctionEnd

Function ReplaceBetween
 Exch $R0 ; file
 Exch
 Exch $R1 ; replace with
 Exch 2
 Exch $R2 ; before this (marker 2)
 Exch 2
 Exch 3
 Exch $R3 ; after this  (marker 1)
 Exch 3
 Push $R4 ; marker 1 len
 Push $R5 ; marker pos
 Push $R6 ; file handle
 Push $R7 ; temp file handle
 Push $R8 ; temp file name
 Push $R9 ; current line string
 Push $0 ; current chop
 Push $1 ; marker 1 + text
 Push $2 ; marker 2 + text
 Push $3 ; marker 2 len

 GetTempFileName $R8
 FileOpen $R7 $R8 w
 FileOpen $R6 $R0 r

 StrLen $3 $R3
 StrLen $R4 $R2

 Read1:
  ClearErrors
  FileRead $R6 $R9
  IfErrors Done
  StrCpy $R5 -1

 FindMarker1:
  IntOp $R5 $R5 + 1
  StrCpy $0 $R9 $3 $R5
  StrCmp $0 "" Write
  StrCmp $0 $R3 0 FindMarker1
   IntOp $R5 $R5 + $3
   StrCpy $1 $R9 $R5

  StrCpy $R9 $R9 "" $R5
  StrCpy $R5 0
  Goto FindMarker2

 Read2:
  ClearErrors
  FileRead $R6 $R9
  IfErrors Done
  StrCpy $R5 0

 FindMarker2:
  IntOp $R5 $R5 - 1
  StrCpy $0 $R9 $R4 $R5
  StrCmp $0 "" Read2
  StrCmp $0 $R2 0 FindMarker2
   StrCpy $2 $R9 "" $R5

   FileWrite $R7 $1$R1$2
   Goto Read1

 Write:
  FileWrite $R7 $R9
  Goto Read1

 Done:
  FileClose $R6
  FileClose $R7

  SetDetailsPrint none
  Delete $R0
  Rename $R8 $R0
  SetDetailsPrint both

 Pop $3
 Pop $2
 Pop $1
 Pop $0
 Pop $R9
 Pop $R8
 Pop $R7
 Pop $R6
 Pop $R5
 Pop $R4
 Pop $R3
 Pop $R2
 Pop $R1
 Pop $R0
FunctionEnd


Section "Principale" SEC01
;DetailPrint $LANGUAGE
;DetailPrint ${LANG_ENGLISH}
  Call WarnDirExists
  SetOutPath "$INSTDIR\plugins\merge"
  SetOutPath "$INSTDIR\plugins\split"
  SetOutPath "$INSTDIR\lib"
  SetOutPath "$INSTDIR\doc"
  IfFileExists $INSTDIR\config.xml endFileExist
    SetOutPath "$INSTDIR"
    SetOverwrite try
    File "config.xml"
endFileExist:


;sostituisce la stringa tra i due tag
  !insertmacro ReplaceBetweenXMLTab "<version>" "</version>" "${PRODUCT_VERSION}" "$INSTDIR\config.xml"
  !insertmacro ReplaceBetweenXMLTab "<build_date>" "</build_date>" "${PRODUCT_DATE}" "$INSTDIR\config.xml"
  !insertmacro ReplaceBetweenXMLTab "<lookAndfeel" "</lookAndfeel>" "><LAF>5</LAF><theme>11</theme>" "$INSTDIR\config.xml"
;get language
    StrCmp $LANGUAGE 1033 +1 noenglish
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "en_GB" "$INSTDIR\config.xml"
    GOTO languagedone
    noenglish:
    StrCmp $LANGUAGE 1034 +1 nospanish
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "es_ES" "$INSTDIR\config.xml"
    GOTO languagedone
    nospanish:
    StrCmp $LANGUAGE 1036 +1 nofrench
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "fr_FR" "$INSTDIR\config.xml"
    GOTO languagedone
    nofrench:
    StrCmp $LANGUAGE 1049 +1 norussian
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "ru_RU" "$INSTDIR\config.xml"
    GOTO languagedone
    norussian:
    StrCmp $LANGUAGE 2070 +1 noportuguese
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "pt_BR" "$INSTDIR\config.xml"
    GOTO languagedone
    noportuguese:
    StrCmp $LANGUAGE 1040 +1 noitalian
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "it_IT" "$INSTDIR\config.xml"
    GOTO languagedone
    noitalian:
    StrCmp $LANGUAGE 1031 +1 nogerman
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "de_DE" "$INSTDIR\config.xml"
    GOTO languagedone
    nogerman:
    StrCmp $LANGUAGE 1053 +1 noswedish
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "sv_SE" "$INSTDIR\config.xml"
    GOTO languagedone
    noswedish:
    StrCmp $LANGUAGE 1043 +1 nodutch
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "de_DE" "$INSTDIR\config.xml"
    GOTO languagedone
    nodutch:
    StrCmp $LANGUAGE 1032 +1 nogreek
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "el_EL" "$INSTDIR\config.xml"
    GOTO languagedone
    nogreek:
    StrCmp $LANGUAGE 1055 +1 noturkish
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "tr_TR" "$INSTDIR\config.xml"
    GOTO languagedone
     noturkish:
      !insertmacro ReplaceBetweenXMLTab "<i18n>" "</i18n>" "en_GB" "$INSTDIR\config.xml"
    QUIT
    languagedone:


  SetOverwrite on
  SetOutPath "$INSTDIR\lib"
  File "lib\pdfsam-console-0.7.0.jar"
  File "lib\jcmdline-1.0.3.jar"
  File "lib\looks-2.1.1.jar"
  File "lib\itext-2.0.2.jar"
  File "lib\dom4j-1.6.1.jar"
  File "lib\jaxen-1.1.jar"
  File "lib\bcmail-jdk14-135.jar"
  File "lib\bcprov-jdk14-135.jar"
  File "lib\pdfsam-langpack.jar"  
  SetOverwrite ifnewer
  SetOutPath "$INSTDIR"
  File "pdfsam-0.7b1.jar"
  File "pdfsam-starter.exe"
  SetOutPath "$INSTDIR\doc"
  File "doc\readme.txt"
  File "doc\changelog.txt"
  File "doc\License.txt"
  File "doc\pdfsam-0.7b1-tutorial.pdf"
  SetOutPath "$INSTDIR\plugins\merge"
  File "plugins\merge\pdfsam-merge-0.4.9.jar"
  File "plugins\merge\config.xml"
  SetOutPath "$INSTDIR\plugins\split"
  File "plugins\split\pdfsam-split-0.3.0.jar"
  File "plugins\split\config.xml"
  SetOutPath "$SMPROGRAMS\$ICONS_GROUP"
SectionEnd

Section -AdditionalIcons
  SetOutPath $INSTDIR
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
  CreateDirectory "$SMPROGRAMS\$ICONS_GROUP"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\pdfsam.lnk" "$INSTDIR\pdfsam-starter.exe"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Readme.lnk" "$INSTDIR\doc\readme.txt"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Tutorial.lnk" "$INSTDIR\doc\pdfsam-0.7b1-tutorial.pdf"
  CreateShortCut "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk" "$INSTDIR\uninst.exe"
  !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) completely removed."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name)?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  !insertmacro MUI_STARTMENU_GETFOLDER "Application" $ICONS_GROUP
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\plugins\split\config.xml"
  Delete "$INSTDIR\plugins\split\pdfsam-split-0.3.0.jar"
  Delete "$INSTDIR\plugins\merge\config.xml"
  Delete "$INSTDIR\plugins\merge\pdfsam-merge-0.4.9.jar"
  Delete "$INSTDIR\pdfsam-0.7b1.jar"
  Delete "$INSTDIR\pdfsam-starter.exe"
  Delete "$INSTDIR\doc\readme.txt"
  Delete "$INSTDIR\doc\changelog.txt"
  Delete "$INSTDIR\doc\License.txt"
  Delete "$INSTDIR\doc\pdfsam-0.7b1-tutorial.pdf"  
  Delete "$INSTDIR\lib\pdfsam-console-0.7.0.jar"
  Delete "$INSTDIR\lib\jcmdline-1.0.3.jar"
  Delete "$INSTDIR\lib\looks-2.1.1.jar"
  Delete "$INSTDIR\lib\itext-2.0.2.jar"
  Delete "$INSTDIR\lib\dom4j-1.6.1.jar"
  Delete "$INSTDIR\lib\jaxen-1.1.jar"
  Delete "$INSTDIR\lib\bcmail-jdk14-135.jar"
  Delete "$INSTDIR\lib\bcprov-jdk14-135.jar"
  Delete "$INSTDIR\lib\pdfsam-langpack.jar"
  Delete "$INSTDIR\config.xml"

  Delete "$SMPROGRAMS\$ICONS_GROUP\Uninstall.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\pdfsam.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\readme.lnk"
  Delete "$SMPROGRAMS\$ICONS_GROUP\tutorial.lnk"
  Delete "$STARTMENU.lnk"

  RMDir "$SMPROGRAMS\$ICONS_GROUP"
  RMDir "$INSTDIR\lib"
  RMDir "$INSTDIR\plugins\split"
  RMDir "$INSTDIR\plugins\merge"
  RMDir "$INSTDIR\plugins"
  RMDir "$INSTDIR\doc"
  RMDir "$INSTDIR"
  RMDir ""

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd
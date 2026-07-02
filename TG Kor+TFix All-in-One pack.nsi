
!define PRODUCT_NAME "TFix+한글패치 올인원팩"
!define PRODUCT_VERSION "v1.05"
!define PRODUCT_PUBLISHER "제로방송 (coolgarlic@gmail.com)"
!define PRODUCT_WEB_SITE "http://cafe.naver.com/thiefgame"
BrandingText "cafe.naver.com/thiefgame"
RequestExecutionLevel admin

SetCompressor /final zlib

!include "MUI2.nsh"

; Define pages
!define MUI_WELCOMEPAGE_TITLE "${PRODUCT_NAME} ${PRODUCT_VERSION} 설치 마법사"
!define MUI_WELCOMEPAGE_TEXT "${PRODUCT_NAME} 설치 마법사에 오신 것을 환영합니다.$\r$\n$\r$\nThief Gold에 TFix와 한글 패치 및 각종 편의성 개선 모드를 한 번에 설치할 수 있는 올인원팩입니다. $\r$\n$\r$\n이 한글패치는 한국 씨프 커뮤니티에서 배포되며, 출처를 표기하는 한 재배포를 허락합니다. (cafe.naver.com/thiefgame)"
!define MUI_WELCOMEFINISHPAGE_BITMAP "164x314.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH
!define MUI_ICON "Thief1.ico"
!define MUI_DIRECTORYPAGE_TEXT_TOP "${PRODUCT_NAME} ${PRODUCT_VERSION}를 설치합니다.$\r$\n$\r$\n$\r$\nThief Gold가 설치된 디렉토리를 선택해주세요.$\r$\n(기본 경로는 Steam판 기본 라이브러리 폴더로 설정되어 있습니다)"
; Welcome page
!insertmacro MUI_PAGE_WELCOME
; Components page
!insertmacro MUI_PAGE_COMPONENTS
; Directory page
!define MUI_PAGE_CUSTOMFUNCTION_LEAVE DirLeave
!insertmacro MUI_PAGE_DIRECTORY

;Thief 설치 경로 맞는지 체크
Function DirLeave
  IfFileExists "$INSTDIR\THIEF.EXE" 0 invalid
  Return

invalid:
  MessageBox MB_OK|MB_ICONEXCLAMATION "설정하신 경로에서 Thief Gold 게임이 발견되지 않았습니다. 경로를 다시 설정해주세요."
  Abort
FunctionEnd

; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\한글패치 안내.txt"
!insertmacro MUI_PAGE_FINISH

; Language files
!insertmacro MUI_LANGUAGE "Korean"

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "TG_Korean_Patch_${PRODUCT_VERSION}+TFix_All-in-One Pack.exe"

InstallDir "$PROGRAMFILES\Steam\steamapps\common\thief_gold\"
ShowInstDetails show

Section "!TFix v1.27d" SEC01
  ; Extract Installer 1 to a temp folder and run it silently
  InitPluginsDir
  SetOutPath $PLUGINSDIR
  ; Run Installer 2 silently
  File "TFix_1.27d.exe"
  DetailPrint "*TFix v1.27d를 설치합니다..."
  ExecWait '"$PLUGINSDIR\TFix_1.27d.exe" /S /D=$INSTDIR'
SectionEnd

Section "!한글패치 ${PRODUCT_VERSION}" SEC02
      ; 1. 백업 폴더 생성 (이미 존재하면 건너뜀)
    CreateDirectory "$INSTDIR\backup"
    ; 2. 기존 데이터 백업 (예: 설치 폴더 내의 .dat 파일을 백업 폴더로 복사)
    CopyFiles "$INSTDIR\install.cfg" "$INSTDIR\Backup"
    CopyFiles "$INSTDIR\cam_mod.ini" "$INSTDIR\Backup"
    DetailPrint "*install.cfg, cam_mod.ini파일을 백업합니다..."

      ; 3. 한글패치 설치
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File /r "씨프 골드 한글패치 v1.05\*.*"
  DetailPrint "*Thief Gold 한글패치 ${PRODUCT_VERSION}를 설치합니다..."

      ; 4. install.cfg 를 게임에서 덮어쓰지 못하도록 읽기 전용 속성 부여
  SetFileAttributes "$INSTDIR\install.cfg" READONLY
SectionEnd

Section "커스텀 키설정 적용" SEC03
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "user.bnd"
SectionEnd

Section "OpenAL" SEC04
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "OpenAL\*.*"
  DetailPrint "*OpenAL을 설치합니다..."
SectionEnd

Section "SFX Enhancement Pack 1.6" SEC05
  SetOutPath "$INSTDIR\MODS"
  SetOverwrite on
  File /r "T1NewSFX\*.*"
  DetailPrint "*SFX Enhancement Pack 1.6을 설치합니다..."
SectionEnd

Section "TFix Anti-aliasing 활성화" SEC06
  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "AA cfg\cam_ext.cfg"
SectionEnd

Section /o "그래픽향상팩 EP2 (Alpha) 다운로드 및 추가설치" SEC07
  AddSize 879724 ; 859MB (879724 KB) 추가 표시
  DetailPrint "*Thief Enhancement Pack 2.0 (Alpha 241003)를 설치합니다..."
    inetc::get /TRANSLATE "Thief Enhancement Pack 2.0 (Alpha 241003) 다운로드중... %s" "접속중 ..." "초" "분" "시간" "" "%dkB (%d%%) / %dkB @ %d.%01dkB/s" "(%d %s%s 남음)" "https://github.com/NamelessVoice/Thief-Enhancement-Pack/releases/download/2024-10-03/ep2.zip" "$INSTDIR\MODS\ep2.zip" /END
    ; 다운로드 성공 여부 확인; 성공시 줄 3개 건너띔
    Pop $0
    StrCmp $0 "OK" +3
        MessageBox MB_OK "EP2 다운로드 실패: $2"
        Quit
    ;MessageBox MB_OK "EP2 다운로드 성공!"

  ; 압축 해제 실행 및 진행 메시지 표시 ; 성공시 줄 3개 건너띔
SetOutPath "$INSTDIR\MODS\EP"
nsisunz::UnzipToLog "$INSTDIR\MODS\ep2.zip" "$INSTDIR\MODS\EP"
Pop $1
StrCmp $1 "success" +3
    MessageBox MB_OK "EP2 압축 해제 실패: $3"
    Quit
    ; 압축 해제 후 원본 파일 삭제
Delete "$INSTDIR\MODS\ep2.zip"

  SetOutPath "$INSTDIR"
  SetOverwrite on
  File "EP1+2 cfg\cam_mod.ini"
SectionEnd


; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC01} "비공식 통합 패치로, Windows 호환성, 버그 수정, 와이드스크린 지원, 그래픽 향상 및 안정성 개선을 제공합니다.$\r$\n$\r$\n*한글패치를 적용하기 위해 필요합니다."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC02} "Thief Gold 게임 내 텍스트 및 간판, 지도, 브리핑, 동영상 등 한글화 패치입니다. (${PRODUCT_VERSION}) $\r$\n$\r$\n*install.cfg, cam_mod.ini 파일을 자동 백업합니다.(\backup)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC03} "커스텀 키설정 프로필을 미리 적용합니다.(Zero-bangsong Bindings) $\r$\n*WSAD 이동키, Q/E 옆으로 기울이기, F 앞으로 기울이기, G 나침반, X 앉기, Z 앞으로 걷기, Shift 스피드 토글, V 막기, 휠버튼 아이템 치우기"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC04} "Thief Gold의 3D 사운드 및 환경 음향 효과, EAX를 지원하는 OpenAL 런타임을 설치하고, 인게임 설정에서 사전 활성화합니다."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC05} "게임 내 효과음을 고음질로 개선하는 모드입니다.$\r$\n$\r$\n노이즈 감소, 음질 보정 및 일부 효과음 교체를 통해 더욱 선명하고 현실적인 음향을 제공합니다.$\r$\n(by Child Of Karras/TTLG Forum)"
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC06} "TFix 설치중 나타나는 'Disable anti-aliasing?'$\r$\n(예: AA Off/아니오: On) 팝업 대화상자의 선택과 상관없이, 안티앨리어싱, 소프트웨어 감마를 활성화합니다. 계단 현상을 줄여 보다 부드러운 그래픽을 제공하고 캡쳐 시 밝기 버그를 해결합니다."
  !insertmacro MUI_DESCRIPTION_TEXT ${SEC07} "Thief Enhancement Pack 2.0 (Alpha 241003) 다운로드 후 TFix에 포함된 EP1 기반으로 추가 적용합니다.$\r$\n 원작 분위기를 유지한 고해상도 텍스처를 제공하지만, 알파 버전으로 일부 품질 편차가 있을 수 있습니다."
!insertmacro MUI_FUNCTION_DESCRIPTION_END

Section -Post
SectionEnd

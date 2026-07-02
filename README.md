# TG_Korean_Patch-TFix_All-in-One-Pack
Thief Gold 한글패치 + 올인원팩 인스톨러 NSIS 스크립트<br>
TFix 설치파일이 해당 파일들과 같은 디렉토리에 있어야하며, 한글패치는 최신본 압축해제한 상태로 같이 넣어서 패킹<br>
SFX모드도 미리 생성해둔 디렉토리 경로에 넣어서 패킹<br>
<br>
===========================<br>
 Thief : Gold 한글 패치 v1.04<br>
===========================<br>
<br>
한글패치 제작 : 한국 씨프 카페<br>
cafe.naver.com/thiefgame<br>
<br>
한글화 총괄 : 제로방송 (coolgarlic@gmail.com)<br>
번역 및 지원 : include, Sassy, Ospaggi<br>
<br>
<br>
2026년 6월 2일 v1.0 : 한글패치 공개<br>
2026년 6월 6일 v1.01 : 일부 번역 교정 및 조이스틱 설정 번역 누락 수정<br>
2026년 6월 8일 v1.02 : 표지판 한글 미표기 버그 수정<br>
2026년 6월 10일 v1.03a : 영상자막 전면 개선<br>
2026년 6월 13일 v1.03b : 매우 사소한 대사출력 버그 수정<br>
2026년 6월 17일 v1.04 : 팩션별 언어 전면 개선, 씨프2 한글화 대응 인물명 음차 오기 수정<br>
<br>
===============<br>
설치방법<br>
===============<br>
*올인원팩은 경로 설정만 해주면 아래 일체 과정을 알아서 진행합니다. <br>
<br>
1. 씨프 골드에 TFix 패치를 한다.(1.27 버전 이상 설치 권장)<br>
   - TFix 패치 주소 : https://cafe.naver.com/thiefgame/292<br>
     * 씨프 골드 설치 경로<br>
       ㆍ스팀판  : C:\Program Files (x86)\Steam\steamapps\common\thief_gold<br>
       ㆍGOG판 : C:\Program Files (x86)\GOG Galaxy\Games\Thief Gold<br>
<br>
   TFix 설치 후 씨프 골드를 한번 실행했다가 종료하고,<br>
<br>
2. KRPatch 폴더 및 install.cfg, cam_mod.ini를 씨프 골드 설치 경로에 넣는다.<br>
   * install.cfg, cam_mod.ini는 덮어씌워질 것이기 때문에,<br>
     원본 파일 백업 권장<br>
<br>
3. 씨프 골드를 플레이한다.<br>
<br>
<br>
+) 씨프 골드의 기본 조작키가 매우 구세대적이므로<br>
    제가 개인적으로 쓰는 키 설정을 SAVES 폴더로 동봉했습니다.<br>
    SAVES 폴더를 씨프 골드 설치 경로에 덮으시면 됩니다.<br>
<br>
    게임 내에서 "설정" - "조작 설정..." - "불러오기"<br>
    "Zero-bangsong Bindings"를 불러오시면 됩니다.<br>
<br>
    WSAD 기본 이동키, Q/E 옆으로 기울이기, F 앞으로 기울이기, G 나침반<br>
    X 앉기, Z 앞으로 걷기, Shift 스피드 토글, V 막기, 휠버튼 아이템 치우기<br>
<br>
    * 소리나는 타일 등 걸어다니실때 Shift + Z 키로 움직이시면 편리합니다.<br>
      앞으로 걷기 키를 일정 간격으로 반복하시는게(발소리 내기 전까지만 이동 반복)<br>
      제일 베스트 방법이긴 합니다.<br>
<br>
<br>
===============<br>
문제 발생 시 확인사항<br>
===============<br>
<br>
Q1. 한글이 안 나와요!<br>
     A1. install.cfg 내 language korean+english 가 기입되어 있는지 확인하세요.<br>
          cam_mod.ini 내 uber_mod_path OSM+KRPatch 가 기입되어 있는지 확인하세요.<br>
<br>
Q2. 영상에서 한글 자막이 안 보여요!<br>
     A2. install.cfg에 movie_path .\KRPatch\movies 가 기입되어 있는지 확인하세요.<br>
<br>
Q3. 인게임 인터페이스가 너무 커요!<br>
     A3. install.cfg 내 d3d_disp_scaled_2d_overlay 64를 삭제하세요.<br>
          (게임 해상도 설정에 따라 자막이 콩알만하게 보일 수 있습니다.)<br>
<br>
Q4. 옵션에서 조작키 설정 중에 깨진 글자가 화면을 덮어요!<br>
     A4. 한글폰트가 부족해서 발생하는 문제이며, 현재로서는 엔진 한계상 해결 방법이 없습니다..<br>
          키 설정하시는 데 크게 지장은 없으실 것이기 때문에 그대로 하시면 됩니다.<br>
<br>
<br>
===============<br>
참고사항<br>
===============<br>
ㅇ  현재 경비병의 반응 대사 등은 의도적으로 자막 숨김되어있습니다.<br>
     (중요한 대사를 가리게 되거나, 긴장감 감소 등)<br>
<br>
   - 경비병들이 뭐라고 하는지 궁금하신 분들은 KRPatch 폴더 내 USER.CFG를 메모장으로 여시고<br>
      subtitles_hide_types fx+bark+urgent  에서 bark랑 urgent를 삭제하시면 됩니다.<br>
      * 일부 미션에서는 극도로 정신사납게 만들기 때문에...<br>
        한번 클리어 하시고 하시기를 권장드립니다.<br>

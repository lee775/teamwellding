# Wellding (웰딩)

> 한 번의 접속으로 전국의 웨딩홀을 살펴보고, 스튜디오·드레스·메이크업(스드메)까지 한 번에 예약·결제할 수 있는 웨딩 플랫폼

| 항목 | 내용 |
| --- | --- |
| 개발 기간 | 2021.12.29 ~ 2022.02.10 (커밋 기록: 2022.01.07 ~ 2022.02.10) |
| 인원 | 6명 (팀 프로젝트) |
| 형태 | Spring MVC + JSP 기반 웹 애플리케이션 (사용자 페이지 + 관리자 페이지) |
| 최종 코드 | **`third` 브랜치** (기본 브랜치 `develop`은 2022.01.13 시점에서 멈춰 있음) |

<br>

## 소개

- 결혼 준비 과정에서 정보가 공급자 쪽에 치우쳐 있어 정작 결혼하는 사람이 주도적으로 선택하기 어렵다는 문제에서 출발
- 결혼 관련 상품을 소비하는 사람을 위한 웨딩 플랫폼으로 기획
- 웨딩홀과 스튜디오·드레스·메이크업 업체를 한 곳에서 비교하고, 한 건의 예약으로 묶어 장바구니 → 카카오페이 결제까지 진행
- 결제 후에는 이용후기(별점), 하객 식권용 QR 코드, 쿠폰·포인트 등 부가 기능 제공

<br>

## 주요 기능

### 사용자

**회원**
- 회원가입: 아이디 중복 확인, 이메일 인증번호 확인, 가입 시 포인트 30,000 지급
- 로그인/로그아웃: 쿠키 기반 인증, `AuthInterceptor`로 로그인이 필요한 URL 접근 제어
- 아이디 찾기, 비밀번호 찾기(임시 비밀번호 메일 발송)
- 회원정보·결혼 예정일 수정, 회원탈퇴

**웨딩홀 · 스드메**
- 웨딩홀 목록: 업체명/홀 이름 검색, **결혼일자를 고르면 그날 이미 결제된 홀을 목록에서 제외**
- 홀 상세: 대관료, 식대, 최소/최대 인원, 할인율, 이미지
- 스튜디오 · 드레스 · 메이크업 목록/상세, 장바구니 담기
- 메인 페이지: 예약 수 기준 인기 웨딩홀(`Wellding's Best`), 이벤트, 후기

**장바구니 · 결제**
- 한 건의 예약(`WD_REZ`)에 홀·스튜디오·드레스·메이크업을 담고 총액 자동 계산
  - `홀 대관료 + 식대 × 최소 인원 + 스튜디오 + 드레스 + 메이크업 + 추가 인원 × 추가 요금`
- 쿠폰 · 포인트 적용 후 카카오페이 결제 (테스트 가맹점 코드 사용)
- 결제 내역 / 상세 조회, 결제 취소 요청 및 취소 내역 조회
- 예약 상태 흐름: `N`(장바구니) → `Y`(결제 완료) → `C`(취소 요청) → `D`(취소 승인)

**QR 식권**
- 결제 내역에서 신랑측 / 신부측 QR 코드 생성 (QRCode.js)
- QR을 스캔하면 측별 식권 사용 수가 올라가도록 집계 (`WD_QR`)

**커뮤니티**
- 공지사항, 이벤트 게시판(쿠폰 다운로드)
- 자유게시판: 글 작성/수정/삭제, 첨부파일, 댓글 작성·수정·삭제·신고, 목록 제목 옆 댓글 수 표시
- 이용후기: 별점, 사진 첨부, 홀 이름 검색
  - 결제를 마치고 결혼일이 지난 예약에 대해서만 작성할 수 있고, 한 예약당 한 번만 작성
- 웨딩플래너: 플래너 목록/상세, 견적 요청 메일 발송(JavaMail)
- 채널톡(Channel.io) 상담 위젯, 이용약관 · 개인정보처리방침

### 관리자

- 관리자 로그인 (로그인 화면에서 회원 / 관리자 탭 선택)
- 회원 관리: 목록 · 검색 · 페이징, 회원 정보 및 포인트 수정
- 업체 · 상품 관리: 웨딩홀 업체 / 홀, 스튜디오, 드레스 업체 / 드레스, 메이크업 등록 · 수정 · 삭제, 이미지 첨부, 할인율 입력 검증
- 게시판 관리: 공지사항 · 이벤트 작성/수정/삭제, 자유게시판 · 후기 게시글 관리, 신고된 댓글 처리
- 결제 관리: 결제 내역 조회(예약번호 검색), 취소 요청 승인 시 결제 금액을 회원 포인트로 환급

<br>

## 기술 스택

| 구분 | 사용 기술 |
| --- | --- |
| Backend | Java 8, Spring MVC 5.2.12, MyBatis 3.5.6 (mybatis-spring 2.0.6), HikariCP 3.4.5, Logback |
| Database | Oracle (ojdbc6 11.2.0.4) |
| Frontend | JSP / JSTL, HTML5, CSS3, jQuery (AJAX), Bootstrap |
| UI 라이브러리 | SweetAlert2, Colorbox, Slick, QRCode.js |
| 외부 연동 | 카카오페이 결제 API, Gmail SMTP (JavaMail), Channel.io |
| 서버 / 빌드 | Apache Tomcat 9.0, Maven, ngrok |
| 도구 / 협업 | Eclipse (Spring Tools), Git, GitHub, Git LFS, Sourcetree |

<br>

## 구조

`Controller → Service → DAO(MyBatis Mapper) → Oracle` 계층 구조이고, 화면은 JSP로 렌더링합니다.

```
src/main
├─ java/com/icia
│  ├─ common/                 # FileUtil, StringUtil 등 공통 유틸
│  └─ web
│     ├─ controller/          # 사용자(WD*), 관리자(WDAdmin*), 결제(KakaoPay, PayMent), 메일
│     ├─ service/             # 비즈니스 로직
│     ├─ dao/                 # MyBatis Mapper 인터페이스
│     ├─ model/               # VO / DTO
│     ├─ interceptor/         # AuthInterceptor (쿠키 기반 로그인 체크)
│     └─ util/                # Cookie / Http / Json 유틸
├─ resources/com/icia/web/mapper/   # MyBatis SQL 매퍼 XML
└─ webapp/WEB-INF
   ├─ config/                 # env.xml, spring(root-context, servlet-context), mybatis-config
   └─ views/
      ├─ hsdm/                # 웨딩홀 · 스튜디오 · 드레스 · 메이크업
      ├─ board/               # 로그인 · 회원가입, 게시판, 후기, 웨딩플래너, 쿠폰 · QR 식권
      ├─ user/                # 마이페이지, 장바구니, 결제 · 취소 내역
      ├─ kakao/               # 카카오페이 결제 화면
      ├─ mng/                 # 관리자 페이지
      └─ resources/           # css, js, images, upload
```

**주요 테이블** (매퍼 XML 기준)

| 영역 | 테이블 |
| --- | --- |
| 회원 / 관리자 | `WD_USER`, `WD_ADMIN`, `WD_EXPERT` |
| 상품 | `WD_WEDDINGHALL`, `WD_HALL`, `WD_STUDIO`, `WD_DRESS_COM`, `WD_DRESS`, `WD_MAKEUP` (+ 각 `_FILE`) |
| 예약 · 결제 | `WD_REZ`, `WD_COUPON`, `WD_COUPON_INFO`, `WD_QR` |
| 게시판 | `WD_NBOARD`, `WD_EBOARD`, `WD_FBOARD`, `WD_COMMENT`, `WD_REVIEW` (+ 첨부파일 테이블) |

<br>

## 팀 구성 및 담당

**팀원 (6명)**: 박의수, 이욱채, 김보현, 김동욱, 김현아, 신준호

### 이욱채 담당 부분

커밋 기록과 최종 코드(`third` 브랜치)의 작성자 기준으로 정리했습니다. 비머지 커밋 83개(전체 384개 중)입니다.

- **이용후기 게시판**
  - 후기 작성 · 수정 · 삭제 · 상세(`/board/reviewWrite`, `/board/reviewUpdate`, `/board/reviewDelete`, `/board/reviewInfo` 등)
  - 별점 선택 UI, 사진 첨부 · 첨부 삭제
  - 작성 자격 검증: 결제 완료 + 결혼일 경과 여부 확인, 작성 후 예약에 완료 표시(`REVIEW_STATUS`)
  - 후기 상세에서 해당 예약의 홀 · 스드메 정보 조회, 홀 이름 검색
- **관리자 페이지**
  - 관리자 로그인(`/mng/login`), 회원 목록 · 상세 수정(`/mng/userList`, `/mng/MngUserUpdate`)
  - 업체 · 상품 목록(`/mng/hsdmList`)
  - 웨딩홀 업체 / 홀 등록 · 수정 · 삭제(홀 이미지 최대 3장), 스튜디오 · 메이크업 등록, 할인율 입력 검증
  - 후기 게시글 관리(`/mng/mngReviewUpdate`, `/mng/reviewDelete`), 결제 내역 예약번호 검색 · 페이징
- **웨딩홀 결혼일자 검색**: 선택한 날짜에 결제 완료된 예약이 있는 홀을 목록에서 빼는 조회 조건(`WDHallDao.xml`)
- **댓글**: 댓글 수정 · 삭제, 게시글 삭제 시 댓글 일괄 삭제, 목록 제목 옆 댓글 수 표시
- **회원탈퇴**(`/user/userDrop`), 드레스 장바구니 담기(`/hsdm/dressRezProc`), QR 식권 측별 카운트 증가
- **버그 수정**: 결제 페이지 포인트 계산 · 입력값 검증, 아이디 / 비밀번호 찾기 오류, 회원가입 성별 저장 오류, 관리자 페이지 AJAX 처리 등

<br>

## 실행 방법

이클립스(Spring Tools)에서 Tomcat 9로 실행하던 프로젝트입니다. 컴파일 결과가 `src/main/webapp/WEB-INF/classes`로 나가도록 `.classpath`가 잡혀 있습니다.

**준비물**: JDK 8, Apache Tomcat 9.0, Oracle DB, Eclipse(Spring Tools) 또는 Maven 지원 IDE

```bash
git clone https://github.com/lee775/teamwellding.git
cd teamwellding
git checkout third   # 최종 코드
```

1. **DB 준비**: Oracle에 테이블과 시퀀스를 만듭니다. 스키마(DDL) 파일은 저장소에 없어서 `src/main/resources/com/icia/web/mapper/*.xml`의 SQL을 보고 만들어야 합니다.
2. **설정 변경**: `src/main/webapp/WEB-INF/config/env.xml`에서 아래 항목을 각자 환경에 맞게 바꿉니다.
   - DB: `db.jdbc.url`, `db.username`, `db.password`
   - 업로드 경로: `upload.save.dir`, `upload.save.event`, `upload.save.hall`, `upload.save.hallsub`, `upload.save.studio`, `upload.save.dress`, `upload.save.makeup`
   - 카카오페이: `kakao.pay.admin.key`, `kakao.pay.cid`, `kakao.pay.success.url`, `kakao.pay.cancel.url`, `kakao.pay.fail.url`
3. **메일 설정**: `src/main/webapp/WEB-INF/config/spring/root-context.xml`의 `mailSenderGoogle` 빈에 Gmail SMTP 계정을 넣습니다.
4. **실행**: 이클립스에서 Maven 프로젝트로 가져온 뒤 Tomcat 9 서버에 올립니다. JSP가 `/board/...`, `/resources/...` 같은 절대 경로를 쓰므로 컨텍스트 경로를 `/`로 설정합니다.

<br>

## 브랜치

| 브랜치 | 마지막 커밋 | 설명 |
| --- | --- | --- |
| `third` | 2022.02.10 | 최종 발표 버전 |
| `master` | 2022.01.26 | 중간 통합 |
| `develop` | 2022.01.13 | 초기 개발 (현재 기본 브랜치) |

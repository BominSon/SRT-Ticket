# 기차 좌석 예매 앱 프로젝트

## 프로젝트 소개
Flutter를 사용한 기차 좌석 예매 애플리케이션입니다. 사용자가 쉽고 직관적으로 좌석을 선택하고 예매할 수 있는 인터페이스를 제공합니다.

## 주요 기능
- 출발역, 도착역 표시
- 20행 4열(A, B, C, D) 좌석 선택 인터페이스
- 좌석 선택 시 예매 확인 다이얼로그
- 선택된 좌석 시각적 표현 (보라색 강조)

## 구현 화면
[여기에 앱 스크린샷 또는 GIF 추가]

## 트러블 슈팅

### 1. 좌석 선택 UI 개선
- **상황**: 초기 좌석 선택 인터페이스가 사용자 친화적이지 않았음
- **고민**: 어떻게 하면 더 직관적이고 명확한 UI를 만들 수 있을까?
- **적용**: 
  - 선택된 좌석을 보라색으로 강조
  - 좌석 상태 안내 섹션 추가 (선택됨/선택안됨)
- **결과**: 사용자가 현재 좌석 상태를 쉽게 이해할 수 있게 됨

### 2. 예매 확인 다이얼로그 최적화
- **상황**: 기본 대화상자가 디자인 요구사항을 충족하지 못함
- **고민**: 어떻게 하면 더 간결하고 깔끔한 대화상자를 만들 수 있을까?
- **적용**:
  - 커스텀 Dialog 위젯 사용
  - 다이얼로그 너비와 패딩 조정
  - 버튼 색상을 취소(빨간색), 확인(파란색)으로 구분
- **결과**: 디자인 요구사항에 맞는 깔끔한 대화상자 구현

## 도전 과제 및 개선 예정 사항
- [ ] 좌석 예매 실제 기능 구현
- [ ] 좌석 예매 상태 관리 (이미 예매된 좌석 표시)
- [ ] 다양한 기기 크기에 대응하는 반응형 디자인
- [ ] 애니메이션 효과 추가

## 개발 환경
- Flutter
- Dart

## 설치 및 실행 방법
1. Flutter SDK 설치
2. 프로젝트 클론
```bash
git clone [저장소 URL]
```
3. 종속성 설치
```bash
flutter pub get
```
4. 앱 실행
```bash
flutter run
```

## 기술 스택
- Flutter
- Dart

## 작성자자
[봄in]
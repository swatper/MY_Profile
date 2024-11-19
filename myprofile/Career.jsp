<!--Java 코드-->
<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    //메인 html에 넘겨줄 jsp가 사용할 페이지 크기
    String width = "80%";
    String height = "200px";
    //Ajax 요청에 대한 전달
    response.setContentType("application/json");
    response.getWriter().write("{\"width\": \"" + width + "\", \"height\": \"" + height + "\"}");
%>

<!--html 코드-->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Career</title>
    <style>
        /* 콘텐츠를 감싸는 전체 컨테이너 */
        .container {
            width: 80%; /* 화면 너비의 80% */
            max-width: 1200px; /* 최대 너비 제한 */
            text-align: left;
            background-color: #fff; /* 흰색 배경 */
            padding: 30px; /* 내부 여백 */
            border-radius: 8px; /* 둥근 모서리 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 부드러운 그림자 */
        }

        /* 제목 스타일 */
        .title {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 30px;
            color: #000; /* 검은색 텍스트 */
            border-bottom: 1px solid #ccc; /* 하단 구분선 */
            padding-bottom: 10px; /* 제목 아래 여백 */
        }

        /* 수상 내역 리스트 스타일 */
        .award {
            margin-bottom: 20px; /* 각 수상 항목 간 간격 */
        }

        .award-list {
            display: flex; /* 세로줄과 내용을 나란히 배치 */
            align-items: flex-start; /* 세로 정렬 시작점 기준 */
            gap: 15px; /* 세로줄과 내용 간격 */
        }
        /*세로줄 만들기*/
        .award-list::before{
            content: ''; /* 세로줄을 위한 가상 요소 생성 */
            display: block; /* 블록 요소로 설정 */
            width: 2px; /* 세로줄 두께 */
            height: 100%; /* 세로줄 높이: 부모 높이에 맞춤 */
            background-color: black; /* 세로줄 색상 */
        }

        /* 수상 제목 스타일 */
        .award-title {
            font-size: 30px;
            font-weight: bold;
            color: #000000; /* 보라색 텍스트 */
        }

        /* 수상 연도 스타일 */
        .award-year {
            font-size: 25px;
            color: #666; /* 회색 텍스트 */
            margin-top: 5px; /* 제목과의 간격 */
        }

        /* 수상 설명 스타일 */
        .award-name {
            font-size: 17px;
            color: #444; /* 어두운 회색 */
            margin-top: 10px; /* 연도와의 간격 */
            line-height: 1.5; /* 줄 간격 */
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 섹션 제목 -->
        <div class="title">Career</div>

        <!-- 대회 참여 내역 -->
        <div class="award">
            <div class="award-title">대회 참여</div>
            <div class="award-list">
                <div class="award-year">2024년</div>
                <div class="award-name">붕어빵 유니버스 게임 장르 (1차 심사 선정)</div>
                <div class="award-name">제 4회 대학 연합 창업 아이디어 경진대회 (장려상)</div>
                <div class="award-year">2023년</div>
                <div class="award-name">동의대학교 2023 통합 성과 경진대회 (우수상)</div>
            </div>
        </div>

        <!--수료 수상 내역 -->
        <div class="award">
            <div class="award-title">수료 내역</div>
            <div class="award-list">
                <div class="award-year">2024년</div>
                <div class="award-name">학상 창업유망팀 300+ 교육 트랙 수료</div>
                <div class="award-name">제 4회 지역상생 네트워크 부산진구 연합 청년창업캠프 수료</div>
            </div>
        </div>

    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - request</title>
</head>
<body>
	<%
		// post 방식으로 전송된 한글이 깨지는 현상을 처리할때 사용한다.
		request.setCharacterEncoding("UTF-8");
		/* 
		getParameter() : input태그중 text, radio 타입처럼 하나의 값이 전송될 경우
			사용한다. 받은 값은 String 타입으로 저장된다.
		getParameterValues() : input 태그중 checkbox 타입처럼 복수의 값이 전송될
			경우 사용한다. 받은 값은 String 타입의 배열로 저장된다.
		*/
		String id = request.getParameter("id");
		String sex = request.getParameter("sex");
		//checkbox의 경우 선택한 항목만 전송된다. 즉 선택한 갯수가 배열의 크기가 된다.
		String[] favo = request.getParameterValues("favo");
		String favoStr = "";
		if (favo != null) {
			// String 배열이므로 크기만큼 반복 가능하다.
			for (int i = 0; i<favo.length; i++) {
				favoStr += favo[i] + " ";
			}
		}
		/*
		textarea는 두줄 이상 입력이 가능하므로 엔터키는 \r\n으로 저장된다.
		따라서 화면에 출력시에는 <br>태그로 변경해야한다.
		*/
		String intro = request.getParameter("intro").replace("\r\n", "<br>");
	%>
	<ul>
		<li>아이디 : <%= id %></li>
		<li>성별 : <%= sex %></li>
		<li>관심사항 : <%= favoStr %></li>
		<li>자기소개 : <%= intro %></li>
	</ul>
</body>
</html>
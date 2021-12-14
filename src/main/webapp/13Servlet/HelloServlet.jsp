<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 
		요청명을 결정한 후 링크를 설정한다. 상대경로이기 때문에
		현재 디렉토리명을 포함한 경로가 요청명이 된다.
	 -->
	 <!-- 요청명을 링크에 상대경로로 적용함 -->
	<h2>web.xml에서 매핑 후 JSP에서 출력하기</h2>
	<p>
		<!-- 서블릿에서 리퀘스트 영역에 저장한 속성값을 출력한다. -->
		<strong><%= request.getAttribute("message") %></strong>
		<br>
		<a href="./HelloServlet.do">바로가기</a>
	</p>
</body>
</html>
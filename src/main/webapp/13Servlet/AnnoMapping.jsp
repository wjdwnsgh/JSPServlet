<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>애너테이션으로 매핑하기</h2>
	<p>
		<strong>${ message }</strong>
		<br />
		<!-- 요청명을 링크에 절대경로로 적용함. -->
		<a href="<%= request.getContextPath() %>/13Servlet/AnnoMapping.do">바로가기</a>
	</p>
</body>
</html>
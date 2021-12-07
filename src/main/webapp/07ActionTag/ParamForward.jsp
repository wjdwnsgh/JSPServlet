<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 앞에서 request 영역에 저장된 자바빈이므로 포워드된 페이지에서 공유됨 -->
	<jsp:useBean id="person" class="common.Person" scope="request" />
	<h2>포워드된 페이지에서 매개변수 확인</h2>
	<ul>
		<li> <jsp:getProperty property="name" name="person"/> </li>
		<li>나이 : <jsp:getProperty property="age" name="person"/> </li>
		<li>본명 : <%= request.getParameter("param1") %></li>
		<li>출생 : <%= request.getParameter("param2") %></li>
		<li>특징 : <%= request.getParameter("param3") %></li>
	</ul>
	<!-- 인클루드로 포함된 페이지 : 인클루드시 파라미터를 2개 추가함 -->
	<jsp:include page="inc/ParamInclude.jsp">
		<jsp:param value="강원도 영월" name="loc1"/>
		<jsp:param value="김삿갓면" name="loc2"/>
	</jsp:include>
</body>
</html>
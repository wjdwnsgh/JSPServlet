<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>액션 태그로 폼값 한번에 받기</h2>
	<form action="UseBeanAction.jsp" method="post">
		이름 : <input type="text" name="name" />
		나이 : <input type="text" name="age" />
		<input type="submit" value="폼값 전송" />
	</form>
</body>
</html>
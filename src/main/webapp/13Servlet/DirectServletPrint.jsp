<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>web.xml에서 매핑 후 Servlet에서 직접 출력하기</h2>
	<!-- 컨텍스트루트 경로를 제외한 상대경로로 링크를 생성 -->
	<form action="../13Servlet/DirectServletPrint.do" method="post">
		<!-- POST방식으로 요청 -->
		<input type="submit" value="바로가기" />
	</form>
</body>
</html>
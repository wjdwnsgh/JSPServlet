<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 - exception</title>
</head>
<body>
	<%
		// 응답객체를 통해 현재 서버의 상태를 정수형태로 얻어온다.
		int status = response.getStatus();
		
		// 에러 코드에 따라 적절한 메세지를 출력한다.
		if(status == 404) {
			out.print("404 에러가 발생하였습니다.");
			out.print("<br>파일 경로를 확인해주세요.");
		}
		else if(status == 405) {
			out.print("405 에러가 발생하였습니다.");
			out.print("<br>요청 방식(method)을 확인해주세요.");
		}
		else if(status == 500) {
			out.print("500 에러가 발생하였습니다.");
			out.print("<br>소스 코드에 오류가 없는지 확인해주세요.");
		}
	%>
	<br>
	<img src="../images/Error.jpg" alt="오류발생됨"  width="300" />
</body>
</html>
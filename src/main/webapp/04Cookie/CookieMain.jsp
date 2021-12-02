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
		쿠키
			: 클라이언트의 상태 정보를 유지하기 위한 기술로 주로 클라이언트의
			PC에 파일의 형태까지 저장된다.
			쿠키는 3000개까지 만들 수 있고, 하나의 크기는 최대4kb이다.
	 -->
	<h2>1. 쿠키(Cookie) 설정</h2>
	<%
		/*
			쿠키는 생성자를 통해서만 생성할 수 있다. setName()이란 메서드가
			없으므로 쿠키 생성 후 이름을 변경할 수 없다.
		*/
		Cookie cookie = new Cookie("myCookie", "쿠키맛나요");
		// 쿠키가 적용될 경로 설정. 컨텍스트루트 경로로 지정하였다.
		cookie.setPath(request.getContextPath());
		System.out.println("설정경로 : " + request.getContextPath());
		// 쿠키가 유지될 시간을 설정. 1시간으로 설정하였다.
		cookie.setMaxAge(3600);
		// 응답헤더에 쿠키를 추가하여 클라이언트 측으로 전송한다.
		response.addCookie(cookie);
		// 여기까지의 코드를 통해 클라이언트 측에는 쿠키가 생성된다.
	%>
	
	<h2>2. 쿠키 설정 직후 쿠키값 확인하기</h2>
	<%
		/*
			request내장객체의 getCookies()메서드를 통해 현재 생성된 모든 쿠키를
			배열의 형태로 가져온다.
		*/
		Cookie[] cookies = request.getCookies();
		if(cookies!=null) {
			// 쿠키가 있다면 갯수만큼 확장 for문을 통해 반복한다.
			for(Cookie c : cookies) {
				String cookieName = c.getName(); // 쿠키명을 읽어오기
				String cookieValue = c.getValue(); // 쿠키값을 읽어오기
				// 화면에 출력
				out.println(String.format("%s : %s<br>", cookieName, cookieValue));
			}
		}
		/*
			쿠키가 생성된 직후에는 쿠키값을 읽을 수 없다. 새로고침 하거나
			페이지 이동을 통해 새로운 요청을 보낸 후 읽을 수 있다.
		*/
	%>
	
	<h2>3. 페이지 이동 후 쿠키값 확인하기</h2>
	<a href="CookieResult.jsp">
		다음 페이지에서 쿠키값 확인하기
	</a>
</body>
</html>
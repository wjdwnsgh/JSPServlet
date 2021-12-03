<%@page import="utils.CookieManager"%>
<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 전송된 폼값을 받는다.
	String user_id = request.getParameter("user_id");
	String user_pw = request.getParameter("user_pw");
	
	/*
		checkbox의 경우 둘 이상의 값이라면 getParameterValues()를 통해 받아야 하지만
		항목이 한개라면 getParameter()로 받을 수 있다.
	*/
	String save_check = request.getParameter("save_check");
	
	//아이디/패스워드가 일치하는 경우 로그인 성공 처리
	if("must".equals(user_id) && "1234".equals(user_pw)) {
		//로그인 성공시 아이디저장 체크를 했다면..
		if(save_check != null && save_check.equals("Y")) {
			// 쿠키를 저장한다. 쿠키값은 로그인 하이디, 유효기간은 1일로 설정한다.
			CookieManager.makeCookie(response, "loginId", user_id, 86400);
		}
		else {
			//로그인에 성공하고, 체크하지 않았다면 쿠키를 삭제한다.
			CookieManager.deleteCookie(response, "loginId");
		}
		
		//JSFunction.alertLodcation("로그인에 성공했습니다.", "IdSaveMain.jsp", out);
%>
	<script>
		alert('로그인에 성공했습니다.');
		location.href="IdSaveMain.jsp";
	</script>
<%
	}
	else {
		// 로그인 실패
		//JSFunction.alertBack("로그인에 실패했습니다.", out);
%>

		<script>
			alert('로그인에 실패했씁니다');
			history.back();
		</script>
<%
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
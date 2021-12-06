<%@page import="common.DBConnPool"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JDBC</title>
</head>
<body>
	<h2>JDBC 테스트 1</h2>
	<%
		JDBConnect jdbc1 = new JDBConnect();
		jdbc1.close();
	%>
	
	<h2>JDBC 테스트2</h2>
	<%
		//application 내장객체를 통해 web.xml에 저장된 컨텍스트 초기화 파라미터를 가져옴
		String driver = application.getInitParameter("OracleDriver");
		String url = application.getInitParameter("OracleURL");
		String id = application.getInitParameter("OracleId");
		String pwd = application.getInitParameter("OraclePwd");
		// 인자생성자를 통한 DB연결
		JDBConnect jdbc2 = new JDBConnect(driver, url, id, pwd);
		jdbc2.close();
	%>
	
	<h2>JDBC 테스트3</h2>
	<%
		// 인자생성자2를 통한 DB연결
		JDBConnect jdbc3 = new JDBConnect(application);
		jdbc3.close();
	%>
	
	<h2>커넥션 풀 테스트</h2>
	<%
		DBConnPool pool = new DBConnPool();
		/* 
		커넥션풀은 톰켓이 미리 만들어둔 커넥션 객체를 재사용하는 개념이므로
		사용 후 반납하지 않으면 객체가 부족하여 사용할 수 없는 상태가 될 수 있다.
		주의요망.
		*/
		pool.close();
	%>
</body>
</html>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="common.JDBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>회원 목록 조회 테스트(executeQuery() 사용)</h2>
	
	<%
		JDBConnect jdbc = new JDBConnect();
		
		String sql = "SELECT id, pass, name, regidate FROM member";
		Statement stmt = jdbc.con.createStatement();
		
		// 행에 영향이 없는 쿼리를 실행할 경우 executeQuery()를 사용한다.
		ResultSet rs = stmt.executeQuery(sql);
		/* 
		select의 결과는 ResultSet객체를 통해 반환하고 , 그 갯수만큼
		반복하여 출력한다.
		*/
		while (rs.next()) {
			// 각 레코드의 컬럼에 접근시 인덱스를 사용할 수 있고, 컬럼명을 사용할수도 있다
			String id = rs.getString(1); // 인덱스는 1부터 시작
			String pw = rs.getString(2);
			String name = rs.getString("name"); //컬럼명을 직접사용
			java.sql.Date regidate = rs.getDate("regidate");
			
			out.println(String.format("%s %s %s %s", id, pw, name, regidate) + "<br>");
		}
		
		jdbc.close();
	%>
</body>
</html>
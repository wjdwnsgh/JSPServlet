<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="common.Person"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h4>List 컬렉션 이용하기</h4>
	<%
		// Person객체를 저장할 수 있는 List계열의 컬렉션 생성
		ArrayList<Person> pList = new ArrayList<Person>();
		// List에 객체 추가
		pList.add(new Person("성삼문", 55));
		pList.add(new Person("박팽년", 60));
	%>
	
	<!-- request영역에 컬렉션 저장 -->
	<c:set var="personList" value="<%= pList %>" scope="request" />
	<ul><!-- '성삼문' 객체를 출력 -->
		<li>이름 : ${ requestScope.personList[0].name }</li> <!-- List컬렉션이므로 인덱스로 접근 가능하다. -->
		<li>나이 : ${ personList[0].age }</li>
	</ul>
	
	<h4>Map 컬렉션 이용하기</h4>
	<%
		//Key는 String, Value는 Person타입인 Map계열의 컬렉션 생성
		Map<String, Person> pMap = new HashMap<String, Person>();
		//컬렉션에 2개의 객체저장
		pMap.put("personArgs1", new Person("하위지", 65));
		pMap.put("personArgs2", new Person("이개", 67));
	%>
	<!-- request영역에 속성 저장 -->
	<c:set var="personMap" value="<%= pMap %>" scope="request" />
	<ul><!-- Map 컬렉션이므로 Key값을 통해 접근하여 출력함. -->
		<li>아이디 : ${ requestScope.personMap.personArgs2.name }</li>
		<li>비번 : ${ personMap.personArgs2.age }</li>
	</ul>
</body>
</html>
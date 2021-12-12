<%@page import="common.Person"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 
	set태그
		: 변수를 선언할 때 사용한다. JSP의 serAttribute()와 동일한 기능을 한다.
		4가지 영역에 새로운 속성을 추가한다.
	속성정리
		var : 속성명(변수명). 즉 영역에 저장될 이름
		value : 속성값
		scope : 4가지 영역명을 지정. 미지정시 page 영역으로 지정됨.(제일좁은 영역)
		target : set태그를 통해 생성된 자바빈즈의 이름을 지정함.
		property : target으로 지정한 자바빈즈의 멤버변수(property)값 설정함.
 -->
<body>
	<!-- set태그를 이용한 변수선언 -->
	<c:set var="directVar" value="100" /><!-- 1. 일반값 사용 -->
	<c:set var="elVar" value="${ directVar mod 5 }" /><!-- 2. EL을 사용 -->
	<c:set var="expVar" value="<%= new Date() %>" /><!-- 3.표현식을 사용 -->
	<c:set var="betweenVar">변수값 요렇게 설정</c:set><!-- 4. 시작태그와 종료태그 사이에 value지정 -->
	<!-- scope속성을 생략했으므로 가장좁은 영역인 page영역에 변수 저장됨 -->
	
	<!-- 
		속성명이 중복되지 않는다면 영역을 표시하는 내장객체를 생략할 수 있다.
	 -->
	<h4>EL을 이용해 변수 출력</h4>
	<ul>
		<li>directVar : ${ pageScope.directVar }</li>
		<li>elVar : ${ elVar }</li>
		<li>expVar : ${ expVar }</li>
		<li>vetweenVar : ${ betweenVar }</li>
	</ul>
	
	<h4>자바빈즈 생성 1 - 생성자 사용</h4>
	<c:set var="personVar1" value='<%= new Person("박문수", 50) %>'
			scope="request" />
	<ul><!-- 객체의 getter를 통해 멤버변수 값 출력 -->
		<li>이름 : ${ requestScope.personVar1.name }</li>
		<li>나이 : ${ personVar1.age }</li>
	</ul>
	
	<h4>자바빈즈 생성 2 - target, property 사용</h4>
	<!-- 자바빈을 request영역에 생성 -->
	<c:set var="personVar2" value="<%= new Person() %>" scope="request" />
	<!-- 멤버변수 값 설정 -->
	<c:set target="${ personVar2 }" property="name" value="정약용" />
	<c:set target="${ personVar2 }" property="age" value="60" />
	
	<ul>
		<li>이름 : ${ personVar2.name }</li>
		<li>나이 : ${ requestScope.personVar2.age }</li>
	</ul>
</body>
</html>
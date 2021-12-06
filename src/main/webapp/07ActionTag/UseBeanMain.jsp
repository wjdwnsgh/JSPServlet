<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>useBean 액션 태그</h2>
	<h3>자바빈즈 생성하기</h3>
	<!-- 
	아래 코드를 java코드로 변경하면 
		import="common.Person"
		Person person = new Person();
	 	person.setName("홍길동");
	 	person.setAge(33);
	 	request.setAttribute("person", person);
	즉, 클래스를 임포트 한 후 객체를 생성하고 setter를 통해 멤버변수의
	값을 설정한다.
	 
	각 속성은
		id="참조변수명(자바빈의이름)" class="패키지를 포함한 클래스명" scope="저장할 영역"
	 -->
	<jsp:useBean id="person" class="common.Person" scope="request" />
	
	<h3>setProperty 액션 태그로 자바빈즈 속성 지정하기</h3>
	<!-- DTO객체의 setter() 메서드를 이용해서 값 설정 -->
	<jsp:setProperty property="name" name="person" value="임꺽정" />
	<jsp:setProperty property="age" name="person" value="41" />
	
	<h3>getProperty 액션 태그로 자바빈즈 속성 읽기</h3>
	<!-- DTO객체의 getter() 메서드를 통해 값 출력 -->
	<ul>
		<li>이름 : <jsp:getProperty property="name" name="person"/> </li>
		<li>나이 : <jsp:getProperty property="age" name="person"/> </li>
	</ul>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 
	choose 태그
		: 하위에 when, otherwise 태그를 가지고 있다.
		여러 조건이 있는경우 사용하기에 적합하다.
 -->
<body>
	<!-- 변수 선언 -->
	<c:set var="number" value="100" />
	
	<h4>choose 태그로 홀짝 판단하기</h4>
	<c:choose>
		<c:when test="${ number mod 2 eq 0 }">
			${ number }는 짝수입니다.
		</c:when>
		<c:otherwise>
			${ number }는 홀수입니다.
		</c:otherwise>
	</c:choose>
	
	<h4>국,영,수 점수를 입력하면 평균을 내어 학점 출력</h4>
	<form>
		국어 : <input type="text" name="kor" /> <br>
		영어 : <input type="text" name="eng" /> <br>
		수학 : <input type="text" name="math" /> <br>
		<input type="submit" value="학점 구하기" />
	</form>
	<!-- 
		실행 초기에는 전송한 폼값이 없는 상태이므로 아무런 결과도 출력되지 않는다.
	 -->
	<c:if test="${ not (empty param.kor or empty param.eng or empty param.math) }">
		<!-- 파라미터로 전달된 국,영,수 점수의 평균값을 구해 avg변수에 저장한다. -->
		<c:set var="avg" value="${ (param.kor + param.eng + param.math) / 3 }" />
		평균점수는 ${ avg }으로
		<!-- 각 조건을 통해 학점을 출력한다. -->
		<c:choose>
			<c:when test="${ avg >= 90 }">A 학점</c:when>
			<c:when test="${ avg >= 80 }">B 학점</c:when>
			<c:when test="${ avg ge 70 }">C 학점</c:when>
			<c:when test="${ avg ge 60 }">D 학점</c:when>
			<c:otherwise>F 학점</c:otherwise>
		</c:choose>
		입니다.
	</c:if>
</body>
</html>
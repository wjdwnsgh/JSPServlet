<%@page import="java.util.ArrayList"%>
<%@page import="real.project.ZipcodeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
// DAO생성 및 DB연결
ZipcodeDAO dao = new ZipcodeDAO();
// 시/도를 select해서 List컬렉션으로 반환
ArrayList<String> sidoList = dao.getSido();
//JSTL 태그를 사용하기 위해 page영역에 저장
pageContext.setAttribute("sidoList", sidoList);
// 커넥션 풀에 자원 반납
dao.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	$('#sido').change(function(){
		$.ajax({
			url : "../DynamicAddress.do",
			type : "get",
			contentType : "text/html;charset:utf-8;",
			data : { // 파라미터 : 사용자가 선택한 시/도
				sido : $('#sido option:selected').val()
			},
			dataType : "json",
			success:function(d){
				console.log("콜백데이터", d);
				var optionStr = "";
				optionStr += "<option value=''>-구군선택-</option>";
				// 콜백받은 JSON 배열을 통해 each()메소드 실행
				$.each(d, function(index, data){
					console.log(index, data);
					// JSON 배열의 크기만큼 option태그가 생성
					optionStr += '<option value="'+data+'">'+data+'</option>';
				});
				//새로운 내용으로 select태그에 삽입함
				$('#gugun').html(optionStr);
			},
			error:function(e){
				alert("오류발생:"+e.status+":"+e.statusText);
			}
		});
	});
	//확인용 : 선택한 시/도 와 구/군을 alert로 출력
	$('#gugun').change(function(){
		var sido = $('#sido option:selected').val();
		var gugun = $('#gugun option:selected').val();
		alert(sido + gugun + " 선택함");
	});
});
</script>
</head>
<body>
	<div class="container">
	    <div class="row">
	   	 <h2>우편번호DB를 이용한 시도/구군 동적셀렉트 구현</h2>
	    </div>
	    <form id="zipFrm">
	    <div class="row">   	 
	   	 <div class="col-4">
	   		 시/도:
	   		 <select id="sido" class="form-control">
	   			 <option value="">-시/도선택하삼-</option>
	   			 <!-- page영역에 저장된 내용을 출력 -->
	   			 <c:forEach items="${sidoList }" var="sidoStr">
	   				 <option value="${sidoStr }">${sidoStr }</option>
	   			 </c:forEach>
	   		 </select>
	   	 </div>
	   	 <div class="col-8">
	   		 구/군:
	   		 <select id="gugun" class="form-control">
	   			 <option value="">-구/군선택하삼-</option>
	   		 </select>
	   	 </div>   	 
	    </div>
	    </form>
	</div>

</body>
</html>
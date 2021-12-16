<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
$(function(){
	//jQuery UI의 데이트피커 선언. 한국에서 사용하는 날짜포맷으로 변경
	$( "#startCreateDt" ).datepicker();
	$( "#startCreateDt" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	$( "#endCreateDt" ).datepicker();
	$( "#endCreateDt" ).datepicker( "option", "dateFormat", "yy-mm-dd" );
	
	//문서가 로드될때 $.ajax()에서 사용할 기본적인 속성 선언
	$.ajaxSetup({
		url : "../Covid19DataRead.do",
		type : "get",
		contentType : "text/html;charset=utf-8",
		dataType : "xml", // 콜백데이터 타입
	});
	
	$('#submitBtn').click(function(){
		// 날짜에 포함된 -(하이픈)을 replace()를 통해 제거
		var scd = $('#startCreateDt').val().replace(/-/g,'');
		var ecd = $('#endCreateDt').val().replace(/-/g,'');
		/*
		/-/g 와 같은 정규표현식을 사용하면 문자열 내의 모든 하이픈을 제거해준다.
		정규표현식을 쓰지 않으면 앞에 있는 하이픈 하나만 제거된다.
		*/
		
		// 여기에서 공공 데이터 API요청
		$.ajax({
			data : { // 파라미터 
				startCreateDt : scd, // 시작일
				endCreateDt : ecd, // 종료일
			},
			success : sucFuncXml,
			error : errFunc,
		});
	});
});

// 요청에 성공한 경우의 콜백 메서드
function sucFuncXml(d) {
	var str = "";
	var resultCode = $(d).find("response").find("header").find("resultCode");
	var createDt = new Array();// 등록일시분초
	var stateDt = new Array(); // 기준일
	var decideCnt = new Array();//누적 확진자 수
	var deathCnt = new Array(); // 누적사망자 수
	var accExamCnt = new Array(); // 누적 검사 수
	var todayDecideCnt = new Array(); // 금일 확진자 수
	
	// 검색한 날짜 구간에서 반환된 결과데이터를 반복해서 파싱한다.
	$(d).find("response").find("body").find("items").find("item")
		.each(function(index) {
			
			//find()를 통해 노드를 검색한 후 text()를 통해 값을 얻어온다.
			createDt[index] = $(this).find("createDt").text();
			stateDt[index] = $(this).find("stateDt").text();
			decideCnt[index] = $(this).find("decideCnt").text();
			deathCnt[index] = $(this).find("deathCnt").text();
			accExamCnt[index] = $(this).find("accExamCnt").text();
			console.log(stateDt[index], decideCnt[index], deathCnt[index], accExamCnt[index]);
	});
	
	//웹브라우저에 출력할 테이블 생성
	var table = "<table class=\"table table-bordered mt-3\">"
		+"<tr class=\"text-center\">"
		+"   <th>날짜</th>"
		+"   <th>금일확진자수</th>"
		+"   <th>누적확진자수</th>"
		+"   <th>누적사망자수</th>"
		+"   <th>누적검사수</th>"
		+"</tr>";
	for(var i =0; i<decideCnt.length-1; i++) {
		// 금일확진자 수 계산 = 오늘확진자 수 - 어제 확진자 수
		todayDecideCnt[i] = decideCnt[i] - decideCnt[i+1];
		
		console.log("날짜", createDt[i]);
		console.log("금일확진자", todayDecideCnt[i]);
		
		table += ""
			+"<tr class=\"text-center\">"
			+"  <td>"+createDt[i]+"</td>"
			+"  <td>"+todayDecideCnt[i]+"</td>"
			+"  <td>"+decideCnt[i]+"</td>"
			+"  <td>"+deathCnt[i]+"</td>"
			+"  <td>"+accExamCnt[i]+"</td>"
			+"</tr>";
	}
	table += "</table>";
	//결과 출력
	$('#resultShow').html(table);
}
function errFunc(e) {
	alert("실패:"+e.status+":"+e.statusText);
}
</script>
</head>
<body>
	<div>공공데이터를 활용한 Covid19 확진자 현황</div>
	<form>
		시작일 : <input type="text" name="startCreateDt" id="startCreateDt" />
		종료일 : <input type="text" name="endCreateDt" id="endCreateDt" />
		<input type="button" id="submitBtn" value="요청하기" />
	</form>
	
	<div id="resultShow">
	
	</div>
</body>
</html>
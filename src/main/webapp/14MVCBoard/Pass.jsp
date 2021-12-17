<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function validateForm(form) {
		
		if(form.pass.value == "") {
			alert("비밀번호를 입력하세요");
			form.pass.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<h2>파일 첨부형 게시판 - 비밀번호 검증(Pass)</h2>
	<form action="../mvcboard/pass.do" name="writeFrm" method="post"
		onsubmit="return validateForm(this);">
		<!-- 컨트롤러에서 파라미터를 받은 후 리퀘스트 영역에 저장한 후 출력한다. -->
	<input type="hidden" name="idx" value="${ param.idx }" />
	<!-- 뷰에서 바로 파라미터를 받아 출력한다. -->
	<input type="hidden" name="mode" value="${ param.mode }" />
		<table border="1" width="90%">
			
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="pass" style="width:100px;" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<button type="submit">검증하기</button>
					<button type="reset">RESET</button>
					<button type="button" onclick="location.href='../mvcboard/list.do';">
					목록보기
					</button>
				</td>
			</tr>
		</table>	
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유 게시판 글 쓰기</title>
<link rel="stylesheet" href="resources/util/bootstrap.css"/>
<link rel="stylesheet" href="resources/bootstrap-responsive.css"/>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="resources/util/bootstrap.js"></script>
<style>
body { margin-top : 40px; background : #FFF0F5;}
</style>

<script type="text/javascript">
	function chk(){
		f = document.commentForm;
		if(!f.name.value || f.name.value.trim().length == 0) {
			alert('이름을 입력해주세요.');
			f.name.value = "";
			f.name.focus();
			return false;
		}
		if(!f.password.value || f.password.value.trim().length == 0) {
			alert('암호를 입력해주세요.');
			f.password.value = "";
			f.password.focus();
			return false;
		}
		if(!f.title.value || f.title.value.trim().length == 0) {
			alert('제목을 입력해주세요.');
			f.title.value = "";
			f.title.focus();
			return false;
		}
		if(!f.content.value || f.title.value.trim().length == 0) {
			alert('내용을 입력해주세요.');
			f.content.value = "";
			f.content.focus();
			return false;
		}
		return true;
	}
</script>
</head>
<body>

<div class="container">
<form action="insertOK" method="post" name="commentForm" onsubmit="return chk()">
<input type="hidden" name="ip" value="${pageContext.request.remoteAddr}">
<table width="500" align="center" border="1">
	<tr><th colspan="3">자유 게시판 글 쓰기</th></tr>
	<tr>
		<td width="100">이름</td>
		<td width="320"><input type="text" name="name"/></td>
		<td width="80">공지글<input type="checkbox" name="notice" value="notice"/></td>
	</tr>
	<tr>
		<td>비밀번호</td>
		<td colspan="2"><input type="password" name="password"/></td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan="2"><input type="text" name="title"/></td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan="2"><textarea rows="10" cols="50" name="content"></textarea></td>
	</tr>
	<tr>
		<td colspan="3" align="center">
			<input type="submit" value="저장하기"/>
			<input type="reset" value="다시쓰기"/>
			<input type="button" value="돌아가기1" onclick="history.back()"/>
			<input type="button" value="돌아가기2" onclick="history.go(-1)"/>
			<input type="button" value="돌아가기3" onclick="location.href='list?currentPage=${vo.currentPage}'"/>
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>

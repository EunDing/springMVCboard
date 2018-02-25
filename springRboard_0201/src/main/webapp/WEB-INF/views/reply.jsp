<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/util/bootstrap.css"/>
<link rel="stylesheet" href="resources/bootstrap-responsive.css"/>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="resources/util/bootstrap.js"></script>
</head>
<style>
body { margin-top : 40px; background : #FFF0F5;}
</style>
<script type="text/javascript">
	function chk(){
		f = document.form1;
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
<body>
<div class="container">
<form action="replyOK" method="post" onsubmit="return chk();" name="form1">
		<input type="hidden" name="idx" value="${vo.idx}"/>
		<input type="hidden" name="currentPage" value="${currentPage}"/>
		<input type="hidden" name="ref" value="${vo.ref}"/>
		<input type="hidden" name="lev" value="${vo.lev}"/>
		<input type="hidden" name="seq" value="${vo.seq}"/>
		<input type="hidden" name="ip" value="${pageContext.request.remoteAddr}"/>
		<br/>
		이름 : <input type="text" name="name"/><br/>
		비번 : <input type="password" name="password"/><br/>
		제목 : <input type="text" name="title" size="80"/><br/>
		내용 : <textarea rows="10" cols="80" name="content"></textarea><br/>
		<input type="submit" class="btn btn-default" value="저장하기">
		<input type="button" class="btn btn-default" value="돌아가기" 
				onclick="location.href='view?idx=${vo.idx}&currentPage=${currentPage}'">
	</form>
</div>
</body>
</html>
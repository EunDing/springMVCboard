<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자유 게시판 글 보기</title>
<link rel="stylesheet" href="resources/util/bootstrap.css"/>
<link rel="stylesheet" href="resources/bootstrap-responsive.css"/>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="resources/util/bootstrap.js"></script>
<script type="text/javascript">
	function setting (mode, idx, title, name, content){
		f = document.commentForm; 	//현재 문서(view.jsp)의 commentForm 폼
		f.mode.value = mode;
		f.idx.value = idx;
		f.commentBtn.value = title;
		f.name.value = name;
		
//인수로 넘겨받은 content <br/>이 있는 동안 반복하며 <br/>을 "\r\n"으로 치환시킨다.
		while (content.indexOf("<br/>") != -1){
			content = content.replace("<br/>","\r\n");
		}
		f.content.value = content;
		
		mode == 1 ? f.name.focus() : f.password.focus();
	}
	
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
		if(!f.content.value || f.title.value.trim().length == 0) {
			alert('내용을 입력해주세요.');
			f.content.value = "";
			f.content.focus();
			return false;
		}
		return true;
	}
</script>
<style>
body { margin-top : 40px; background : #FFF0F5; }
.btn { font-size : 12px; padding : 3px;}
</style>
</head>
<body>
<jsp:useBean id="date" class="java.util.Date"/>			<!-- 오늘 날짜 -->

<div class="container">
<table width="600" align="center" border="1" >
	<tr><th colspan="4">게시글 보기</th></tr>
	<tr align="center">
		<td width="70">글번호</td>
		<td width="320">작성자</td>
		<td width="120">작성일</td>
		<td width="70">조회수</td>
	</tr>
	<tr>
		<td align="center">${vo.idx}</td>
		<td align="center">
			<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			${name}
		</td>
		
		<td align="center">
			<c:if test="${date.year == vo.wdate.year && date.month == vo.wdate.month && 
				date.date == vo.wdate.date}">
					<fmt:formatDate value="${vo.wdate}" pattern="HH:mm"/>
			</c:if>
			<c:if test="${date.year != vo.wdate.year || date.month != vo.wdate.month || 
				date.date != vo.wdate.date}">
				<fmt:formatDate value="${vo.wdate}" pattern="yyyy.MM.dd(E)"/>
			</c:if>
		</td>
		<td align="center" >${vo.hit}</td>
	</tr>
	
	<tr>
		<td>제목</td>
		<td colspan="3">
			<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;')}"/>
			<c:set var="title" value="${fn:replace(title, '>', '&gt;')}"/>
			${title}
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan="3">
			<c:set var="content" value="${fn:replace(vo.content, '<', '&lt;')}"/>
			<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
			<c:set var="content" value="${fn:replace(content, rn, '<br/>')}"/>
			${content}
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" value="수정하기" class="btn btn-warning"
				onclick="location.href='update?idx=${vo.idx}&currentPage=${currentPage}'"/>
			<input type="button" value="삭제하기" class="btn btn-warning"
				onclick="location.href='delete?idx=${vo.idx}&currentPage=${currentPage}'"/>
			<input type="button" value="답변달기" class="btn btn-warning"
				onclick="location.href='reply?idx=${vo.idx}&currentPage=${currentPage}'"/>
			<input type="button" value="목록보기" class="btn btn-warning"
				onclick="location.href='list?currentPage=${currentPage}'"/>
		</td>
	</tr>
</table>
<br/>
<hr/>

<!-- 여기부터 댓글 입력폼 -->
<form action="commentOK" method="post" name="commentForm" onsubmit="return chk()">
<table width="600" align="center" border="1">
	<tr style="DISPLAY: none">
		<td colspan="5"> 
			idx : <input type="text" name="idx" value="${vo.idx}" size="3"/> 
			<!-- 몇 번 글의 댓글인지 넘겨준다.  -->
			ref : <input type="text" name="ref" value="${vo.idx}" size="3"/>
			<!-- 작업 mode : 1 = 저장 , 2 - 수정, 3- 삭제 -->
			mode : <input type="text" name="mode" value="1" size="2"/> 
			<!--selectByIdx.jsp에서 currentPage로 받아주었으니까 vo.currentPage로 쓰지 않는다.  -->
			currentPage : <input type="text" name="currentPage" value="${currentPage}" size="2"/> 
			ip : <input type="text" name="ip" value="${pageContext.request.remoteAddr}" size="10"/> 
		</td>
	</tr>


	<tr>
		<td colspan="2">이름</td>
		<td><input type="text" name="name" /></td>
		<td >비밀번호</td>
		<td><input type="password" name="password" /></td>
	</tr>
	<tr>
		<td colspan="2">내용</td>
		<td colspan="3">
		<textarea rows="5" cols="53" name="content"></textarea>
		<input type="submit" value="댓글 저장" class="btn btn-warning" name="commentBtn"/>
		<input type="reset" value="다시쓰기"  class="btn btn-warning" onclick="setting(1,0,'댓글저장','','')" />
		</td>
	</tr>
	
<!-- 댓글이 없을 경우 출력하는 메시지 -->
	<c:if test="${commentList.list.size() == 0}">
	<tr>
		<td colspan="4">
			무플싫다 ㅠㅠ
		</td>
	</tr>
	</c:if>
	
	<!-- 댓글이 있으면 목록을 출력한다. -->
	<c:if test="${commentList.list.size() != 0}">
	<c:forEach var="comment" items="${commentList.list}">
		<tr>
			<td colspan="5">
				${comment.name}님이
				<fmt:formatDate value="${comment.wdate}" pattern="yyyy년 MM월 dd일(E)"/>에 남긴글
				<br/>
				<c:set var="content" value="${fn:replace(comment.content, '<', '&lt;')}"/>
				<c:set var="content" value="${fn:replace(content, '>', '&gt;')}"/>
				<c:set var="content" value="${fn:replace(content, rn, '<br/>')}"/>
				${content}
				<input type="button" value="댓글수정" class="btn btn-warning"
					onclick="setting(2,${comment.idx},'댓글수정', '${comment.name}', '${content}')"/>
				<input type="button" value="댓글삭제" class="btn btn-warning"
					onclick="setting(3,${comment.idx},'댓글삭제', '${comment.name}','${content}')"/>
			</td>
		</tr>
	</c:forEach>
	</c:if>
</table>
</form>
</div>

</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정글 보기</title>
<link rel="stylesheet" href="resources/util/bootstrap.css"/>
<link rel="stylesheet" href="resources/bootstrap-responsive.css"/>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="resources/util/bootstrap.js"></script>
</head>
<style>
body { margin-top : 40px; background : #FFF0F5;}
</style>
<body>
<jsp:useBean id="date" class="java.util.Date"/>			<!-- 오늘 날짜 -->

<div class="container">
<form action="updateOK" method="post">

<!-- 삭제할 글 번호와 삭제후 돌아갈 페이지 번호를 hidden으로 숨긴다. -->
	<input type="hidden" name="idx" value="${vo.idx}"/>
	<input type="hidden" name="currentPage" value="${currentPage}"/>
	
<table width="600" align="center" border="1">
	<tr><th colspan="4">수정할 글 보기</th></tr>
	<tr>
		<td width="70">글번호</td>
		<td width="320">작성자</td>
		<td width="120">작성일</td>
		<td width="70">조회수</td>
	</tr>
	<tr>
		<td>${vo.idx}</td>
		<td>
			<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
			<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
			${name}
		</td>
		
		<td>
			<c:if test="${date.year == vo.wdate.year && date.month == vo.wdate.month && 
				date.date == vo.wdate.date}">
					<fmt:formatDate value="${vo.wdate}" pattern="HH:mm"/>
			</c:if>
			<c:if test="${date.year != vo.wdate.year || date.month != vo.wdate.month || 
				date.date != vo.wdate.date}">
				<fmt:formatDate value="${vo.wdate}" pattern="yyyy.MM.dd(E)"/>
			</c:if>
		</td>
		<td>${vo.hit}</td>
	</tr>
	<tr>
		<td>제목</td>
		<td colspan="3">
			<input type="text" name="title" value="${vo.title}" size="50"/>
			공지글
			<c:if test="${fn:trim(vo.notice) == 'notice'}">
				<input type="checkbox" name="notice" checked="checked"/>
			</c:if>
			<c:if test="${fn:trim(vo.notice) != 'notice'}">
				<input type="checkbox" name="notice" value="notice"/>
			</c:if>
		</td>
	</tr>
	<tr>
		<td>내용</td>
		<td colspan="3">
			<textarea rows="10" cols="50" name="content">${vo.content}</textarea>
		</td>
	</tr>
	<tr>

		<td colspan="4" align="center">
			비밀번호<input type="password" name="password" />
			<input type="submit" class="btn btn-default" value="수정하기"/>
			<input type="reset" class="btn btn-default" value="다시쓰기"/>
			<input type="button" class="btn btn-default " value="돌아가기" 
				onclick="location.href='view?idx=${vo.idx}&currentPage=${currentPage}'">
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>
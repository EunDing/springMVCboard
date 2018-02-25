<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>			<!-- jstl 제어문 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>		<!-- jstl 서식 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>	<!-- jstl 함수 -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 보기</title>
<link rel="stylesheet" href="resources/util/bootstrap.css"/>
<link rel="stylesheet" href="resources/bootstrap-responsive.css"/>
<link href="https://fonts.googleapis.com/css?family=Lobster" rel="stylesheet">
<script src="http://code.jquery.com/jquery.js"></script>
<script src="resources/util/bootstrap.js"></script>
</head>
<style>
body { background-image : url("./images/firenze2.jpg");  background-repeat : no-repeat; background-size:cover; background-position: top right;  background-attachment: fixed;}
.bg{background : #FFF0F5;}
.title{background-image : url("./images/firenze5.jpg"); }
.titleh{height:50px;}
.table th {
   text-indent:6em; font-size:45px; padding:20px; color: brown; border-left: 0;
   font-family: 'Nanum Pen Script', cursive;
}
.table td {
   text-align: center;  
}
.maintable{background : #FFF0F5;}
 .select {text-align : right;} 
 .noticebg{ background : #FFB4B4;}
 .btn { font-weight:bold; }
 .backimg { border-right:0;}
 .backimg img {  width: 40px; height:35px; margin-top: 15px;}
</style>
<body>
<div class="container">
<table width="800" align="center" border="1" cellspacing="5" align="center" class="table table-bordered table-condensed bg ">
		
		<tr class="title titleh" >
		<td class="backimg"><img src="./images/re.png" style="cursor:pointer"
		onclick="location.href='main'" /></td>
			<th colspan="5">펠리치타로마</th>
		</tr>
		<tr class="title">
			<td colspan="5" align="right">
				${list.totalCount}개(${list.currentPage}/${list.totalPage}page)</td>
		</tr>
		
		<tr class="title">
			<td width="80" align="center">글번호</td>
			<td width="100" align="center">작성자</td>
			<td width="420" align="center">제목</td>
			<td width="120" align="center">작성일</td>
			<td width="80" align="center">조회수</td>
		</tr>

<jsp:useBean id="date" class="java.util.Date"/>
<!-- 공지글을 출력한다 -->
<c:forEach var="vo" items="${notice}">
		<tr align="center" class="noticebg"  >
			<td align="center"><img src="./images/notice.png"></td>
			<td align="center">
				<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"/>
				<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"/>
				${name}
			</td>
			
			<td>
				<c:if test="${vo.lev > 0}">
						<c:forEach var="i" begin="0" end="${vo.lev}" step="1">	
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach>
						<img src="./images/re.png" width="10" height="10"/>
				</c:if>
				<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;')}"/>
					<c:set var="title" value="${fn:replace(title, '>', '&gt;')}"/>
					<c:set var="title" value="${fn:replace(title, rn, '<br/>')}"/>
					<a href="increment?idx=${vo.idx}&currentPage=${list.currentPage}">${title}</a>(${vo.replyCount})
					
				<!-- HOT -->
				<c:if test="${vo.hit >= 5}">
					<img src="./images/hot.gif"/>
				</c:if>
				
				<!-- NEW -->
				<c:if test="${date.year == vo.wdate.year && date.month == 
						vo.wdate.month && date.date == vo.wdate.date}">
						<img src="./images/new.png"/>
				</c:if>
			</td>
			
				<td>
					<c:if test="${date.year == vo.wdate.year && date.month == 
						vo.wdate.month && date.date == vo.wdate.date}">
						<fmt:formatDate value="${vo.wdate}" pattern="HH:mm:ss" />
					</c:if> 
					<c:if test="${date.year != vo.wdate.year || 
						date.month != vo.wdate.month ||	date.date != vo.wdate.date}">
					<fmt:formatDate value="${vo.wdate}" pattern="yyyy.MM.dd(E)" />
					</c:if>
				</td>
				
				<td>${vo.hit}</td>
			</tr>

		</c:forEach>
			
	<!-- 게시글이 없으면	 -->
	<c:if test="${list.totalCount == 0}">
		<tr><td align="center" colspan="5"><marquee>글이 없습니다.</marquee></td></tr>
	</c:if>
	

<c:if test="${list.totalCount != 0}">
	<!-- 화면에 표시되는 메인 글의 일련번호를 끝어지지 않게하기 위해 산수를... -->
	<c:set var="no" value="${list.totalCount - (list.currentPage -1) * list.pageSize}"/>

	<!-- 메인글을 출력한다 -->
		<c:forEach var="vo" items="${list.list}">	
			<tr align="center" class="maintable">
				
			<%-- <td>${vo.idx}</td> --%>
				<td>${no}</td>
				<c:set var="no" value="${no - 1}"/>
				
				<td>
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}" /> 
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}" /> 
					${name}
				</td>
				
			<td>
				<c:if test="${vo.lev > 0}">
						<c:forEach var="i" begin="1" end="${vo.lev}" step="1">	
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						</c:forEach>
						<img src="./images/re.png" width="10" height="10"/>
				</c:if>
				
				<c:set var="title" value="${fn:replace(vo.title, '<', '&lt;')}"/>
					<c:set var="title" value="${fn:replace(title, '>', '&gt;')}"/>
					<c:set var="title" value="${fn:replace(title, rn, '<br/>')}"/>
					<a href="increment?idx=${vo.idx}&currentPage=${list.currentPage}">${title}</a>(${vo.replyCount})
					
				<!-- HOT -->
				<c:if test="${vo.hit >= 5}">
					<img src="./images/hot.gif"/>
				</c:if>
				
				<!-- NEW -->
				<c:if test="${date.year == vo.wdate.year && date.month == 
						vo.wdate.month && date.date == vo.wdate.date}">
						<img src="./images/new.png"/>
				</c:if>
			</td>
				
				<td>
					<c:if test="${date.year == vo.wdate.year && date.month == 
						vo.wdate.month && date.date == vo.wdate.date}">
						<fmt:formatDate value="${vo.wdate}" pattern="HH:mm:ss" />
					</c:if> 
					<c:if test="${date.year != vo.wdate.year || 
						date.month != vo.wdate.month ||	date.date != vo.wdate.date}">
					<fmt:formatDate value="${vo.wdate}" pattern="yyyy.MM.dd(E)" />
					</c:if>
				</td>
				
				<td>${vo.hit}</td>
			</tr>

		</c:forEach>
		</c:if>
		
		
		<tr>
		<td style="border : 0px" colspan="5" align="center">
		<!-- startPage가 1 보다 크다면 이전 10 페이지가 있다. -->
		<c:if test="${list.startPage > 1}">
			<input type="button" value="start" onclick="location.href='?currentPage=1'"/>
			<input type="button" value="-10" onclick="location.href='?currentPage=${list.startPage - 1}'"/>
		</c:if>
		
		<c:if test="${list.startPage <= 1}">
			<input type="button" value="start" class="btn btn-default " disabled="disabled"/>
			<input type="button" value="-10" class="btn btn-default " disabled="disabled"/>
		</c:if>
		

		<!-- currentPage가 1 보다 크다면 이전 페이지가 있다. -->
		<c:if test="${list.currentPage > 1}">
			<input type="button" value="-1" class="btn btn-default"
					onclick="location.href='list?currentPage=${list.currentPage - 1}'"/>
		</c:if>
		
		<c:if test="${list.currentPage <= 1}">
			<input type="button" value="-1" class="btn btn-default" disabled="disabled"/>
		</c:if>
		
		<!-- 10 페이지 단위로 페이지 이동 버튼 표시하기 -->
		<%-- ${free.startPage}&nbsp;${free.endPage}<br/> --%>
		<c:forEach var="i" begin="${list.startPage}" end="${list.endPage}" step="1">
			<c:if test="${list.currentPage == i}">
				<input type="button" value="${i}" class="btn btn-default" disabled="disabled"/>
			</c:if>
			<c:if test="${list.currentPage != i}">
				<input type="button" value="${i}" class="btn btn-default" onclick="location.href='list?currentPage=${i}'"/>
			</c:if>
		</c:forEach>
		

		<!-- currentPage가 totalPage 보다 작다면 다음 페이지가 있다. -->
		<c:if test="${list.currentPage < list.totalPage}">
			<input type="button" value="+1" class="btn btn-default"
					onclick="location.href='list?currentPage=${list.currentPage + 1}'"/>
		</c:if>
		
		<c:if test="${list.currentPage >= list.totalPage}">
			<input type="button" value="+1" class="btn btn-default" disabled="disabled"/>
		</c:if>
		
		<!-- endPage가 totalPage 보다 작다면 다음 10 페이지가 있다. -->
		<c:if test="${list.endPage < list.totalPage}">
			<input type="button" value="+10" class="btn btn-default"
					onclick="location.href='list?currentPage=${list.endPage + 1}'"/>
			<input type="button" value="end" class="btn btn-default"
					onclick="location.href='list?currentPage=${list.totalPage}'"/>
		</c:if>
		
		<c:if test="${list.endPage >= list.totalPage}">
			<input type="button" class="btn btn-default " value="+10" disabled="disabled"/>
			<input type="button" class="btn btn-default " value="end" disabled="disabled"/>
		</c:if>

</td>
</tr>
	
		<!-- 카테고리별 검색어를 입력받는다. -->
<tr>
		<td style="border : 0px" colspan="5" align="right">
			<form action="list.jsp" method="post" class="select">
				<select name="category">
					<option>이름</option>
					<option selected ="selected">내용</option>
					<option>이름+내용</option>
				</select>
				<input type="text" name="item" value="${item}"/>
				<input type="submit" value="검색"  class="btn btn-default" name="search"/>
			</form>
		</td>
	</tr>
	
<tr>
		<td style="border : 0px"  colspan="5" align="right">
			<a class="btn btn-default pull-right"
			onclick="location.href='insert?currentPage=${list.currentPage}'">
			글쓰기</a>
		</td>
</tr>
</table>
</div>	

</body>
</html>







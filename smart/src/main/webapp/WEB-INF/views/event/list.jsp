<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
	prefix="c" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#list-top{ 
	width: 80%; 
	padding-left: 10%; 
	padding-bottom: 30px;
}
table {
	table-layout: fixed;
}
table tr:nth-of-type(n+2) td:nth-of-type(2) {
	text-overflow: ellipsis; 
	overflow: hidden; 
	white-space: nowrap;
}
</style>
</head>
<body>
<h3>행사안내 목록</h3>

<form id="list" method="post">
<input type="hidden" name="curPage" value="1" />
<input type="hidden" name="id" />
<input type="hidden" name="read" value="false"/>
<p id="list-top">
	<span style="float:left;">
		<select name="search">
			<option ${page.search eq 'all' ? 'selected' : ''}  value="all">전체</option>
			<option ${page.search eq 'title' ? 'selected' : ''} value="title">제목</option>
			<option ${page.search eq 'content' ? 'selected' : ''} value="content">내용</option>
			<option ${page.search eq 'writer' ? 'selected' : ''} value="writer">작성자</option>
		</select>
		<input type="text" name="keyword" value="${page.keyword}"
			style="width:350px; vertical-align: top;"/>	
		<a onclick="$('form').submit()" class="btn-fill">검색</a>
	</span>
	<!-- 로그인한 경우 글쓰기 가능 -->
	<c:if test="${ !empty login_info }">
		<a onclick="location='new.ev'" style="float:right;" class="btn-fill">글쓰기</a>
	</c:if>	
</p>
</form>

<table>
<tr><th style="width:60px;">번호</th>
	<th>제목</th>
	<th style="width:100px;">작성자</th>
	<th style="width:100px;">작성일자</th>
	<th style="width:80px;">첨부파일</th>	
</tr>

<c:forEach items="${page.list}" var="vo">
<tr><td>${vo.no}</td>
	<td class="left"><a onclick="go_detail(${vo.id})">[${vo.comments}] ${vo.title}</a></td>
	<td>${vo.name}</td>
	<td>${vo.writedate}</td>
	<td>${empty vo.filename ? ""
		: "<img class='btn-img' src='img/attach.png'/>"}</td>
</tr>
</c:forEach>

</table><br>
<script type="text/javascript">
function go_detail(id){
	$('[name=id]').val(id);	
	$('[name=read]').val(true);
	$('#list').attr( 'action', 'detail.ev');
	$('#list').submit();
}
</script>
<jsp:include page="/WEB-INF/views/include/page.jsp" />
</body>
</html>
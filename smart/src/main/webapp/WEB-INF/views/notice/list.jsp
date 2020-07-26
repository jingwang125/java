<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
#list-top{ width: 80%; padding-left: 10%; padding-bottom: 30px;}
select {
	height: 28px; width: 90px;
}
</style>

</head>
<body>
<h3>공지글 목록</h3>

<form id="list" method="post">
	<input type="hidden" name="curPage" value="1"/>
	<input type="hidden" name="id"/>
		<p id="list-top">
			<span style="float: left;">
				<select name="search">
					<option value="all" ${page.search eq 'all' ? 'selected' : '' }>전체</option>				
					<option value="title" ${page.search eq 'title' ? 'selected' : '' }>제목</option>				
					<option value="content" ${page.search eq 'content' ? 'selected' : '' }>내용</option>				
					<option value="writer" ${page.search eq 'writer' ? 'selected' : '' }>작성자</option>				
				</select>
				<input type="text" name="keyword" value="${page.keyword }" style="width: 350px; vertical-align: top;"/>
				<a class="btn-fill" onclick="$('form').submit()">검색</a>			
			</span>
			
		<!--관리자로 로그인 한 경우 글쓰기 가능 -->
		<c:if test="${login_info.admin eq 'Y' }">
			<a class="btn-fill" style="float: right;" onclick="location='new.no'">글쓰기</a>
		</c:if>
		
		</p>
</form>

<table>
<tr>
	<th style="width: 60px">번호</th>
	<th>제목</th>
	<th style="width: 100px">작성자</th>
	<th style="width: 100px">작성일자</th>
	<th style="width: 80px">첨부파일</th>
</tr>

<c:forEach items="${page.list }" var="vo">
<tr>
	<td>${vo.no }</td>
	<td class="left"><a onclick="go_detail(${vo.id})">${vo.title }</a></td>
	<td>${vo.writer }</td>
	<td>${vo.writedate }</td>
	<td>${!empty vo.filename ? "<img class='btn-img' src='img/attach.png' />" : "" }</td>
</tr>
</c:forEach>

</table><br>
<script type="text/javascript">
function go_detail(id){
	$('[name=id]').val(id);
	$('#list').attr('action', 'detail.no');	//form 태그의 action 속성지정
	$('#list').submit();
}
</script>
<jsp:include page="/WEB-INF/views/include/page.jsp"/>

</body>
</html>
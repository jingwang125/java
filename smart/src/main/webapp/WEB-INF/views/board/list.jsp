<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>게시글 목록</h3>

<form id="list" method="post">
	<input type="hidden" name="curPage" value="1"/>
	
	<p id="list-top" style="width: 80%">
		<span style="float: left;">
			<select name="search">
				<option ${page.search eq 'all' ? 'selected' : '' } value="all">전체</option>
				<option ${page.search eq 'title' ? 'selected' : '' }  value="title">제목</option>
				<option ${page.search eq 'content' ? 'selected' : '' } value="content">내용</option>
				<option ${page.search eq 'writer' ? 'selected' : '' }  value="writer">작성자</option>
			</select>
				<input type="text" name="keyword" value="${page.keyword }"/>
				<a class="btn-fill" onclick="$('form').submit()">검색</a>
		</span>
	<!-- 로그인 된 경우만 글쓰기 가능 -->
		<c:if test="${ !empty login_info }">
			<a class="btn-fill" style="float: right;" onclick="location='new.bo'">글쓰기</a>
		</c:if>
	</p>
	<input type="hidden" name="id"/>
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
	<td class="left">
		<c:forEach var="i" begin="1" end="${vo.indent }">
			${ i eq vo.indent ? '<img src="img/re.gif"/>' : '&nbsp;&nbsp;' }
		</c:forEach>
			<a onclick="go_detail(${vo.id})">${vo.title }</a></td>
	<td>${vo.userid }</td>
	<td>${vo.writedate }</td>
	<td>${empty vo.filename ? '' : '<img class="btn-img" src="img/attach.png"/>' }</td>
</tr>
</c:forEach>
</table><br>

<script type="text/javascript">
function go_detail(id){
	$('[name=id]').val(id);
	$('#list').attr('action', 'detail.bo');
	$('#list').submit();
}
</script>
<jsp:include page="/WEB-INF/views/include/page.jsp"></jsp:include>
</body>
</html>
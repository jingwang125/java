<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table tr:nth-child(2) th:nth-child(2), table tr:nth-child(2) td:nth-child(2) {
	width: 100px; }
table tr:nth-child(2) th:nth-child(3), table tr:nth-child(2) td:nth-child(3){ 
	width: 80px; }
</style>
</head>

<script type="text/javascript">
$(function(){
	$('table tr:eq(1) th:eq(1), table tr:eq(1) td:eq(1)').css('width', '100px');
 	$('table tr:eq(1) th:eq(2), table tr:eq(1) td:eq(2)').css('width', '80px');
});
</script>
<body>
<h3>공지글 안내</h3>
<table>
<tr>
	<th style="width:120px">제목</th>
		<td class="left" colspan="5">${vo.title }</td>
</tr>
<tr>
	<th>작성자</th>
		<td>${vo.writer }</td>
	<th>작성일자</th>
		<td>${vo.writedate }</td>
	<th>조회수</th>
		<td>${vo.readcnt}</td>
</tr>
<tr>
	<th>내용</th>
		<td class="left" colspan="5">${fn: replace(vo.content, lf, '<br>') }</td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left" colspan="5">${vo.filename }
			${empty vo.filename ? '' : '<img class="btn-img" id="download" src="img/download.png" />' }
		</td>
</tr>
</table><br>
<a class="btn-fill" onclick="go_list()">목록으로</a>

<!-- 관리자로 로그인 했을 때만 수정/삭제 가능 -->
<c:if test="${login_info.admin eq 'Y' }">
<a class="btn-fill" onclick="go_modify()">수정</a>
<a class="btn-fill" onclick="if( confirm('정말 삭제?') ){location='delete.no?id=${vo.id}' }">삭제</a>
</c:if>

<form method="post" action="list.no">
	<input type="hidden" name="id" value="${vo.id}"/>
	<input type="hidden" name="curPage" value="${page.curPage }"/>
	<input type="hidden" name="search" value="${page.search }"/>
	<input type="hidden" name="keyword" value="${page.keyword}"/>
</form>
<script type="text/javascript">
$('#download').click(function(){
	location="download.no?id=${vo.id}";
});

function go_list(){
	$('form').submit();
}

function go_modify(){
	$('form').attr('action', 'modify.no');
	$('form').submit();
}
</script>

</body>
</html>
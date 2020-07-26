<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#attach-file, #delete-file {
	display: none;
}
</style>
</head>
<body>
<h3>답글쓰기</h3>

<form method="post" action="reply_insert.bo" enctype="multipart/form-data">
<table>
<tr>
	<th>제목</th>
		<td><input type="text" name="title" style="width: 98%" class="need" title="제목"/></td>
</tr>
<tr>
	<th>작성자</th>
		<td class="left">${login_info.name }</td>
</tr>
<tr>
	<th>내용</th>
		<td><textarea name="content" style="width: 99%; height: 100px;" class="need" title="내용"></textarea></td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left">
			<img class="btn-img" src="img/delete.png" id="delete-file" />
			<label id="file-name"></label>
			<label>
				<img class="btn-img" src="img/select.png"/>
				<input type="file" name="file" id="attach-file"/>
			</label>
		</td>
</tr>
</table><br>

<a class="btn-fill" onclick="if( checkInput() ){ $('form').submit() }">저장</a>
<a class="btn-empty" onclick="$('form').attr('action', 'detail.bo'); $('form').submit()">취소</a>

<!-- 원글정보 -->
<input type="hidden" name="id" value="${vo.id }"/>
<input type="hidden" name="root" value="${vo.root }"/>
<input type="hidden" name="step" value="${vo.step }"/>
<input type="hidden" name="indent" value="${vo.indent }"/>

</form>

<script type="text/javascript" src="js/nullCheck.js"></script>


</body>
</html>
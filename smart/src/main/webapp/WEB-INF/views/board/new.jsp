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
<h3>신규 게시글 작성</h3>

<form method="post" action="insert.bo" enctype="multipart/form-data">
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
<a class="btn-empty" onclick="location='list.bo'">취소</a>
</form>

<script type="text/javascript" src="js/nullCheck.js"></script>
<script type="text/javascript">
$(function(){
	$('#attach-file').change(function(){
		$('#file-name').text( this.files[0].name );
		$('#file-name').css('padding-right', '20px');
		$('#delete-file').css('display', 'inline-block');
	});
	
	$('#delete-file').click(function(){
		$('#file-name').text('');	//보여지는 부분 초기화
		$('#attach-file').val('');	//값을 초기화
		$('#file-name').css('padding-right', '0px');
		$('#delete-file').css('display', 'none');
	});
});
</script>
</body>
</html>
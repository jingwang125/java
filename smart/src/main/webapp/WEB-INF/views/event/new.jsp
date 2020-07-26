<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>행사안내 작성</h3>
<form enctype="multipart/form-data" method="post" action="insert.ev">
<table>
<tr><th style="width:120px;">제목</th>
	<td><input title="제목" class="need" style="width:98%" type="text" name="title" /></td>
</tr>
<tr><th>작성자</th>
	<td class="left">${login_info.name}</td>
</tr>
<tr><th>내용</th>
	<td><textarea title="내용" class="need" name="content" 
		style="width:98.5%; height:100px;"></textarea> </td>
</tr>
<tr><th>첨부파일</th>
	<td class="left">
		<img id="delete-file" style="display:none" class="btn-img" src="img/delete.png" />
		<label id="file-name"></label>
		<label>
			<img class="btn-img" src="img/select.png" />	
			<input id="attach-file" style="display:none" type="file" name="file" />
		</label>
	</td>
</tr>

</table><br>
<a onclick="if( checkInput() ){ $('form').submit() }" class="btn-fill">저장</a>
<a onclick="location='list.ev'" class="btn-empty">취소</a>
</form>

<script type="text/javascript" src="js/nullCheck.js"></script>
<script type="text/javascript">
$('#attach-file').change(function(){
	display(true, this.files[0].name);
});

$('#delete-file').click(function(){
	display(false, "");
});

function display(attach, filename){
	$('#delete-file').css('display', attach ? 'inline-block':'none');
	$('#file-name').css('padding-right', attach ? '20px' : '0px');
	$('#file-name').text( attach ? filename : '');
	if( !attach )	$('#attach-file').val('');
}

</script>
</body>
</html>


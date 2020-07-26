<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>공지글 작성</h3>

<form method="post" action="insert.no" enctype="multipart/form-data">
<table>
<tr>
	<th style="width: 120px;">제목</th>
		<td><input style="width: 98%" type="text" name="title" class="need" title="제목"/></td>
</tr>
<tr>
	<th>작성자</th>
		<td class="left">${login_info.name }</td>
</tr>
<tr>
	<th>내용</th>
		<td><textarea style="width: 98.5%; height: 100px;" name="content" class="need" title="내용"></textarea></td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left">
			<img style="display: none" src="img/delete.png" class="btn-img" id="delete-file"/>
			<label id="file-name"></label>
			<label>
				<img src="img/select.png" class="btn-img"/>
				<input style="display: none" type="file" name="file" id="attach-file"/>
			</label>
		</td>
</tr>
</table><br>
<a class="btn-fill" onclick="if( checkInput() ){ $('form').submit() }">저장</a>
<a class="btn-empty" onclick="location='list.no'">취소</a>
</form>

<script type="text/javascript" src="js/nullCheck.js"></script>
<script type="text/javascript">
$('#attach-file').change(function(){
	$('#file-name').text( this.files[0].name );
	//첨부파일 선택한 경우 파일삭제버튼 보이게
	$('#delete-file').css('display', 'inline-block');	//display:none 이었던걸 보이게 inline-block처리
	
	$('#file-name').css('padding-right', '20px');
});

//첨부파일 삭제 이미지 버튼 눌렀을때 처리
$('#delete-file').click(function(){
	$('#file-name').text('');
	$('#file-name').css('padding-right', '0px');
	$('#attach-file').val('');	//file태그에 대한 data 없애기(보여지는 부분에 대한)
	$('#delete-file').css('display', 'none');	//첨부파일 삭제 이미지 버튼 다시 숨기기
});

</script>

</body>
</html>
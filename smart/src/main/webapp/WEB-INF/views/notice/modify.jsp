<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
input[name=title]{ width: 98%}
textarea[name=content]{ width: 99%; height: 100px;}
#attach-file { display: none; }
#file-name{ padding-right: 20px; }
</style>
<script type="text/javascript">
$(function(){
	$('table tr:eq(1) th:eq(1), table tr:eq(1) td:eq(1)').css('width', '150px');
	
	$('#attach-file').change(function(){
		$('#file-name').text(this.files[0].name);
		$('#file-name').css('padding-right', '20px');
		$('#delete-file').css('display', 'inline-block');
	});
	
	$('#delete-file').click(function(){
		$('#file-name').text('');
		$('#attach-file').val('');
		$('#file-name').css('padding-right', '0px');
		$('#delete-file').css('display', 'none');
		$('[name=attach]').val(0);	//delete 그림을 누르면 파일 첨부하지 않겠다
	});
	
	if( ${!empty vo.filename} ){
		$('file-name').css('padding-right', '20px');
		$('#delete-file').css('display', 'inline-block');
	}else {
		$('#file-name').css('padding-right', '0px');
		$('#delete-file').css('display', 'none');
	}
})

</script>
</head>
<body>
<h3>공지글 안내 수정</h3>
<form method="post" action="update.no" enctype="multipart/form-data">	<!-- enctype="multipart/form-data" : 첨부파일 submit 보내기위해 -->
<table>
<tr>
	<th style="width: 120px;">제목</th>
		<td class="left" colspan="3"><input type="text" class="need" title="제목" name="title" value="${vo.title }" /></td>
</tr>
<tr>
	<th>작성자</th>
		<td class="left">${vo.writer }</td>
	<th>작성일자</th>
		<td>${vo.writedate }</td>
</tr>
<tr>
	<th>내용</th>
		<td class="left" colspan="3"><textarea name="content" class="need" title="내용">${vo.content }</textarea></td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left" colspan="3">
			<img src="img/delete.png" class="btn-img" id="delete-file"/>
			<label id="file-name">${vo.filename }</label>
			<label>
				<img class="btn-img" src="img/select.png"/>
				<input id="attach-file" type="file" name="file"/>
			</label>
		</td>
</tr>
</table><br>

<a class="btn-fill" onclick="if( checkInput() ){ $('form').submit() }">저장</a>
<a class="btn-empty" onclick="go_detail()">취소</a>
<input type="hidden" name="id" value="${vo.id }"/>
<input type="hidden" name="attach" value="1"/>

</form>
<script type="text/javascript" src="js/nullCheck.js"></script>
<script type="text/javascript">
function go_detail(){
	$('form').attr('action', 'detail.no');	//form 태그 속성이 update로 가게 되어있기 때문에 detail로 가게 하는 처리
	$('form').submit();
}
</script>
</body>
</html>
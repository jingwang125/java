<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
input[name=title]{	
	width:98%
}	
textarea[name=content]{
	width: 99%; height:100px; 
}
#delete-file, #attach-file {
	display: none;
}
</style>
</head>
<body>
<h3>행사안내 수정</h3>
<form enctype="multipart/form-data" method="post" action="update.ev">
<table>
<tr><th style="width:120px">제목</th>
	<td class="left" colspan="5"><input 
		type="text" name="title" value="${vo.title}"/></td>
</tr>
<tr><th>작성자</th>
	<td>${vo.name}</td>
	<th style="width:100px">작성일자</th>
	<td style="width:100px">${vo.writedate}</td>
	<th style="width:70px">조회수</th>
	<td style="width:70px">${vo.readcnt}</td>
</tr>
<tr><th>내용</th>
	<td class="left" 
		colspan="5"><textarea name="content">${vo.content}</textarea></td>
</tr>
<tr><th>첨부파일</th>
	<td class="left" colspan="5">
		<img id="delete-file" src="img/delete.png" class="btn-img" />
		<label id="file-name">${vo.filename}</label>
		<label>
			<img src="img/select.png" class="btn-img" />
			<input id="attach-file"  type="file" name="file"/>
		</label>
	</td>
</tr>
</table><br>
<input type="hidden" name="delete" value="0"/>
<input type="hidden" name="id" value="${vo.id}" />
<a class="btn-fill" onclick="$('form').submit()">저장</a>
<a class="btn-empty" 
	onclick="$('form').attr('action', 'detail.ev'); $('form').submit()">취소</a>
</form>

<script type="text/javascript">
$(function(){
	if( ${ !empty vo.filename} ){
		display(true, '${vo.filename}');
	}
	
	$('#attach-file').change(function(){
		display(true, this.files[0].name);
	});
	
	$('#delete-file').click(function(){
		$('[name=delete]').val(1);
		display(false, this);
	});
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





<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
input[name=title]{
	width: 98%;
}
textarea[name=content]{
	width: 99%;
	height: 100px;
}
#delete-file, #attach-file{
	display: none;
}
</style>
</head>
<body>
<h3>게시글 수정</h3>
<form method="post" action="update.bo" enctype="multipart/form-data">
<table>
<tr>
	<th style="width: 120px">제목</th>
		<td class="left" colspan="5"><input type="text" name="title" value="${vo.title }"/></td>
</tr>
<tr>
	<th>작성자</th>
		<td>${vo.writer }</td>
	<th style="width: 100px">작성일자</th>
		<td style="width: 100px">${vo.writedate }</td>
	<th style="width: 70px">조회수</th>
		<td style="width: 70px">${vo.readcnt }</td>
</tr>
<tr>
	<th>내용</th>
		<td class="left" colspan="5"><textarea name="content">${vo.content}</textarea></td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left" colspan="5">
			<img id="delete-file" src="img/delete.png" class="btn-img"/>
			<label id="preview"></label>
			<label id="file-name">${vo.filename }</label>
			<label>
				<img src="img/select.png" class="btn-img"/>
				<input id="attach-file" type="file" name="file"/>
			</label>
		</td>
</tr>
</table><br>
<input type="hidden" name="delete" value="0" />
<input type="hidden" name="id" value="${vo.id }"/>
<a class="btn-fill" onclick="$('form').submit()">저장</a>
<a class="btn-empty" onclick="$('form').attr('action', 'detail.bo'); $('form').submit()">취소</a>
</form>

<script type="text/javascript">
$(function(){
	if( ${ !empty vo.filename} ){
		whenFileSelected(1);
		showAttachedImage('${vo.filename}');
	}
	
	$('#attach-file').change(function(){
		$('#file-name').text( this.files[0].name );
		whenFileSelected(1);
		attachImage(this);
	});
	
	function attachImage(img){
		console.log(img, '\t', img.files);
		//input file 태그의 선택한 파일정보 확인
		if( img.files && img.files[0] ){	//0번지에 파일 name이
			if( isImage(img.files[0].name) ){		//img이면
				makePreviewImageTag('');		//이미지 태그 만드는 함수 호출
				var reader = new FileReader();		//img 태그를 만들어 보여지게 처리
				reader.onload = function(e){			//객체를 읽어오면
					$('#preview-img').attr('src', e.target.result);	//넣는 처리
				}
				reader.readAsDataURL(img.files[0]);		//선택한 파일정보를 읽어온다
			}else	$('#preview').html('');
			
		}
	}
	
	$('#delete-file').click(function(){
		$('[name=delete]').val(1);	//첨부파일도 삭제하는 처리
		$('#file-name').text('');
		$('#attach-file').val('');
		whenFileSelected(0);
		$('#preview').html('');
	});
	
	function showAttachedImage(filename){
		if( isImage(filename) ){
			var path = '${fn:replace(vo.filepath, "\\", "/")}';
			makePreviewImageTag(path);
		}
	}
});

function whenFileSelected(mode){
		$('#file-name').css('padding-right', mode==0 ? '0px' : '20px');
		$('#delete-file').css('display', mode==0 ? 'none' : 'inline-block');
}

function isImage(filename){	//이미지일 경우 처리
	var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase();
	var imgs = ['jpg', 'jpeg', 'bmp', 'gif', 'png'];
	if( imgs.indexOf(ext) >-1 ) return true;
	else false;
}

function makePreviewImageTag(path){
	var img = "<img id='preview-img' class='btn-img' style='border-radius:50%' src='<c:url value="/"/>" + path + "'/>";
	$('#preview').html(img);
}
</script>

</body>
</html>
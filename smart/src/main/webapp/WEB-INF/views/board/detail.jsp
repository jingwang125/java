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
.popup-img{
	width: 100%; height: 100%;
	border-radius: 50%;
}
#popup{
	position: absolute;
	width: 500px; height: 500px;
	left: 50%; top: 50%; transform : translate(-50%, -50%);
	border: 3px solid #666;
	display: none;
	z-index: 99999;
	border-radius: 100%;
}
#popup-background{
	position: absolute;
	width: 100%; height: 100%;
	left: 0; top: 0;
	background-color: #000; opacity: 0.2;
	display: none;
}
</style>
</head>
<body>
<h3>게시글 안내</h3>
<table>
<tr>
	<th style="width: 120px">제목</th>
		<td class="left" colspan="5">${vo.title }</td>
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
		<td class="left" colspan="5">${fn: replace(vo.content, crlf, '<br>') }</td>
</tr>
<tr>
	<th>첨부파일</th>
		<td class="left" colspan="5">
			<label id="preview"></label>
				${vo.filename }
			<c:if test="${!empty vo.filename }">
				<img src="img/download.png" class="btn-img" onclick="location='download.bo?id=${vo.id}'"/>
			</c:if>
		</td>
</tr>
</table><br>

<a class="btn-fill" onclick="$('#detail').submit()">목록으로</a>

<!-- 로그인 된 경우만 답글작성 가능 -->
<c:if test="${ !empty login_info }" >
<a class="btn-fill" onclick="$('#detail').attr('action', 'reply.bo'); $('#detail').submit()">답글작성</a>
</c:if>

<!-- 로그인한 사용자가 작성한 글만 수정/삭제 가능 -->
<c:if test="${login_info.userid eq vo.userid}">
<a class="btn-fill" onclick="$('#detail').attr('action', 'modify.bo'); $('#detail').submit()">수정</a>
<a class="btn-fill" onclick="if( confirm('정말 삭제?') ){ location='delete.bo?id=${vo.id}' }">삭제</a>
</c:if>

<form id="detail" action="list.bo" method="post">	<!-- 다른 페이지에서 detail 보다가 목록으로 버튼 눌렀을 때 보던 페이지로 가는 처리-->
	<input type="hidden" name="id" value="${vo.id }" />
	<input type="hidden" name="curPage" value="${page.curPage }" />
	<input type="hidden" name="search" value="${page.search }" />
	<input type="hidden" name="keyword" value="${page.keyword }" />

</form>

<script type="text/javascript">
$(function(){
	if( ${ !empty vo.filename} ){
		showAttachedImage('${vo.filename}', 'preview');	//첨부된 이미지를 보여지게
	}
	//ab.c.jpg, abd.hwp
	function showAttachedImage(filename, tag){
		var ext = filename.substring( filename.lastIndexOf('.')+1 ).toLowerCase();	//.의 다음위치부터
		var imgs = [ 'jpg', 'png', 'jpeg', 'bmp', 'gif', 'svg' ];
		if( imgs.indexOf(ext) > -1 ){
			var path = '${fn:replace(vo.filepath, "\\", "/")}'		// \과 /이 섞여있어 \를 /로 바꾸는 처리
			var img = '<img class="' + (tag=== 'preview' ? 'btn-img' : 'popup-img') + '" id="preview-img" src="<c:url value='/'/>' + path + '"/>';
// 			console.log(path);
			$('#' + tag).html(img);
			console.log(img);
		}
// 		console.log('${vo.filepath}');
	}
	
	$('#preview-img').click(function(){
		$('#popup, #popup-background').css('display', 'block');
		showAttachedImage('${vo.filename}', 'popup');
	});
});
</script>
<div id="popup"></div>
<div id="popup-background" onclick="$('#popup, #popup-background').css('display', 'none');"></div>
</body>
</html>
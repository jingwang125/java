<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" 
	prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" 
	prefix="c" %>  
	  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#comment-regist{
	text-align: center;
	margin: 0 auto;
	width: 500px;
}
#comment-regist div { width: 50%; float: left;}
#comment-regist  textarea { margin-top: 5px;}
</style>
</head>
<script type="text/javascript">
$(function(){
	$('table tr:eq(1) th:eq(1), table tr:eq(1) td:eq(1)').css('width', '100px');
	$('table tr:eq(1) th:eq(2), table tr:eq(1) td:eq(2)').css('width', '80px');
	comment_list();	//화면 처음 떴을때도 댓글 목록이 보여지게 처리
});

</script>
<body>
<h3>행사 안내</h3>
<table>
<tr><th style="width:120px;">제목</th>
	<td colspan="5" class="left">${vo.title}</td>
</tr>
<tr><th>작성자</th>
	<td>${vo.name}</td>
	<th>작성일자</th>
	<td>${vo.writedate}</td>
	<th>조회수</th>
	<td>${vo.readcnt}</td>
</tr>
<tr><th>내용</th>
	<td colspan="5" class="left">${fn: replace(vo.content, crlf, '<br>')}</td>
</tr>
<tr><th>첨부파일</th>
	<td colspan="5" class="left">${vo.filename}
		${empty vo.filename ? '' 
		: '<img id="download" class="btn-img" src="img/download.png" />' }
				
	</td>
</tr>

</table><br>
<a class="btn-fill" onclick="go_list()">목록으로</a>

<!-- 로그인한 사용자가 작성한 글만 수정/삭제 가능 -->
<c:if test="${login_info.userid eq vo.userid }">
<a class="btn-fill" onclick="go_modify()">수정</a>
<a class="btn-fill" onclick="if( confirm('정말 삭제?') ) { location='delete.ev?id=${vo.id}' }">삭제</a>
</c:if>

<form method="post" action="list.ev">
	<input type="hidden" name="id" value="${vo.id}"/>
	<input type="hidden" name="curPage" value="${page.curPage}"/>
	<input type="hidden" name="search" value="${page.search}" />
	<input type="hidden" name="keyword" value="${page.keyword}" />
</form><br>
<div id="comment-regist">
	<div class="left"><strong>댓글작성</strong></div>
	<div class="right"><a class="btn-fill-s" onclick="go_comment_regist()">등록</a></div>
	<textarea id="comment" style="width: 99%; height: 50px"></textarea>
</div>
<div id="comment-list" style="text-align: left; margin: 0 auto; width: 500px;"></div>

<script type="text/javascript">
function go_modify(){
	$('form').attr('action', 'modify.ev');
	$('form').submit();
}

function go_list(){
	$('form').submit();
}

$('#download').click(function(){
	location="download.ev?id=${vo.id}";
});

function go_comment_regist(){
// 	if( ${empty login_info} ){
	if( '${empty login_info}' == 'true' ){
		alert('댓글을 등록하려면 로그인하세요');
		return;
	}
	
	if( $('#comment').val().trim()=='' ){	//댓글의 내용이 아무것도 없을 때	//trim : 공백입력했을 때도 입력하지 않은걸로 처리
		alert('댓글을 입력하세요');
		$('#comment').val('');	//공백 입력 시 공백 없애는 처리
		$('#comment').focus();
		return;
	}
	
	$.ajax({
		url: 'event/comment/insert',
		data: { content: $('#comment').val(), pid:${vo.id} },
		success: function( data ){
			if( data ){
				$('#comment').val('');	//댓글 등록이 되면 적어놓은 댓글 사라지게 하는 처리
				alert('댓글이 등록되었습니다!');
				comment_list();		//댓글 등록 후 댓글 리스트를 뿌려준다
			}else {
				alert('댓글 등록 실패!');
			}
		},error: function(req, text){
			alert(text+": " + req.status);
		}
	});
}

function comment_list(){
	$.ajax({
		url: 'event/comment/${vo.id}',
		success: function(data){
			$('#comment-list').html(data);
		},error: function(req, text){
			alert(text + ": " + req.status);
		}
	});
}
</script>
</body>
</html>
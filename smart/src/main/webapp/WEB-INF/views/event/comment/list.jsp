<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:forEach items="${list }" var="vo" varStatus="status">	<!-- 컨트롤러에서 list라고 넣었음 -->
${status.index eq 0 ? '<hr>' : '' }
<%-- <div>${vo.name } [ <fmt:formatDate value="${vo.writedate }" pattern="yyyy-MM-dd hh:mm:ss"/> ] --%>
<div>${vo.name } [ ${vo.writedate } ]
<!-- 로그인 한 사용자가 작성한 댓글은 수정/삭제 가능 -->
<c:if test="${vo.userid eq login_info.userid }">
	<span style="float: right;">
		<a class="btn-fill-s" id="btn-modify-save-${vo.id }" onclick="go_modify_save(${vo.id})">수정</a>
		<a class="btn-fill-s" id="btn-delete-cancel-${vo.id }" onclick="go_delete_calcel(${vo.id})">삭제</a>
	</span>
</c:if>
</div>
<div id="original-${vo.id }">${fn:replace( fn:replace(vo.content, lf, '<br>'), crlf, '<br>' )}</div>
<div id="modify-${vo.id }" style="display: none;"></div>
<hr>
</c:forEach>

<script>
function go_modify_save(id){
	if( $('#btn-modify-save-' +id).text()=='수정' ){
		var tag = "<textarea id='comment-modify-"+id+"' style='width:99%; height:40px; margin-top:5px;'>"+$('#original-'+id).html().replace(/<br>/g, '\n')+"</textarea>";
		$('#modify-'+ id).html(tag);
		display(id, 'm');
	}else{	//저장버튼을 눌렀을때 처리
		var comment = new Object();
		comment.id = id;
		comment.content = $('#comment-modify-'+id).val();
		$.ajax({
			url: 'event/comment/update',
			type: 'post',
			data: JSON.stringify(comment),
			contentType: 'application/json; charset=utf-8',
			success: function(data){
				alert('댓글 변경 ' +data);
				comment_list();
			},error: function(req, text){
				alert(text + ": " + req.status);
			}
		})
	}
}
function display(id, mode){
	//변경상태: 저장/취소 <-> 수정/삭제
	$('#btn-modify-save-' +id).text( mode=='d' ? '수정' : '저장');
	$('#btn-delete-cancel-' +id).text( mode=='d' ? '삭제' : '취소');
	
	//변경상태: modify가 보이고, 원래글은 안보이게 <-> modify가 안보이고, 원래글은 보이게
	$('#modify-' +id).css('display', mode=='d' ? 'none' : 'block');
	$('#original-' +id).css('display', mode=='d' ? 'block' : 'none');
}
function go_delete_calcel(id){
	//삭제/취소
	if( $('#btn-delete-cancel-' +id).text()=='취소'){		//수정화면에서 취소버튼을 눌렀을때
		display(id, 'd');
	}else{
		if( confirm('정말 삭제하시겠습니까?') ){
			$.ajax({
				url: 'event/comment/delete/' +id,
				success: function(){
					comment_list();	//삭제 후 리스트를 다시 가져옴
				},error: function(req, text){
					alert(text+ ": " +req.status);
				}
			})
		}
	}
}
</script>
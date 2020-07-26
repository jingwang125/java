<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#header {
	width: 85%;	height: 50px; margin: 10px auto; max-width: 1200px; min-width: 800px; }
#header > * {
	float: left; padding: 0; }
#header li {
	display: inline; padding-left: 35px; }
#header input[type=text], #header input[type=password] { width: 100px; height: 18px;}
</style>
<div id="header">
	<a onclick="location='<c:url value="/"/>'"><img src="img/hanul.logo.png" alt="로고"/></a>
<%--<a onclick="location='home'"><img src="img/hanul.logo.png" alt="로고"/></a> --%>
	<ul>
		<li><a onclick="location='list.cu'">고객관리</a></li>
		<li><a onclick="location='list.no'">공지사항</a></li>
		<li><a onclick="location='list.bo'">게시판</a></li>
		<li><a onclick="location='list.ev'">행사안내</a></li>
		<li><a onclick="location='list.da'">공공데이터</a></li>
	</ul>
	
<!-- 로그인 한 경우 -->
	<c:if test="${ !empty login_info }">
		<p style="float: right;">
			${login_info.userid } [ ${login_info.name } ]
			<a class="btn-fill" onclick="go_logout()">로그아웃</a>
			</p>
	</c:if>
	
<!-- 로그인 하지 않은 경우 -->
	<c:if test="${ empty login_info }">
		<p style="float: right;">
			<a class="btn-fill" onclick="go_login()">로그인</a>
			<a class="btn-fill" onclick="location='member'">회원가입</a>
		</p>
		
		<span style="width: 120px; float: right;" >
			<input id="userid" type="text" placeholder="아이디" />
			<input id="userpwd" type="password" placeholder="비밀번호" onkeypress="if( event.keyCode==13 ){go_login()}"/>
			 <!-- onkeypress : 엔터키 눌러도 로그인 되게 처리 -->
		</span>
	</c:if>
</div>
<hr>
<script>
function go_login(){
	$.ajax({
		url: 'login',
		data: { userid: $('#userid').val(),
				userpwd: $('#userpwd').val() },
		success: function(data){
			if( data ){	//true이면
				location.reload();	//session에 data가 담겨져있으니(Controller에서 처리했던) reload
			}else{	//false이면
				alert('아이디나 비밀번호가 일치하지 않습니다.');
				$('#userid').focus();
			}
		}, error: function(req, text){
			alert(text + ": " + req.status);
		}
	});
}

function go_logout(){
	$.ajax({
		url: 'logout',
		success: function(){
			location.reload();
		}, error: function(req, text){
			alert(text + ": " + req.status);
		}
	});
	
}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#header {
	width: 85%;
	height: 50px;
	margin: 10px auto;
	max-width: 1200px;
	min-width: 800px;
}

#header>* {
	float: left;
	padding: 0;
}

#header ul {
	margin-left: 20%;
}

#header li {
	display: inline;
	padding-left: 35px;
}

#header div {
	margin-left: 30px;
}

#header-login div {
	
}

#header-login input {
	width: 100px;
}

#header-login button {
	width: 70px;
}

.modal {
	display: none; 
	position: fixed; 
	z-index: 1; 
	left: 0;
	top: 0;
	width: 100%;
	height: 100%; 
	background-color: rgb(0, 0, 0); 
	background-color: rgba(0, 0, 0, 0.4); 
}

.modal-content {
	background-color: #fefefe;
	margin: 15% auto; 
	padding: 20px;
	border: 1px solid #888;
	width: 330px; 
	height: 400px;
}

.modal-title {
	width: 100%;
	height: 40px;
	border: 1px solid #888;
	margin-top: -16pt;
	margin-left: -21px;
	background: #ff4d4d;
}
/* The Close Button */
.close {
	color: black;
	float: right;
	font-size: 28px;
	font-weight: bold;
	border: 1px solid #888;
	width: 40px;
	height: 40px;
	margin-top: -22px;
	margin-right: -42px;
	line-height: 36px;
}

.phone{
	width: 50px;
}

.detail{
	margin-top: 10px;
}

.valid, .invalid { font-size: 13px; font-weight: bold;}
.valid { color: green}
.invalid { color: red}
.detail input{
 	height: 24px;
}



</style>
<script type="text/javascript" src="js/join_validator.js?v=<%=new java.util.Date().getTime()%>"></script>
<div id="header">
	<ul>
		<li><a onclick="location='home'">공유주방?</a></li>
		<li><a onclick="location='menu.re'">매장예약</a></li>
		<li><a onclick="location='notice.re'">추천메뉴</a></li>
		<li><a>추천쉐프</a></li>
		<li><a>Q&A</a></li>
	</ul>

	<!-- 로그인을 한 경우 -->
	<c:if test="${ !empty login_info }">
		<div id="header-login2" style="margin-top: 13px;">
			<div id="loginid">
				[ ${login_info.id } ]
				<button id="logout" onclick="logout();">로그아웃</button>
			</div>
		</div>
	</c:if>

	<!-- 로그인을 안 한 경우 -->
	<c:if test="${ empty login_info }">
		<div id="header-login">
			<div>
				아이디: <input id="userid" placeholder="아이디" style="margin-left: 16px;">
				<button id="login" onclick="login();">로그인</button>
			</div>
			<div>
				비밀번호: <input id="userpwd" type="password" placeholder="비밀번호"
					onkeypress="if( event.keyCode==13 ){login()}">
				<button id="membership">회원가입</button>
			</div>
		</div>
	</c:if>
</div>


<!-- The Modal -->
<div id="myModal" class="modal">

	<!-- Modal content -->
	<div class="modal-content">
		<div class="modal-title">
			<div>회원 가입</div>
			<span class="close"> &times;</span>
		</div>
		<div>
			<div class="detail">이  름 :
				<input id="name">
			</div>
			<div class="detail">아이디 :
				<input id="id" onkeyup="$('#id_usable').val('n'); validate('id');">
				<button id="btn-usable" onclick="usable()">중복확인</button>
				<div class="valid" id="id_status">아이디를 입력하세요(영문 소문자, 숫자만)</div>
			</div>
			<div class="detail">비밀번호 :
				<input id="pw" type="password" onkeyup=" validate('pw');">
				<div class="valid" id="pw_status">비밀번호를 입력하세요(영문 대/소문자, 숫자 모두 포함)</div>
			</div>
			<div class="detail">비밀번호 확인 :
				<input id="pw_ck" type="password" onkeyup=" validate('pw_ck');">
				<div class="valid" id="pw_ck_status">비밀번호를 다시 입력하세요</div>
			</div>
			<div class="detail">성별 :
				<td><label><input type="radio" name="gender" value="남" checked/>남</label>&nbsp;
					<label><input type="radio" name="gender" value="여" />여</label>
				</td>
			</div>	
			<div class="detail">연락처 :
				<input type="text" class="phone" maxlength="3"> -
				<input type="text" class="phone" maxlength="4"> -
				<input type="text" class="phone" maxlength="4">
			</div>
			<div class="detail">이메일 :
				<input id="email" onkeyup=" validate('email');">
				<div class="valid" id="email_status">이메일을 입력하세요</div>
			</div>
			<button onclick="customerJoin()">가입</button>
			<button onclick='location="<c:url value='/'/>"'>취소</button>
		</div>
	</div>

</div>

<script>
	//Get the modal
	var modal = document.getElementById('myModal');

	// Get the button that opens the modal
	var btn = document.getElementById("membership");

	// Get the <span> element that closes the modal
	var span = document.getElementsByClassName("close")[0];

	// When the user clicks on the button, open the modal 
	btn.onclick = function() {
		modal.style.display = "block";
	}

	// When the user clicks on <span> (x), close the modal
	span.onclick = function() {
		modal.style.display = "none";
	}

	// When the user clicks anywhere outside of the modal, close it
	window.onclick = function(event) {
		if (event.target == modal) {
			modal.style.display = "none";
		}
	}

	function login() {
		$.ajax({
			url : 'login',
			data : {
				id : $('#userid').val(),
				pw : $('#userpwd').val()
			},
			success : function(data) {
				if (data) { //true이면
					location.reload(); //session에 data가 담겨져있으니(Controller에서 처리했던) reload
				} else { //false이면
					alert('아이디나 비밀번호가 일치하지 않습니다.');
					$('#userid').focus();
				}
			},
			error : function(req, text) {
				alert(text + " : " + req.status);
			}
		});
	}

	function logout() {
		$.ajax({
			url : 'logout',
			success : function() {
				location.reload();
			},
			error : function(req, text) {
				alert(text + ": " + req.status);
			}
		});

	}
	
	function validate(tag){
		var value = $("#"+tag+"").val();
		if(tag=='id'){
			value = join_validator.userid_status(value);
		}else if(tag=='pw'){
			value = join_validator.userpwd_status(value);
		}else if(tag=='pw_ck'){
			value = join_validator.userpwd_ck_status(value, $('#pw').val());
		}else if(tag=='email'){
			value = join_validator.email_status(value);
		}
		
		if ( value ){	//value가 있으면
			$('#' + tag + '_status').text( value.desc );
			$('#' + tag + '_status').removeClass('valid').removeClass('invalid');
			$('#' + tag + '_status').addClass(value.code=='valid' ? 'valid' : 'invalid' )
		}
		return value;
	}
	
	function usable(){
		var data = validate('id');
		if( data.code != 'valid' ){	//중복확인 불필요 상태
			alert( data.desc );
			return;
		}
		
		$.ajax({
			url: 'id_usable',	//어디로 보낼건지
			type: 'post',
			data: { id: $("#id").val() },	//으로 보내고
			success: function(data){
				data = join_validator.userid_usable(data);	//받아온 데이터를 가지고 판단해서
				if( data ){
					$('#id_usable').val(data.code);
					$('#id_status').text(data.desc);
					$('#id_status').removeClass('valid').removeClass('invalid');	//이미 valid, invalid에 값이 들어있으니까 일단 지우기
					$('#id_status').addClass(data.code=='usable' ? 'valid' : 'invalid');
				}
			},error: function(req, text){
				alert(text + ": " + req.status);
			}
		});
		
	}
	
	function customerJoin(){
		
		if( $('#name').val().trim()=='' ){	//입력한 값이 없으면
			alert('성명을 입력하세요');
			$('#name').val('');	//공백 입력했을 때 공백제거 하도록 초기화
			$('#name').focus();
			return;
		}
		//중복확인 안한경우 유효한지 판단
		if( $('#id_usable').val()=='n' ){	//값이 '중복확인 안했습니다'인 경우
			if( !item('id') ) return;	//false이면
			else {
				alert( join_validator.userid.valid.desc );
	 			$('#btn-usable').focus();	//버튼으로 만든경우
				usable();
				return;
			}		
		}else if( $('#id_usable').val()=='unusable' ){	//중복확인 한 경우 - 이미 사용중인 경우만
			alert( join_validator.userid.unusable.desc );
			$('#id').focus();
			return;
		}
		
		if( !item('pw') ) return;
		if( !item('pw_ck') ) return;
		if( !item('email') ) return;
		
		var oData = new Object();
		oData.id = $("#id").val();
		oData.pw = $("#pw").val();
		oData.name = $("#name").val();
		oData.gender = $(":input:radio[name=gender]:checked").val();
		oData.phone = $(".phone").eq(0).val()+"-"+$(".phone").eq(1).val()+"-"+$(".phone").eq(2).val();
		oData.email = $("#email").val();
		
		var customer = JSON.stringify(oData);
		console.log(customer);
		
		$.ajax({
	        url : 'customerjoin',
	        type : 'POST',
	        headers : {
	          'Content-Type' : 'application/json',
	          'X-HTTP-Method-Override' : 'POST'
	        },      
	        data : customer,
	        dataType : "text", // 
	        success : function(e) {
	        	modal.style.display = "none";
	        	alert("회원가입 성공");
	        },
	        error : function(req, text) {
	        	alert(text + " : " + req.status);
	        }
	      }); 
		
	}
	
	function item(tag){
		var data = validate(tag);	//호출 했을때 결과값을 반환할 데이터 선언
		if( data.code != 'valid' ){
			alert(data.desc);	//어떤게 문제인지 알림뜨도록
			$("#"+tag+"").focus();	//그리고 그 태그에 포커스
			return false;
		}else {
			return true;
		}
	}
 
	
</script>



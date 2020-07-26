<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
table td { text-align: left;}
input[name=phone], input[name=post] { width: 50px; text-align: center;}
input[name=address] { width: 98%}

.ui-datepicker select.ui-datepicker-month, .ui-datepicker select.ui-datepicker-year{
	vertical-align: middle;
	height: 28px;
}

.valid, .invalid { font-size: 13px; font-weight: bold;}
.valid { color: green}
.invalid { color: red}
</style>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">	<!-- datepicker 꾸미는 link -->

<script type="text/javascript">
//아이디 중복확인 유효성검사 - resources/js/join_validator 자바스크립트 파일
function validate(tag){
	var value = $('[name=' + tag + ']').val();
// 	console.log(tag, value);
	if (tag=='userid'){
		value = join_validator.userid_status(value);
	}else if(tag=='userpwd'){
		value = join_validator.userpwd_status(value);
	}else if(tag=='userpwd_ck'){
		value = join_validator.userpwd_ck_status(value, $('[name=userpwd]').val());
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
//아이디 중복확인
function usable(){
	var data = validate('userid');
	if( data.code != 'valid' ){	//중복확인 불필요 상태
		alert( data.desc );
		return;
	}
	$.ajax({
		type: 'post',
		data: { userid: $('[name=userid]').val() },	//으로 보내고
		url: 'id_usable',	//어디로 보낼건지
		success: function(data){
			console.log(data);
			data = join_validator.userid_usable(data);	//받아온 데이터를 가지고 판단해서
			if( data ){
				$('#id_usable').val(data.code);
				$('#userid_status').text(data.desc);
				$('#userid_status').removeClass('valid').removeClass('invalid');	//이미 valid, invalid에 값이 들어있으니까 일단 지우기
				$('#userid_status').addClass(data.code=='usable' ? 'valid' : 'invalid');
			}
		},error: function(req, text){
			alert(text + ": " + req.status);
		}
	});
}
</script>
<script type="text/javascript" src="js/join_validator.js?v=<%=new java.util.Date().getTime()%>"></script>

</head>
<body>
<h3>회원가입</h3>
<form method="post" action="join">
<input type="hidden" id="id_usable" value="n"/>
<table style="width: 60%">
<tr>
	<th style="width: 130px">* 성명</th>
		<td><input type="text" name="name" /></td>
</tr>
<tr>
	<th>* 아이디</th>
			<!-- onkeyup: userid 입력할 때마다  유효한지 체크  -->
<!-- 			$('#id_usable').val('n'); : ID 중복확인 할때마다 아직 중복확인 하지 않은 걸로 초기화 시키는 처리 -->
		<td><input type="text" name="userid" onkeyup="$('#id_usable').val('n'); validate('userid')" maxlength="15" />
			<a class="btn-fill" onclick="usable()" id="btn-usable">중복확인</a>
			<div class="valid" id="userid_status">아이디를 입력하세요(영문 소문자, 숫자만)</div>
		</td>
</tr>
<tr>
	<th>* 비밀번호</th>
		<td><input type="password" name="userpwd" onkeyup="validate('userpwd')"/><br>
			<div class="valid" id="userpwd_status">비밀번호를 입력하세요(영문 대/소문자, 숫자 모두 포함)</div>
		</td>
</tr>
<tr>
	<th>* 비밀번호 확인</th>
		<td><input type="password" name="userpwd_ck" onkeyup="validate('userpwd_ck')"/>
			<div class="valid" id="userpwd_ck_status">비밀번호를 다시 입력하세요</div>
		</td>
</tr>
<tr>
	<th>* 성별</th>
		<td><label><input type="radio" name="gender" value="남" checked/>남</label>&nbsp;
			<label><input type="radio" name="gender" value="여" />여</label>
		</td>
</tr>
<tr>
	<th>* 이메일</th>
		<td><input type="text" name="email" onkeyup="validate('email')"/>
			<div class="valid" id="email_status">이메일을 입력하세요</div>
		</td>
</tr>
<tr>
	<th>생년월일</th>
		<td><input type="text" name="birth" readonly/>
			<img id="btn-delete" src="img/delete.png" class="btn-img"
					style="display: none; position: relative; right: 30px" />
		</td>
</tr>
<tr>
	<th>전화번호</th>
		<td><input type="text" name="phone" maxlength="3"/>
		  - <input type="text" name="phone" maxlength="4"/>
		  - <input type="text" name="phone" maxlength="4"/>
		</td>
</tr>
<tr>
	<th>주소</th>
		<td><input type="text" name="post" readonly/>
			<a class="btn-fill" onclick="go_post()">우편번호 검색</a><br>
			<input type="text" name="address" readonly  />
			<input type="text" name="address" />
		</td>
</tr>
</table><br>
<a class="btn-fill" onclick="go_submit()">회원가입</a>
<a class="btn-empty" onclick='location="<c:url value='/'/>"'>취소</a>
</form>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>	<!-- 생년월일ui : jqueryui.com에서 -->
<script type="text/javascript">
$('[name=birth]').datepicker({
	dateFormat: 'yy-mm-dd',
	changeYear: true,	//바꿀 수 있도록 설정
	changeMonth: true,
	dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	beforeShowDay: after
});

$('[name=birth]').change(function(){
	$('#btn-delete').css('display', 'inline-block');	//날짜를 선택하면 아이콘이 나오게 설정
});

$('#btn-delete').click(function(){
	$('[name=birth]').val('');
	$('#btn-delete').css('display', 'none');	//display를 안보이게
});
function after(date){
	if( date > new Date() ){
		return [false];
	}else {
		return [true];
	}
}

function go_post(){
	new daum.Postcode({
		oncomplete: function(data){
			console.log(data);	//화면 검사창에서 확인해보기(buildingName)
			var post, address;
			if ( data.userSelectedType == 'J' ){
				post = data.postcode;
				address = data.jibunAddress;
			}else {
				post = data.zonecode;
				address = data.roadAddress;
				var extra = '';
				if( data.buildingName !=''){	//건물 이름이 있으면
					extra = address += data.buildingName;	//넣어주고
				}
				address += extra=='' ? '' : '(' + extra + ')';
			}
			$('[name=post]').val(post);	//데이터를 담는 처리
			$('[name=address]:eq(0)').val(address);
			$('[name=address]:eq(1)').val('');	//우편번호 검색을 다시했을 때 값을 초기화 시켜줌
		}
	}).open();	//창 뜨게하는 처리
}

function go_submit(){
	if( $('[name=name]').val().trim()=='' ){	//입력한 값이 없으면
		alert('성명을 입력하세요');
		$('[name=name]').val('');	//공백 입력했을 때 공백제거 하도록 초기화
		$('[name=name]').focus();
		return;
	}
	//중복확인 안한경우 유효한지 판단
	if( $('#id_usable').val()=='n' ){	//값이 '중복확인 안했습니다'인 경우
		if( !item('userid') ) return;	//false이면
		else {
			alert( join_validator.userid.valid.desc );
// 			$('#btn-usable').focus();	//버튼으로 만든경우
			usable();
			return;
		}		
	}else if( $('#id_usable').val()=='unusable' ){	//중복확인 한 경우 - 이미 사용중인 경우만
		alert( join_validator.userid.unusable.desc );
		$('[name=userid]').focus();
		return;
	}
	
	if( !item('userpwd') ) return;
	if( !item('userpwd_ck') ) return;
	if( !item('email') ) return;
	
	$('form').submit();
	
}
function item(tag){
	var data = validate(tag);	//호출 했을때 결과값을 반환할 데이터 선언
	if( data.code != 'valid' ){
		alert(data.desc);	//어떤게 문제인지 알림뜨도록
		$('[name=' + tag + ']').focus();	//그리고 그 태그에 포커스
		return false;
	}else {
		return true;
	}
}
</script>

</body>
</html>
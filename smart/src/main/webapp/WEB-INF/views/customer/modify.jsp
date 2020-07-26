<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
input[name=phone]{ width: 40px; text-align: center;}
table td { text-align: left;}
</style>
</head>
<body>
<h3>고객 수정</h3>
<form method="post" action="update.cu">
<input type="hidden" name="id" value="${vo.id }" />
<table style="width: 60%">
<tr>
	<th style="width: 100px">고객명</th>
		<td class="left"><input type="text" value="${vo.name }" name="name"/></td>
</tr>
<tr>
	<th>성별</th>
		<td class="left">
			<label><input type="radio" value="남" name="gender" ${vo.gender eq '남'? 'checked' : ''}/>남</label>&nbsp;&nbsp;
			<label><input type="radio" value="여" name="gender" ${vo.gender eq '여'? 'checked' : ''}/>여</label>
		</td>
</tr>
<tr>
	<th>이메일</th>
		<td class="left"><input type="text" name="email" value="${vo.email }" /></td>
</tr>
<tr>
	<th>전화번호</th>
		<td>
			<input type="text" name="phone" value="${vo.phone[0]}"/>
		  -	<input type="text" name="phone" value="${vo.phone[1]}"/>
		  -	<input type="text" name="phone" value="${vo.phone[2]}"/>
		</td>
</tr>
</table><br>
<a class="btn-fill" onclick="$('form').submit()">저장</a>
<a class="btn-empty" onclick="location='detail.cu?id=${vo.id}'">취소</a>
</form>

</body>
</html>
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
<h3>신규고객 등록</h3>
<form method="post" action="insert.cu">
<table style="width: 60%">
<tr>
	<th style="width: 100px">고객명</th>
		<td class="left"><input type="text" name="name"/></td>
</tr>
<tr>
	<th>성별</th>
		<td class="left">
			<label><input type="radio" value="남" name="gender" checked/>남</label>&nbsp;&nbsp;
			<label><input type="radio" value="여" name="gender"/>여</label>
		</td>
</tr>
<tr>
	<th>이메일</th>
		<td class="left"><input type="text" name="email"/></td>
</tr>
<tr>
	<th>전화번호</th>
		<td>
			<input type="text" name="phone"/>
		  -	<input type="text" name="phone"/>
		  -	<input type="text" name="phone"/>
		</td>
</tr>
</table><br>
<a class="btn-fill" onclick="$('form').submit()">저장</a>
<a class="btn-empty" onclick="location='list.cu'">취소</a>
</form>
</body>

</html>
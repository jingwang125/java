<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>[ ${vo.name } ] 고객 정보</h3>
<table style="width: 60%">
<tr>
	<th style="width: 200px">성별</th>
		<td>${vo.gender }</td>
</tr>
<tr>
	<th>이메일</th>
		<td>${vo.email }</td>
</tr>
<tr>
	<th>연락처</th>
		<td>${vo.phones }</td>
</tr>
</table><br>
<a class="btn-fill" onclick="location='list.cu'">고객목록</a>
<a class="btn-fill" onclick="location='modify.cu?id=${vo.id}'">수정</a>
<a class="btn-fill" onclick="if( confirm('정말 [ ${vo.name } ] 삭제?') ){ location='delete.cu?id=${vo.id}'}">삭제</a>
</body>
</html>
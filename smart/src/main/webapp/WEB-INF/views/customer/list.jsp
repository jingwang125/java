<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>고객목록</h3>
<table>
<tr>
	<th style="width: 60px">번호</th>
	<th>고객명</th>
	<th style="width: 300px">이메일</th>
</tr>
<c:forEach items="${list }" var="vo">
<tr>
	<td>${vo.no }</td>
	<td><a onclick="location='detail.cu?id=${vo.id}'">${vo.name }</a></td>
	<td>${vo.email }</td>
</tr>
</c:forEach>
</table><br>

<a class="btn-fill" onclick="location='new.cu'">신규고객</a>

</body>
</html>
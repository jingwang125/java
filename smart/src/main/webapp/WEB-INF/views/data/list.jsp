<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#popup-background{
	position: absolute;
	width: 100%; height: 100%; left: 0; top: 0;
/* 	background-color: #000; opacity: 0.2; */
	background-color: rgba(0,0,0,0.2);
 	display: none;
}
#popup{
	position: absolute;
	width: 800px; height: 600px;
	left: 50%; top: 50%; transform: translate(-50%, -50%);
	border: 3px solid #666;
 	display: none;
}
#list-top{
	width: 85%; padding: 20px 7.5%;
}
#list-top select{
	margin-right: 10px; height: 28px; float: left; 
}
#data-list table img{
	width: 100px; height: 100px;
}
</style>
</head>
<body>
<h3>공공데이터 정보</h3>
<a class="btn-fill" onclick="pharmacy_list()">약국정보조회</a>
<a class="btn-fill" onclick="animal_sido()">유기동물조회</a>
<div id="list-top" style="display: none;"></div>

<div id="data-list" style="margin: 0 auto; padding-top: 20px;"></div>
<div id="popup-background" onclick="$('#popup, #popup-background').css('display', 'none')"></div>
<div id="popup"></div>
<script
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCsrerDHJrp9Wu09Ij7MUELxCTPiYfxfBI">
</script>

<script type="text/javascript">
function pharmacy_list(){
	$('#list-top').css('display', 'none');
	$.ajax({
		url: 'data/pharmacy',
		success: function(data){
			console.log(data);
			var tag = "<table>"
					+ "<tr><th>약국명</th>"
						+ "<th>전화번호</th>"
						+ "<th>주소</th>"
					+ "</tr>";
			$(data).find('item').each(function(){
				var xy = $(this).find('YPos').text() + ", "
						+$(this).find('XPos').text() + ", "
						+ "'" + $(this).find('yadmNm').text() + "'"
				tag += '<tr>'
					+ '<td><a onclick="show_map('+ xy +')">'+ $(this).find('yadmNm').text() +'</a></td>'
					+ '<td>'+ $(this).find('telno').text() +'</td>'
					+ '<td class="left">'+ $(this).find('addr').text() +'</td>'
					+ '</tr>';
			});
			tag += "</table>";
			$('#data-list').html(tag);
		},error: function(req, text){
			alert(text + ": " + req.status);
		}
	});
}

function animal_list(){
	$('#data-list').html('');
	$.ajax({
		url: 'data/animal/list',
		success: function(data){
			console.log(data);
			var tag = '<table style="width: 85%">';
			$(data).each(function(idx, item){
				tag += '<tr>'
						 + '<td rowspan="3"><img src="'+ item.filename +'" /></td>'
						 + '<th>성별</th><td>'+ item.sexCd +'</td>'
						 + '<th>나이</th><td>'+ item.age +'</td>'
						 + '<th>체중</th><td>'+ item.weight +'</td>'
						 + '<th>색상</th><td>'+ item.colorCd +'</td>'
						 + '<th>접수일자</th><td>'+ item.happenDt +'</td>'
					 + '</tr>';
					 
				tag += '<tr>'
						+ '<th>특징</th>'
							+ '<td class="left"colspan="9">'+ item.specialMark +'</td></tr>'
				  	 + '<tr><th>발견장소</th>'
				  			+ '<td class="left" colspan="8">'+ item.happenPlace +'</td>'
							+ '<td>'+ item.processState +'</td>'
					 + '</tr>';
				//유기동물 보호소 정보					 
				tag += '<tr>'
						 + '<td colspan="2">'+ item.careNm +'</td>'
						 + '<td class="left" colspan="7">'+ item.careAddr +'</td>'
						 + '<td colspan="2">'+ item.careTel +'</td>'
					 + '</tr>';
			});
			tag += '</table>';
			$('#data-list').html(tag);
		},error: function(req, text){
			alert(text+ ": " +req.status);
		}
	});
}

function animal_sido(){
	$('#data-list').html('');
	$('#list-top').css('display', 'block');
	
	$.ajax({
		url: 'data/animal/sido',
		success: function(data){
			var tag = '<select id="sido" style="width:130px">'
					+ '<option value="">시도선택</option>';
			$(data).find('item').each(function(){
				tag += '<option value="'+ $(this).find('orgCd').text() +'">'+ $(this).find('orgdownNm').text() +'</option>';
			});
			tag += '</select>';
			tag += '<a class="btn-fill" style="float:right" onclick="animal_list()">조회</a>';
			$('#list-top').html(tag);
			
		},error: function(req, text){
			alert(text+ ": " +req.status);
		}
	})
}

$(document).on('change', '#sido', function(){
	animal_sigungu();
	$.ajax({
		url: 'data/animal/sigungu',
		data: { sido: $('#sido').val() },
		success: function(data){
			var tag = '<select style="width:120px;">'
					+ '<option value="">시군구선택</option>';
					$(data).each(function(idx, item){
						tag += '<option value="'+ item.orgCd +'">'+ item.orgdownNm +'</option>';
					});
			
			tag += '</select>';
			$('#list-top').find('#sido').after(tag);
		},error: function(req, text){
			alert(text+ ": " +req.status);
		}
	});
});

function animal_sigungu(){
	$('#data-list').html('');
	
}

function show_map(lat, lon, name){
	$('#popup, #popup-background').css('display', 'block');
	var xy = {lat: lat, lng: lon};
	var map = new google.maps.Map(
		      document.getElementById('popup'), {zoom: 15, center: xy});
	var marker = new google.maps.Marker({position: xy, map: map, title: name});
}

</script>

</body>
</html>
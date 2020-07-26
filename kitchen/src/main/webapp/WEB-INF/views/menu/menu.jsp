<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
<html>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCsrerDHJrp9Wu09Ij7MUELxCTPiYfxfBI"></script>
<link rel="stylesheet" href="/kitchen/css/menu.css">
<%-- <c:set var="root" value="${pageContext.request.contextPath}"/> --%>

<body>
	<!-- 헤더와 바디 구분 -->
	<div id="main"></div>
	
	<c:if test="${login_info.id eq 'hong' }">
	<div id="menuPlus" class="menuPlus">
		<button  onclick="imgSubmit();">이미지 저장</button>
		<button id="menuDe" onclick="menuDelete();">장소 삭제</button>
		<button id="menuSa" onclick="menuSave();">장소 저장</button>
		<button onclick="menuForm();">장소 추가</button>
		<div id="menuplus2">
			<div id="menuplus2-1">
				<div id="mp211"><ul></ul></div>
				<div id="mp212"><ul></ul></div>
			</div>
			<div id="menuplus2-2">
				<ul><li>번호</li></ul>
				<input id="no" type="text" disabled>
				<ul><li>장소</li></ul>
				<input id="pla" type="text">
				<ul><li>방번호</li></ul>
				<div id="menuroo">
				<input id="roomno1" type="text">
				</div>
				<ul><li id="roomplus">+</li></ul>
			</div>
			<div id="menuplus2-3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이미지 업로드
				<form id="fileForm" method="post" enctype="multipart/form-data">
				<input type="file" id="input_imgs" multiple="multiple" />
				<div class="imgs_wrap"></div>
				</form>
			</div>
			
		</div>
	</div>
	</c:if>
	
	<!-- 장소 날짜 시간 번호 사용목적 -->
	
	<div id="menu">
	<div class="menu">
		<div class="main2">
			<ul>
			<li><a>장소</a></li>
			<select class="place">
			</select>
			</ul>
		</div>
		<div class="main2">
			<ul>
			<li><a>번호</a></li>
			<select class="place2">
			</select>
			</ul>
		</div>
		<div class="main2">
			<ul>
			<li><a>날짜</a></li>
			<input type="text" id="datepicker">
			</ul>
		</div>
	

	</div>	
	<div class="menu">		
		<div class="main2">
			<ul>
			<li class="mains-1"><a>시간</a></li>
			<input type="text" class="timepicker">
			</ul>
		</div>
		
		<div class="main2">
			<ul>
			<li class="mains-1"><a>사용 목적</a></li>
			<select class="object mains-1">
				<option>요리교실</option>
				<option>파티룸</option>
				<option>개인요리</option>
			</select>
			</ul>
		</div>
		
	</div>
	</div>
	
	
	<!-- 사진 지도 -->
	<div id="menu2">
		<div class="menu21">
			<!-- Container for the image gallery -->
			<div class="container">

			<!-- Full-width images with number text -->
 			<div class="mySlides">
  				<div class="numbertext">1 / 3</div>
  		    	<img src="/kitchen/img/image1.png">
 		 	</div>

 		 	<div class="mySlides">
  		    	<div class="numbertext">2 / 3</div>
  		    	<img src="/kitchen/img/image2.jpg">
  			</div>

 		 	<div class="mySlides">
  		  		<div class="numbertext">3 / 3</div>
  		    	<img src="/kitchen/img/image3.png">
 		 	</div>

 		 	<!-- Next and previous buttons -->
 		 	<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
 		 	<a class="next" onclick="plusSlides(1)">&#10095;</a>

			<div class="lines"></div>
			
 		 	<!-- Thumbnail images -->
 		 	<div class="row">
  		  		<div class="column">
  		    		<img class="demo cursor" src="/kitchen/img/image1.png" style="width:100%" onclick="currentSlide(1)">
  		  		</div>
  		  		<div class="column">
   		    		<img class="demo cursor" src="/kitchen/img/image2.jpg" style="width:100%" onclick="currentSlide(2)">
  		  		</div>
 		   		<div class="column">
  		    		<img class="demo cursor" src="/kitchen/img/image3.png" style="width:100%" onclick="currentSlide(3)">
 		   		</div>
 		 	</div>
		</div>
	</div>
	
		<!-- 구글 지도 -->
		<div class="menu22">
			<div id="map_ma"></div>
		</div>
	</div>
	
	<!-- 예약현황 -->
	<div id="menu3">
		<div>예약현황</div>
		<button>예 약</button>
	</div>
	
	
</body>
</html>
<%-- <script type="text/javascript" src="/kitchen/js/menu.js?v=<%=new java.util.Date().getTime()%>"> --%>
<script>
$(function() {
	
    //모든 datepicker에 대한 공통 옵션 설정
    $.datepicker.setDefaults({
        dateFormat: 'yy-mm-dd' //Input Display Format 변경
        ,showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
        ,showMonthAfterYear:true //년도 먼저 나오고, 뒤에 월 표시
        ,changeYear: true //콤보박스에서 년 선택 가능
        ,changeMonth: true //콤보박스에서 월 선택 가능                
        ,showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시  
        ,buttonImage: "http://jqueryui.com/resources/demos/datepicker/images/calendar.gif" //버튼 이미지 경로
        ,buttonImageOnly: false //기본 버튼의 회색 부분을 없애고, 이미지만 보이게 함
        ,buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트                
        ,yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트
        ,minDate: "-1M" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
        ,maxDate: "+1M" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)                    
    });
    //input을 datepicker로 선언
    $("#datepicker").datepicker();                    
    //From의 초기값을 오늘 날짜로 설정
    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)

    
	//시간 
	$('.timepicker').timepicker({
   		timeFormat: 'p h:mm',
   		interval: 180,
   		minTime: '9',
   		maxTime: '11:00pm',
   		defaultTime: '9',
   		startTime: '00:00',
   		dynamic: false,
   		dropdown: true,
   	 	scrollbar: true
	});
    
    
    //구글 지도
	var myLatlng = new google.maps.LatLng(35.837143,128.558612); // 위치값 위도 경도
	var Y_point			= 35.837143;		// Y 좌표
	var X_point			= 128.558612;		// X 좌표
	var zoomLevel		= 18;				// 지도의 확대 레벨 : 숫자가 클수록 확대정도가 큼
	var markerTitle		= "대구광역시";		// 현재 위치 마커에 마우스를 오버을때 나타나는 정보
	var markerMaxWidth	= 300;				// 마커를 클릭했을때 나타나는 말풍선의 최대 크기
	//말풍선 내용
	var contentString	= '<div>' +
	'<h2>대구남구</h2>'+
	'<p>안녕하세요. 구글지도입니다.</p>' +
	'</div>';
	var myLatlng = new google.maps.LatLng(Y_point, X_point);
	var mapOptions = {
					zoom: zoomLevel,
					center: myLatlng,
					mapTypeId: google.maps.MapTypeId.ROADMAP
				}
	var map = new google.maps.Map(document.getElementById('map_ma'), mapOptions);
	var marker = new google.maps.Marker({
										position: myLatlng,
										map: map,
										title: markerTitle
	});
	var infowindow = new google.maps.InfoWindow(
											{
												content: contentString,
												maxWizzzdth: markerMaxWidth
											}
		);
	google.maps.event.addListener(marker, 'click', function() {
	infowindow.open(map, marker);
	});
   
	
	//장소 목록불러오기
	shop_list();
 	room_list(1);
 	room_list2(1);
 	
 	var sel_files = [];
 	fileupload();
 	
 	
 	//장소 변화시 방번호입력
	$(".place").on('change', function(){
	    var shop_id = $(this).val();
	    room_list(shop_id);
	    
	});
	$("#roomno1").css({"margin-top":"0px","margin-left":"0px","width":"184px"});
	$("#roomplus").css({"margin-top":"-30px","margin-left":"15px","border-radius":"50%","font-size":"35px","width":"25px","height":"25px","line-height":"19px","text-align":"center","background":"#ff4d4d"});
	
	//관리자모드 방번호 추가버튼
	var total = 10;
	$("#roomplus").on("click", function(){
		menuDisabled();
		total--;
		var count = total+1;
		var tag = '<input type="text" id="roomno'+count+'" />';
		$("#menuroo").append(tag);
	});
	
	$("#menuDe").css("margin-right","370px");
	menuClicks();
	
});


var slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  var i;
  var slides = document.getElementsByClassName("mySlides");
  var dots = document.getElementsByClassName("demo");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
} 


function menuClicks(){
	var count = 0;
	$("#mp211").on("click","li",function(e){
		count++;
		if(count > 1){
			$("#mp211 li").removeClass("selecte");		
		};
		total = 10;
		var num = $(this).val();
		var place = $(this).html();
		//선택시 배경색넣기
		$(this).addClass("selecte");
		//선택시 방번호로딩
		room_list2(num);
		//선택한 장소 정보 보기
		$("#no").val(num);
		$("#pla").val(place);
	
	});
}

function shop_list(){
	$.ajax({
		url: 'shopList',
		dataType : 'json',
		success: function(data){
			var shop = data.shopList;
			var tag = "";
			var str = ""; 
			$.each(shop, function(key, value){
				tag += '<option value='+value.shop_id+'>'+value.shop_place+'</option>';
				str += '<li value='+value.shop_id+'>'+value.shop_place+'</li>';
			});
			
			$(".place").html(tag);
			$("#mp211 ul").html(str);
		},error: function(req, text){
			alert(text + " : " + req.status);
		}
	});
}

function room_list(n){
	$.ajax({
		url: 'roomList?shop_id='+n,
		dataType : 'json',
		success: function(data){
			var tag = "";
				tag += '<option>'+data[0].ro_name1+'</option>';
				if(data[0].ro_name2 != null){
				tag += '<option>'+data[0].ro_name2+'</option>';
				}
				if(data[0].ro_name3 != null){
				tag += '<option>'+data[0].ro_name3+'</option>';
				}
				if(data[0].ro_name4 != null){
				tag += '<option>'+data[0].ro_name4+'</option>';
				}
				if(data[0].ro_name5 != null){
				tag += '<option>'+data[0].ro_name5+'</option>';
				}
				if(data[0].ro_name6 != null){
				tag += '<option>'+data[0].ro_name6+'</option>';
				}
				if(data[0].ro_name7 != null){
				tag += '<option>'+data[0].ro_name7+'</option>';
				}
				if(data[0].ro_name8 != null){
				tag += '<option>'+data[0].ro_name8+'</option>';
				}
				if(data[0].ro_name9 != null){
				tag += '<option>'+data[0].ro_name9+'</option>';
				}
				if(data[0].ro_name10 != null){
				tag += '<option>'+data[0].ro_name10+'</option>';
				}
			$(".place2").html(tag);
			
		},error: function(req, text){
			alert(text + " : " + req.status);
		}
	});
}

function room_list2(n){
	$.ajax({
		url: 'roomList?shop_id='+n,
		dataType : 'json',
		success: function(data){
			var tag = "";
			var tag2 = "";
			tag += '<li>'+data[0].ro_name1+'</li>';
			tag2 += '<input type="text" id="roomno1" value="'+data[0].ro_name1+'" />';
			if(data[0].ro_name2 != null){
			tag += '<li>'+data[0].ro_name2+'</li>';
			tag2 += '<input type="text" id="roomno2" value="'+data[0].ro_name2+'" />';
			}
			if(data[0].ro_name3 != null){
			tag += '<li>'+data[0].ro_name3+'</li>';
			tag2 += '<input type="text" id="roomno3" value="'+data[0].ro_name3+'" />';
			}
			if(data[0].ro_name4 != null){
			tag += '<li>'+data[0].ro_name4+'</li>';
			tag2 += '<input type="text" id="roomno4" value="'+data[0].ro_name4+'" />';
			}
			if(data[0].ro_name5 != null){
			tag += '<li>'+data[0].ro_name5+'</li>';
			tag2 += '<input type="text" id="roomno5" value="'+data[0].ro_name5+'" />';
			}
			if(data[0].ro_name6 != null){
			tag += '<li>'+data[0].ro_name6+'</li>';
			tag2 += '<input type="text" id="roomno6" value="'+data[0].ro_name6+'" />';
			}
			if(data[0].ro_name7 != null){
			tag += '<li>'+data[0].ro_name7+'</li>';
			tag2 += '<input type="text" id="roomno7" value="'+data[0].ro_name7+'" />';
			}
			if(data[0].ro_name8 != null){
			tag += '<li>'+data[0].ro_name8+'</li>';
			tag2 += '<input type="text" id="roomno8" value="'+data[0].ro_name8+'" />';
			}
			if(data[0].ro_name9 != null){
			tag += '<li>'+data[0].ro_name9+'</li>';
			tag2 += '<input type="text" id="roomno9" value="'+data[0].ro_name9+'" />';
			}
			if(data[0].ro_name10 != null){
			tag += '<li>'+data[0].ro_name10+'</li>';
			tag2 += '<input type="text" id="roomno10" value="'+data[0].ro_name10+'" />';
			}
			
			$("#mp212 ul").html(tag);
			$("#menuroo").html(tag2);
			
			menuDisabled();
			
		},error: function(req, text){
			alert(text + " : " + req.status);
		}
	});
}

function menuDisabled(){
	if($("#menuroo input").length >= 9){
		$("#roomplus").addClass("disabled");
		$("#roomplus").prop("click",null).off("click");
	} else {
		$("#roomplus").removeClass("disabled");
		$("#roomplus").prop("click",null).on("click");
	}
};

function menuForm(){
	$("#no").val("");
	$("#pla").val("");
	$("#menuroo").html("");
	$("#menuroo").html('<input type="text" id="roomno1" />');
	$("#pla").focus();
}

function menuSave(){
	var oData = new Object();
	oData.shop_id = ($("#no").val() == "" ? 0 : $("#no").val());
	oData.shop_place = $("#pla").val();
	oData.ro_name1 = $("#roomno1").val();
	oData.ro_name2 = $("#roomno2").val();
	oData.ro_name3 = $("#roomno3").val();
	oData.ro_name4 = $("#roomno4").val();
	oData.ro_name5 = $("#roomno5").val();
	oData.ro_name6 = $("#roomno6").val();
	oData.ro_name7 = $("#roomno7").val();
	oData.ro_name8 = $("#roomno8").val();
	oData.ro_name9 = $("#roomno9").val();
	oData.ro_name10 = $("#roomno10").val();
	
	var menu = JSON.stringify(oData);
	
	$.ajax({
        url : 'shopSave',
        type : 'POST',
        headers : {
          'Content-Type' : 'application/json',
          'X-HTTP-Method-Override' : 'POST'
        },      
        data : menu,
        dataType : "text", // 
        success : function(e) {
          alert("저장 하였습니다.");
          location.reload();
        },
        error : function(req, text) {
        	alert(text + " : " + req.status);
        }
      });
};


function menuDelete(){
	var oData = new Object();
	oData.shop_id = $("#no").val()
	
	var data = JSON.stringify(oData);
	
	$.ajax({
		url : 'shopDelete',
		type : 'DELETE',
		headers : {
			'Content-Type' : 'application/json',
			'X-HTTP-Method-Override' : 'DELETE'
		},
		data : data,
		dataType : "text", // 
		success : function(e) {
			alert("삭제하였습니다.");
			location.reload();
		},
		error : function(req, text) {
        	alert(text + " : " + req.status);
        }
	});
	
}


function fileupload(){
	var index = 0;
	$("#input_imgs").on("change", handleImgsFilesSelect);
	
	function handleImgsFilesSelect(e){
		sel_files = [];
		
		var files = e.target.files;
		
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("확장자는 이미지 확장자만 가능합니다.");
				return;
			}
			sel_files.push(f);
			
			
			var reader = new FileReader();
			reader.onload = function(e){
				var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImage("+index+")\" id=\"img_id_"+index+"\"><img src=\""+e.target.result+"\" data-file='"+f.name+"' class='selProductFile' title='클릭시 삭제'></a>";
				$(".imgs_wrap").append(html);
				index++;
			}
			
			reader.readAsDataURL(f);
			
		});
		
	}
}

function deleteImage(index){
	sel_files.splice(index, 1);
	
	var img_id = "#img_id_"+index;
	$(img_id).remove();
}


 function imgSubmit(){
	var formData = new FormData();

	for(var i=0; i<sel_files.length; i++){
		var name = "image"+i;
		formData.append(name, sel_files[i]);
	}
	formData.append("image_count", sel_files.length);
	
	console.log(input_imgs.files)
	
    $.ajax({
        url : '/imageupload',
        type : 'POST',
        enctype : 'multipart/form-data',
        processData : false,
        contentType : false,
        cache : false,
        timeout : 600000,
        dataType : 'JSON',
        data : formData,
        success : function(result) {
                alert('이미지 업로드 성공');
        },
		error : function(req, text) {
        	alert(text + " : " + req.status);
        }
    });
} 





var place = $(".place option:selected").val();
var date = $("#datepicker").val();
var time = $(".timepicker").val();
var place2 = $(".place2 option:selected").val();
var object = $(".object option:selected").val();
</script>



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
   
	
	//장소 목록
	shop_list();
 	room_list(1);
 	room_list2(1);
 	
	$(".place").on('change', function(){
	    var shop_id = $(this).val();
	    room_list(shop_id);
	});
	$("#roomno1").css({"margin-top":"0px","margin-left":"0px","width":"184px"});
	$("#roomplus").css({"margin-top":"-30px","margin-left":"15px","border-radius":"50%","font-size":"35px","width":"25px","height":"25px","line-height":"19px","text-align":"center","background":"#ff4d4d"});
	
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


var place = $(".place option:selected").val();
var date = $("#datepicker").val();
var time = $(".timepicker").val();
var place2 = $(".place2 option:selected").val();
var object = $(".object option:selected").val();


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
				str += '<li onclick="menuManage('+value.shop_id+');" value='+value.shop_id+'>'+value.shop_place+'</li>';
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
			$.each(data, function(key, value){
				tag += '<option>'+value.room_no+'</option>';
			});
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
			$.each(data, function(key, value){
				tag += '<li>'+value.room_no+'</li>';
			});
			$("#mp212 ul").html(tag);
			
			
			
		},error: function(req, text){
			alert(text + " : " + req.status);
		}
	});
}


function menuManage(n){
	room_list2(n);
	$("#no").val(n);
	
	$("#mp211 li").each(function(index){
		$(this).removeClass("selecte");
		
		$(this).on("click",function(e){
			$("#roomplus").removeClass("disabled");
			$("#roomplus").prop("click",null).on("click");
			e.preventDefault();
			$(this).addClass("selecte");
			var place = $(this).html();
			$("#pla").val(place);
			
			$("#menuroo").html("");
			var tag = ""
			$("#mp212 li").each(function(index){
				tag += '<input type="text" id="roomno'+(index+2)+'" value="'+$(this).html()+'" />';
			});
			$("#menuroo").append(tag);
				
		});
	});
	
}

var total = 0;
$("#roomplus").on("click", function(){
	total += $("#mp212 li").length;
	console.log(total);
	if($("#menuroo input").length >= 9){
		$("#roomplus").addClass("disabled");
		$("#roomplus").prop("click",null).off("click");
	} else {
		$("#roomplus").removeClass("disabled");
		$("#roomplus").prop("click",null).on("click");
	}

	total++;
	console.log(total);
	var tag = '<input type="text" id="roomno'+(total+1)+'" />';
	console.log(total);	
	$("#menuroo").append(tag);
});


$("#placemanage").on('click',function(){
	
	/*var place = $("#pla").val();
	$("#mp212 li").each(function(index){
	});
	var data = {}
	
	$.ajax({
        url : 'roomList',
        type : 'POST',
        headers : {
          'Content-Type' : 'application/json',
          'X-HTTP-Method-Override' : 'POST'
        },      
        data : JSON.stringify(data),
        dataType : "text", // 
        success : function(e) {
          toast("저장 하였습니다.");
        },
        error : function(req, text) {
        	alert(text + " : " + req.status);
        },
        complete : function(xhr, textStatus) {
        }
      });  */
});
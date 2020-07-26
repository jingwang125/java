//입력이 다 되어야 저장 버튼이 눌려 data 전송이 되게 처리
function checkInput(){
	var need = true;
	$('.need').each(function(){
		if ( $(this).val().trim()=='' ){	//공백도 입력이 안된걸로 처리 : trim()
			alert( $(this).attr('title') + '을 입력하세요!');
			$(this).val('');
			$(this).focus();
			need = false;
			return need;
		}
	});
	return need;	//안 걸리면 true를 리턴
}
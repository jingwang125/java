var join_validator = {
	common: {
		empty: { code: 'empty', desc: '입력하세요'},
		space: { code: 'space', desc: '공백없이 입력하세요'},
		min: { code: 'min', desc: '최소 5자 이상'},
		max: { code: 'max', desc: '최대 10자 이하'}
	},
	userid_status: function(val){
		var space = /\s/g;	//g : 전체에서
		var reg = /[^a-z0-9]/g;		// ^: not
		if( val=='' ){	//입력한 값이 없으면
			return this.common.empty;
		}else if( val.match(space) ){
			return this.common.space;
		}else if( reg.test(val) ){
			return this.userid.invalid;
		}else if( val.length<5 ){
			return this.common.min;
		}else if( val.length>10 ){
			return this.common.max;
		}else {
			return this.userid.valid;
		}
	},
	userid: {
		valid: { code: 'valid', desc: '아이디 중복여부를 확인하세요' },
		invalid: { code: 'invalid', desc: '영문 소문자, 숫자만 입력하세요' },
		usable: { code: 'usable', desc: '사용가능한 아이디입니다' },
		unusable: { code: 'unusable', desc: '이미 사용중인 아이디입니다'}
	},
	userid_usable: function(val){
		if( val=='true' ){
			return this.userid.usable;
		}else {
			return this.userid.unusable;
		}
	},
	
	//패스워드
	userpwd_status: function(val){
		var space = /\s/g;
		var reg = /[^a-zA-Z0-9]/g;
		var upper = /[A-Z]/g, lower = /[a-z]/g, digit = /[0-9]/g;
		if( val==''){
			return this.common.empty;
		}else if ( val.match(space) ){
			return this.common.space;
		}else if ( reg.test(val) ){
			return this.userpwd.invalid;
		}else if ( val.length<5 ){
			return this.common.min;
		}else if (val.length>10){
			return this.common.max;
		}else if ( !upper.test(val) ){	//이게 없으면
			return this.userpwd.upperlack;
		}else if ( !lower.test(val) ){
			return this.userpwd.lowerlack;
		}else if ( !digit.test(val) ){
			return this.userpwd.digitlack;
		}else {
			return this.userpwd.valid;
		}
	},
	userpwd: {
		valid: { code: 'valid', desc: '사용 가능한 비밀번호' },
		invalid: { code: 'invalid', desc: '영문 대/소문자, 숫자만 입력' },
		upperlack: { code: 'lack', desc: '영문 대문자를 입력' },
		lowerlack: { code: 'lack', desc: '영문 소문자를 입력' },
		digitlack: { code: 'lack', desc: '숫자를 입력' },
		equal: { code: 'valid', desc: '비밀번호 일치' },
		notequal: { code: 'invalid', desc: '비밀번호 불일치' }
	},
	userpwd_ck_status: function(val, userpwd){
		if( val=='' ){
			return this.common.empty;
		}else if( val == userpwd ){
			return this.userpwd.equal;
		}else {
			return this.userpwd.notequal;
		}
	},
	
	//이메일
	email_status: function(val){
		var reg = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		if( val=='' )				return this.common.empty;
		else if( reg.test(val) )	return this.email.valid;
		else						return this.email.invalid;
	},
	email: {
		valid: { code: 'valid', desc: '사용가능한 이메일' },
		invalid: { code: 'invalid', desc: '이메일 형식이 올바르지 않습니다' }
	}
		
}
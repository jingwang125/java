package com.hanul.smart;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonService;
import member.MemberService;
import member.MemberVO;

@Controller
public class MemberController {
//	@Autowired @Qualifier("member.service") private MemberService service;
	@Resource(name = "member.service") private MemberService service;
	@Autowired private CommonService common;

	//회원가입 화면 요청
	@RequestMapping("/member")
	public String member() {
		return "member/join";
	}
	
	//userid 중복확인
	@ResponseBody @RequestMapping("/id_usable")	//이 자체가 응답이 되는 annotation : @ResponseBody
	public String id_usable(String userid) {
		service.userid_usable(userid);
		return String.valueOf(service.userid_usable(userid));	//문자로 만들어 반환(true/false로 반환됨)
	}
	
	//회원가입 처리 요청
	@ResponseBody @RequestMapping(value="/join", produces="text/html; charset=utf-8")	//@ResponseBody → 이 자체가 응답!
	public String join(MemberVO vo, HttpServletRequest request) {
		StringBuffer msg = new StringBuffer("<script type='text/javascript'>");
		if ( service.member_insert(vo) ) {	//회원가입 성공했을 때
			common.emailSend(vo.getName(), vo.getEmail(), request);
			msg.append("alert('회원가입을 축하합니다!'); location='home'");
		}else {	//회원가입 실패했을 때
//			msg.append("alert('회원가입 실패..ㅠㅠ'); location='member'");
			msg.append("alert('회원가입 실패..ㅠㅠ'); history.go(-1)");
		}
		msg.append("</script>");
		return msg.toString();
	}
	
	//로그인 처리 요청
	@ResponseBody @RequestMapping("/login")
	public boolean login(String userid, String userpwd, HttpSession session) {
		MemberVO vo = service.member_login(userid, userpwd);
		session.setAttribute("login_info", vo);
		return vo==null ? false : true;
	}
	
	//로그아웃 처리 요청
	@ResponseBody @RequestMapping("/logout")
	public void logout(HttpSession session) {
		session.removeAttribute("login_info");
	}
}

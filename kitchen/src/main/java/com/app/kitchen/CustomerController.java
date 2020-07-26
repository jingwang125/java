package com.app.kitchen;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import customer.CustomerService;
import customer.CustomerVO;

@Controller
public class CustomerController {

	@Resource(name = "customer.service")
	private CustomerService service;

	// 로그인 처리
	@ResponseBody
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public boolean customerLogin(String id, String pw, HttpSession session) throws Exception {
		CustomerVO vo = (CustomerVO) service.customerLogin(id, pw);
		session.setAttribute("login_info", vo);
		return vo == null ? false : true;
	}

	// 로그아웃 처리 요청
	@ResponseBody
	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public void logout(HttpSession session) {
		session.removeAttribute("login_info");
	}

	// userid 중복확인
	@ResponseBody // 이 자체가 응답이 되는 annotation : @ResponseBody
	@RequestMapping(value = "id_usable", method = RequestMethod.POST)
	public String id_usable(String id) {
		service.userid_usable(id);
		return String.valueOf(service.userid_usable(id)); // 문자로 만들어 반환(true/false로 반환됨)
	}

	// 회원가입
	@RequestMapping(value = "customerjoin", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> customerJoin(@RequestBody CustomerVO vo) {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("id",vo.getId());
			map.put("pw",vo.getPw());
			map.put("name",vo.getName());
			map.put("gender",vo.getGender());
			map.put("phone",vo.getPhone());
			map.put("email",vo.getEmail());
			service.customerJoin(map);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errors", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
}

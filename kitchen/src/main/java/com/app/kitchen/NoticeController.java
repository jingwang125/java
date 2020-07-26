package com.app.kitchen;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class NoticeController {
	

	//메뉴 화면 로딩
		@RequestMapping(value = "/notice.re", method = RequestMethod.GET)
		public String formGetPage(@RequestParam Map<String, Object> commandMap, Model model) {
			model.addAttribute("commandMap", commandMap);
			return "notice/notice";
		}
	
}

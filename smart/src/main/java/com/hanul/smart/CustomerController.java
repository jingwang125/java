package com.hanul.smart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import customer.CustomerServiceImpl;
import customer.CustomerVO;

@Controller
public class CustomerController {

	@Autowired private CustomerServiceImpl service;
	
	//Controller -> Service -> DAO -> mapper
	
	//고객 목록화면 요청
	@RequestMapping("/list.cu")
	public String list(Model model) {
		model.addAttribute("list", service.customer_list());
		return "customer/list";
	}
	
	//고객 상세화면 요청
	@RequestMapping("/detail.cu")
	public String detail(Model model, int id) {
		//해당 고객정보를 조회해와
		//화면에 출력할 수 있도록 Model 에 담는다.
		model.addAttribute("vo", service.customer_detail(id));
		return "customer/detail";
	}
	
	//고객 수정화면 요청
	@RequestMapping("/modify.cu")
	public String modify(int id, Model model) {
		//해당 고객정보를 조회해와
		//화면에 출력할 수 있도록 Model 에 담는다.
		model.addAttribute("vo", service.customer_detail(id));
		return "customer/modify";
	}
	
	//고객정보 수정처리 요청
	@RequestMapping("/update.cu")
	public String update(CustomerVO vo) {
		//화면에서 입력한 정보를 DB에 변경저장
		service.customer_update(vo);
		return "redirect:detail.cu?id=" + vo.getId();
	}
	
	//신규고객 등록화면 요청 - 화면만 연결하면 돼서 처리할 비즈니스 로직이 없음
	@RequestMapping("/new.cu")
	public String customer() {
		return "customer/new";
	}
	
	//신규고객 등록처리 요청
	@RequestMapping("/insert.cu")
	public String insert(CustomerVO vo) {
		//화면에서 입력한 정보를 DB에 신규저장 처리
		service.customer_insert(vo);
		//목록화면으로 연결
		return "redirect:list.cu";
	}
	
	//고객 삭제처리 요청
	@RequestMapping("/delete.cu")
	public String delete(int id) {
		//선택한 고객정보를 DB에서 삭제한 후
		service.customer_delete(id);
		//목록화면으로 연결
		return "redirect:list.cu";
	}
}

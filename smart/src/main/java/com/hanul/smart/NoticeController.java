package com.hanul.smart;

import java.io.File;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import common.CommonService;
import member.MemberVO;
import notice.NoticePageVO;
import notice.NoticeServiceImpl;
import notice.NoticeVO;

@Controller
public class NoticeController {
	@Autowired private NoticeServiceImpl service;	//@Autowired: 주소를 주입시킴(데이터 타입으로 찾아가는)
	@Autowired private NoticePageVO page;
	@Autowired private CommonService common;
	
	
	
	//공지글 목록 화면 요청
	@RequestMapping("/list.no")
	public String list(Model model,
					  @RequestParam(required=false) String search,
					  @RequestParam(defaultValue = "") String keyword,
					  @RequestParam(defaultValue = "1") int curPage) {//@Request ~~ :default로 1페이지를 불러오는 처리

		page.setSearch(search==null ? "" : search);
		page.setKeyword(keyword);
		page.setCurPage(curPage);
		model.addAttribute( "page", service.notice_list(page) );
		return "notice/list";
	}
	
	//공지글 목록 화면 요청
	@RequestMapping("/rlist.no")
	public String list(
					@ModelAttribute("search") String search,
					@ModelAttribute("keyword") String keyword,
					@ModelAttribute("curPage") int curPage,
					Model model) {
		page.setSearch(search==null ? "" : search);
		page.setKeyword(keyword);
		page.setCurPage(curPage);
		model.addAttribute( "page", service.notice_list(page) );
		return "notice/redirect";
	}
	
	//새 글쓰기 화면 요청
	@RequestMapping("/new.no")
	public String notice() {
		return "notice/new";
	}
	
	//공지글 저장처리 요청
	@RequestMapping("/insert.no")
	public String insert(MultipartFile file, NoticeVO vo, HttpSession ss) {
		if( file.getSize() > 0) {	//첨부된 파일이 있으면
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload(file, ss, "notice"));
		}
		vo.setWriter( ((MemberVO)ss.getAttribute("login_info")).getUserid() );
		service.notice_insert(vo);
		return "redirect:list.no";
	}
	
	//공지글 상세화면 요청
	@RequestMapping("/detail.no")
	public String detail(@ModelAttribute("id") int id, Model model) {
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		//조회수 증가 처리
		service.notice_read(id);
		model.addAttribute("page", page);
		model.addAttribute("vo", service.notice_detail(id) );	//vo : service.notice_detail()의 데이터를 담을 이름
		return "notice/detail";
	}
	
	//첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.no")
	public File download(int id, HttpSession ss, HttpServletResponse response) {
		NoticeVO vo = service.notice_detail(id);
		return common.fileDownLoad(vo.getFilename(), vo.getFilepath(), ss, response);
	}
	
	//공지글 수정화면 요청
	@RequestMapping("/modify.no")
	public String modify(int id, Model model) {
		model.addAttribute("vo", service.notice_detail(id));
		return "notice/modify";
	}
	
	//공지글 수정 처리 요청
	@RequestMapping("/update.no")
	public String update(int attach, NoticeVO vo, MultipartFile file, RedirectAttributes redirect, HttpSession ss, Model model) {
		
		NoticeVO old = service.notice_detail(vo.getId());
		String uuid = ss.getServletContext().getRealPath("resources") + File.separator + old.getFilepath();//UUid가 붙은 original 이름
		
		//첨부파일 있는 경우
		if ( file.getSize()>0 ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload(file, ss, "notice") );
			
			//변경 전 첨부된 파일이 있으면 삭제한다.
			File f = new File(uuid);
			if( f.exists() ) {
				f.delete();
			}
		}else {
			
			if( attach==0 ) {
				//변경 전 첨부된 파일이 있으면 삭제한다.
				File f = new File(uuid);
				if( f.exists() ) {
					f.delete();
				}
			}else {
				//변경전 첨부된 파일이 있으면 그 파일정보를 담는다
				vo.setFilename(old.getFilename());
				vo.setFilepath(old.getFilepath());
			}
		}
		
		service.notice_update(vo);
		//post 방식으로 데이터를 redirect 시 보내려면
//		redirect.addFlashAttribute("id", vo.getId());
//		return "redirect:detail.no";
		model.addAttribute("id", vo.getId());
		model.addAttribute("view", "detail");
		model.addAttribute("page", page);
		return "notice/redirect";
	}
	
	//공지글 삭제 처리 요청
	@RequestMapping("/delete.no")
	public String delete(int id, RedirectAttributes redirect) {
		service.notice_delete(id);
		
		redirect.addFlashAttribute("curPage", page.getCurPage());
		redirect.addFlashAttribute("search", page.getSearch());
		redirect.addFlashAttribute("keyword", page.getKeyword());
		return "redirect:rlist.no";
	}
	
}
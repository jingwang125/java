package com.hanul.smart;

import java.io.File;
import java.util.HashMap;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import common.CommonService;
import event.CommentVO;
import event.EventPageVO;
import event.EventServiceImpl;
import event.EventVO;
import member.MemberVO;

@Controller
public class EventController {
	@Autowired private EventPageVO page;
	@Autowired private EventServiceImpl service;
	@Autowired private CommonService common;
	
	//행사안내 수정처리 요청
	@RequestMapping("/update.ev")
	public String update(EventVO vo, int delete,
			HttpSession ss, Model model,
			MultipartFile file) {
		EventVO old = service.event_detail( vo.getId() );
		String uuid = ss.getServletContext().getRealPath("resources")
			+ old.getFilepath(); 
		if( file.getSize()>0 ) {
			//파일을 첨부하는 경우
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( 
				common.fileUpload(file, ss, "event"));
			//원래 첨부된 파일을 바꿔 첨부하는 경우
			//원래 첨부된 파일을 삭제한다.
			File f = new File( uuid );
			if( f.exists() ) f.delete();
			
		}else {
			//파일첨부하지 않는 경우		
			if( delete != 1 ) {
				//1.원래 첨부된 파일을 그대로 사용하는 경우
				vo.setFilename( old.getFilename() );
				vo.setFilepath( old.getFilepath() );
			}else {
				//2.원래 첨부된 파일을 삭제하는 경우
				//원래 첨부된 파일을 삭제한다.
				File f = new File( uuid );
				if( f.exists() ) f.delete();
			}
		}
		service.event_update(vo);
		model.addAttribute("id", vo.getId());
		return "event/redirect";
	}
	
	
	//행사안내 수정화면 요청
	@RequestMapping("/modify.ev")
	public String modify(int id, Model model) {
		model.addAttribute("vo",
				service.event_detail(id) );
		return "event/modify";
	}
	
	
	//행사안내 삭제처리 요청
	@RequestMapping("/delete.ev")
	public String delete(int id) {
		service.event_delete(id);
		return "redirect:list.ev";
	}
	
	//첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.ev")	
	public File download(int id, HttpSession ss, HttpServletResponse response) {
		EventVO vo = service.event_detail(id);
		return common.fileDownLoad(	vo.getFilename(), vo.getFilepath(),	ss, response);
	}
	
	//행사안내 상세화면 요청
	@RequestMapping("/detail.ev")
	public String detail(int id, 
			@RequestParam(defaultValue = "false") boolean read, Model model) {
		if( read ) {
			service.event_read(id);
			model.addAttribute("id", id);
			return "event/redirect";
		}else {
			model.addAttribute("page", page);
			model.addAttribute("vo", service.event_detail(id));
			model.addAttribute("crlf", "\r\n");
			return "event/detail";
		}
	}
	
	//신규행사안내 저장처리 요청
	@RequestMapping("/insert.ev")
	public String insert(EventVO vo, HttpSession ss, 
			MultipartFile file) {
		//첨부파일이 있는 경우 
		if( file.getSize()>0 ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( 
				common.fileUpload(file, ss, "event") );
		}
		vo.setUserid( 
			((MemberVO)ss.getAttribute("login_info")).getUserid() );
		service.event_insert(vo);
		return "redirect:list.ev";
	}
	
	
	//신규행사안내작성 화면 요청
	@RequestMapping("/new.ev")
	public String event() {
		return "event/new";
	}
	
	//행사안내목록 화면 요청
	@RequestMapping("/list.ev")
	public String list(Model model,
		@RequestParam(defaultValue="1") int curPage,
		@RequestParam(defaultValue="") String search,
		@RequestParam(defaultValue="") String keyword) {
		
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		model.addAttribute("page",
				service.event_list(page) );
		return "event/list";
	}
	
	//행사안내 댓글 저장처리 요청
	@ResponseBody @RequestMapping("/event/comment/insert")
	public boolean comment_insert(HttpSession ss, int pid, String content) {
		HashMap<String, Object> map = new HashMap<String, Object>();	//원래는 String 타입이지만 int 타입까지 다 담기 위해 Object 타입으로 바꿈
		map.put("pid", pid);
		map.put("content", content);
		map.put("userid", ((MemberVO)ss.getAttribute("login_info")).getUserid() );
		return service.event_comment_insert(map);
	}
	
	//행사안내 댓글 목록 요청
	@RequestMapping("/event/comment/{pid}")
	public String comment_list(Model model, @PathVariable int pid) {	//{pid}가 경로의 형태라서 PathVariable
		model.addAttribute("list", service.event_comment_list(pid) );
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("lf", "\n");
		return "event/comment/list";
	}
	
	//행사안내 댓글 삭제처리 요청
	@ResponseBody @RequestMapping("/event/comment/delete/{id}")
	public void comment_delete(@PathVariable int id) {
		service.event_comment_delete(id);
//		return "";  //반환할 데이터가 없으므로 return 없어지고 void타입으로 바뀜
	}
	
	//행사안내 댓글 변경 저장처리 요청
	@ResponseBody @RequestMapping(value= "/event/comment/update", produces="application/text; charset=utf-8")	//produces: 성공/실패의 alert의 한글깨짐처리
	public String comment_update(@RequestBody CommentVO vo) {	//json으로 받으려면 @RequestBody 필요
		return service.event_comment_update(vo) ? "성공" : "실패";
	}
}
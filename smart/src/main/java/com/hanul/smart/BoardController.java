package com.hanul.smart;

import java.io.File;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import board.BoardPageVO;
import board.BoardServiceImpl;
import board.BoardVO;
import common.CommonService;
import member.MemberVO;

@Controller
public class BoardController {
	@Autowired private BoardPageVO page;
	@Autowired BoardServiceImpl service;
	@Autowired private CommonService common;
	
	//게시글 목록화면 요청
	@RequestMapping("/list.bo")
	public String list(Model model, 
					   @RequestParam(defaultValue = "1") int curPage,
					   @RequestParam(defaultValue = "") String search,
					   @RequestParam(defaultValue = "") String keyword) {
		
		page.setCurPage(curPage);
		page.setSearch(search);
		page.setKeyword(keyword);
		
		model.addAttribute( "page", service.board_list(page) );
		return "board/list";
	}
	
	//신규 게시글 작성화면 요청
	@RequestMapping("/new.bo")
	public String board() {
		return "board/new";
	}
	
	//신규 게시글 저장처리 요청
	@RequestMapping("/insert.bo")
	public String insert(BoardVO vo, HttpSession ss, MultipartFile file) {
		//첨부파일이 있는 경우
		if( file.getSize()>0 ) {
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload(file, ss, "board"));
		}
		vo.setWriter( ((MemberVO)ss.getAttribute("login_info")).getUserid() );
		service.board_insert(vo);
		return "redirect:list.bo";
	}
	
	//게시글 상세화면 요청
	@RequestMapping("/detail.bo")
	public String detail(int id, Model model) {
		service.board_read(id);
		model.addAttribute("vo", service.board_detail(id));
		model.addAttribute("crlf", "\r\n");
		model.addAttribute("page", page);
		return "board/detail";
	}
	
	//첨부파일 다운로드 요청
	@ResponseBody @RequestMapping("/download.bo")
	public File download(int id, HttpSession ss, HttpServletResponse response) {
		BoardVO vo = service.board_detail(id);
		return common.fileDownLoad(vo.getFilename(), vo.getFilepath(), ss, response);
	}
	
	//게시글 삭제처리 요청
	@RequestMapping("/delete.bo")
	public String delete(int id) {
		service.board_delete(id);
		return "redirect:list.bo";
	}
	
	//게시글 수정화면 요청
	@RequestMapping("/modify.bo")
	public String modify(int id, Model model) {
		model.addAttribute("vo", service.board_detail(id));
		return "board/modify";
	}
	
	//게시글 수정처리 요청
	@RequestMapping("/update.bo")
	public String update(BoardVO vo, MultipartFile file, HttpSession ss, Model model, int delete) {
		BoardVO old = service.board_detail( vo.getId() );
		String uuid = ss.getServletContext().getRealPath("resources") + old.getFilepath();
		if( file.getSize()>0 ) {
			//파일을 첨부하는 경우
			vo.setFilename( file.getOriginalFilename() );
			vo.setFilepath( common.fileUpload(file, ss, "board"));
			
			//원래 첨부된 파일을 바꿔 첨부하는 경우
			//원래 첨부된 파일을 삭제한다.
			File f = new File( uuid );
			if ( f.exists() ) f.delete();
		}else {
			//파일을 첨부하지 않는 경우
			if( delete != 1) {
				//1. 원래 첨부된 파일을 그대로 사용하는 경우
				vo.setFilename( old.getFilename() );
				vo.setFilepath( old.getFilepath() );
			} else {
				//2. 원래 첨부된 파일을 삭제하는 경우
				//원래 첨부된 파일을 삭제한다.
				File f = new File( uuid );
				if ( f.exists() ) f.delete();
			}
		}
		service.board_update(vo);
		model.addAttribute("id", vo.getId());
		return "board/redirect";
	}
	
	//답글 작성화면 요청
	@RequestMapping("/reply.bo")
	public String reply(int id, Model model) {
		model.addAttribute( "vo", service.board_detail(id) );
		return "board/reply";
	}
	
	//답글 저장처리 요청
	@RequestMapping("/reply_insert.bo")
	public String reply_insert(BoardVO vo, HttpSession ss) {
		vo.setWriter( ((MemberVO)ss.getAttribute("login_info")).getUserid() );
		service.board_reply_insert(vo);
		return "redirect:list.bo";
	}
}
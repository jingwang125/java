package common;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.mail.Email;
import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;
import org.apache.commons.mail.MultiPartEmail;
import org.apache.commons.mail.SimpleEmail;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

@Service
public class CommonServiceImpl implements CommonService {

	@Override
	public void emailSend(String name, String email, HttpServletRequest request) {
		//1. 기본형태 이메일 전송
		//simpleSend(name, email);
		
		//2. 파일첨부 가능 이메일 전송
		//attachSend(name, email, request);
		
		//3. Html 태그형식의 이메일 전송
		htmlSend(name, email, request);
	}
	
	//이메일 보내기 기본 형태
	private void simpleSend(String name, String email) {
		SimpleEmail mail = new SimpleEmail();
//		mail.setHostName("smtp.naver.com");
//		mail.setCharset("utf-8");
//		mail.setDebug(true);
//		
//		mail.setAuthentication("dlagusgh91", "gjrjejd55%");
//		mail.setSSLOnConnect(true);	//로그인 버튼 클릭하는 행위
		
		try {
//			mail.setFrom("dlagusgh91@naver.com", "관리자");	//보내는사람
//			mail.addTo(email, name);	//받는사람
			
			setProperties(mail, name, email);
			
			mail.setSubject("스마트 웹&앱 개발자과정 참여자");		//제목
			mail.setMsg("회원가입을 축하합니다!");
			mail.send();	//메일 보내기버튼
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	//2. 파일첨부 가능 이메일 전송
	private void attachSend(String name, String email, HttpServletRequest request) {
		MultiPartEmail mail = new MultiPartEmail();
		try {
			setProperties(mail, name, email);

			mail.setSubject("스마트 웹&앱 파일첨부 확인");
			mail.setMsg("회원가입을 축하하며 파일을 첨부해드립니다!<br>파일을 확인 해주세요용용용");
			
			EmailAttachment file = new EmailAttachment();	//첨부파일 객체 생성
			file.setPath( request.getSession().getServletContext().getRealPath("resources/images/hanul.png"));
			mail.attach(file);
			mail.send();
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	
	//매번 하기 번거로우니 메소드 만들어 호출하자
	private void setProperties(Email mail, String name, String email) throws Exception {
		mail.setHostName("smtp.naver.com");
		mail.setCharset("utf-8");
		mail.setAuthentication("dlagusgh91", "gjrjejd55%");
		mail.setSSLOnConnect(true);
		
		mail.setFrom("dlagusgh91@naver.com", "또노임다");
		mail.addTo(email, name);
	}

	//3. Html 태그형식의 이메일 전송
	private void htmlSend(String name, String email, HttpServletRequest request) {
		HtmlEmail mail = new HtmlEmail();
		try {
			setProperties(mail, name, email);
			mail.setSubject("제목을 입력해줍니당당");
			
			StringBuffer content = new StringBuffer("<html>");
			content.append("<body>");
			content.append("<h2>회원가입 축하 합니다람쥐!</h2>");
			content.append("<a href='http://hanuledu.co.kr'>한울 과정보기</a>");
			content.append("스마트 웹&앱 과정 입니다 ㅎㅎ<br>");
			content.append("가입을 축하합니다!<br>");
			content.append("<input type='button' value='확인@!!' onclick='alert(\"잘 되나?\")'/>");
			content.append("</body>");
			content.append("</html>");
			mail.setHtmlMsg(content.toString());	//객체니까 문자화 시켜야 함
			
			EmailAttachment file = new EmailAttachment();
			file.setPath( request.getSession().getServletContext().getRealPath("resources/images/hanul.logo.png"));
			
			mail.attach(file);
			mail.send();	
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	@Override
	public String fileUpload(MultipartFile file, HttpSession ss, String category) {

		//업로드 할 서버의 물리적 위치
		//D://Spring/..../smart/resources
		String resources = ss.getServletContext().getRealPath("resources");
		//D://Spring/..../smart/resources/upload
		String upload = resources + File.separator + "upload";
		
		//D://Spring/..../smart/resources/upload/notice/2019/09/05
		String folder = makeFolder(category, upload);
		String uuid = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
		
		try {
			//생성한 폴더에 업로드한 파일 저장하기
			file.transferTo( new File(folder, uuid) );
		} catch (Exception e) {
		}
		// /upload/notice/2019/09/05/ff58523_abc.txt	내가 필요한 건 upload부터니까
		return folder.substring( resources.length() ) + File.separator + uuid;
	}
	
	private String makeFolder(String category, String upload) {
		StringBuffer folder = new StringBuffer(upload);
		//D://Spring/..../smart/resources/upload/notice
		folder.append(File.separator + category);
		Date now = new Date();
		//D://Spring/..../smart/resources/upload/notice/2019
		folder.append( File.separator + new SimpleDateFormat("yyyy/MM/dd").format(now) );
		
		//해당폴더가 있는지 확인하여 없으면 폴더생성
		File dir = new File( folder.toString() );
		if( !dir.exists() ) {
			dir.mkdirs();	//폴더가 여러개니까 mkdir이 아니라 mkdirs
		}
		return folder.toString();
	}
	
	@Override
	public File fileDownLoad(String name, String path, HttpSession ss, HttpServletResponse response) {
		//다운로드 할 파일생성
		File file = new File(ss.getServletContext().getRealPath("resources") + File.separator + path);
		String mime = ss.getServletContext().getMimeType(name);
		if( mime==null ) {
			mime = "application/octet-stream";
		}
		try {
	//		response.setContentType("text/html; charset=utf-8");
			response.setContentType(mime);
			
			//한글이 깨지지 않도록 처리
			name = URLEncoder.encode(name, "utf-8");
			response.setHeader("content-disposition", "attachment; filename=" + name);	//header에 지정
			ServletOutputStream out = response.getOutputStream();
			FileCopyUtils.copy(new FileInputStream(file), out);	//파일을 복사(in)해서 붙여넣는(out) FileCopyUtils class
			out.flush();	//바로 내려보내기
		} catch(Exception e) {}
		return file;
	}
}

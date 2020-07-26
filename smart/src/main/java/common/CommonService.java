package common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

public interface CommonService {
	//이메일 보내는 처리
	void emailSend(String name, String email, HttpServletRequest request);

	String fileUpload(MultipartFile file, HttpSession ss, String category);
	
	//응답받는건 파일을 받는 처리 void → File
	File fileDownLoad(String name, String path, HttpSession ss, HttpServletResponse response);
}

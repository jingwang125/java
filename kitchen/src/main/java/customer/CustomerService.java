package customer;

import java.util.Map;

public interface CustomerService {
	// 로그인
	CustomerVO customerLogin(String id, String pw) throws Exception;
	// 아이디 중복확인(이 아이디를 사용할 수 있다/없다 니까 boolean)
	boolean userid_usable(String id);
	//회원가입
	boolean customerJoin(Map<String, Object> map); 

}

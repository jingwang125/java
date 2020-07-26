package customer;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("customer.service")
public class CustomerServiceImpl implements CustomerService {

	@Autowired
	private CustomerDAO dao;
	//로그인
	@Override
	public CustomerVO customerLogin(String id, String pw) throws Exception {
		return dao.customerLogin(id, pw);
	}
	//아이디 중복확인
	@Override
	public boolean userid_usable(String id) {
		return dao.userid_usable(id);
	}
	//회원가입
	@Override
	public boolean customerJoin(Map<String, Object> map) {
		return dao.customerJoin(map);
	}

	

}

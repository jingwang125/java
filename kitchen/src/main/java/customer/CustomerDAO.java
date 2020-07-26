package customer;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CustomerDAO implements CustomerService {

	@Autowired
	private SqlSession sql;

	@Override
	public CustomerVO customerLogin(String id, String pw) throws Exception {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pw", pw);
		return sql.selectOne("customer.mapper.customerone", map);
	}

	@Override
	public boolean userid_usable(String id) {
		return (Integer)sql.selectOne("customer.mapper.usable", id) == 1 ? false : true;
		//1이면 이미 존재해서 사용할 수 없고 0이면 사용 가능
	}

	@Override
	public boolean customerJoin(Map<String, Object> map) {
		return sql.insert("customer.mapper.customerjoin", map) > 0 ? true : false;
	}

	
}

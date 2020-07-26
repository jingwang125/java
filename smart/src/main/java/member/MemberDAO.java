package member;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAO implements MemberService {
	@Autowired private SqlSession sql;	//쿼리문 실행객체

	@Override
	public boolean member_insert(MemberVO vo) {
		return sql.insert("member.mapper.join", vo) > 0 ? true : false;
	}

	@Override
	public MemberVO member_select(String userid) {
		return null;
	}

	@Override
	public MemberVO member_login(String userid, String userpwd) {
		HashMap<String, String> map = new HashMap<String, String>();	//HashMap은 파라미터가 key, value 두개!
		map.put("userid", userid);	//키와 value(data)를 담는다
		map.put("userpwd", userpwd);
		return sql.selectOne("member.mapper.login", map);	//sql.selectOne("", aaa) 식으로 파라미터를 두개 던질 수 없음(aaa 에..) 
															//	→ id, pwd 두개 던질 수 없다
	}

	@Override
	public boolean userid_usable(String userid) {
		return (Integer)sql.selectOne("member.mapper.usable", userid) == 1 ? false : true;
		//1이면 이미 존재해서 사용할 수 없고 0이면 사용 가능
	}

	@Override
	public boolean member_update(MemberVO vo) {
		return false;
	}

	@Override
	public boolean member_delete() {
		return false;
	}

}

package member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

//@Service @Qualifier("member.service")
@Service("member.service")
public class MemberServiceImpl implements MemberService {
	@Autowired private MemberDAO dao;
	
	@Override
	public boolean member_insert(MemberVO vo) {
		return dao.member_insert(vo);
	}

	@Override
	public MemberVO member_select(String userid) {
		return null;
	}

	@Override
	public MemberVO member_login(String userid, String userpwd) {
		return dao.member_login(userid, userpwd);
	}

	@Override
	public boolean userid_usable(String userid) {
		return dao.userid_usable(userid);
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

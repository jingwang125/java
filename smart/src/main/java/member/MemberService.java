package member;

public interface MemberService {
	//CRUD 설계
	boolean member_insert(MemberVO vo);	//회원가입
	MemberVO member_select(String userid);	//내정보 보기
	MemberVO member_login(String userid, String userpwd);	//로그인
	boolean userid_usable(String userid);	//아이디 중복확인(이 아이디를 사용할 수 있다/없다 니까 boolean)
	boolean member_update(MemberVO vo);	//내 정보변경(저장이 되었는지 여부확인이니까 boolean)
	boolean member_delete();	//회원탈퇴
}

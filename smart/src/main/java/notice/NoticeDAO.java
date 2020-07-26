package notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository	//메모리에 올려놓는 처리
public class NoticeDAO implements NoticeService {
	@Autowired private SqlSession sql;

	@Override
	public void notice_insert(NoticeVO vo) {
		sql.insert("notice.mapper.insert", vo);
	}

	@Override
	public NoticePageVO notice_list(NoticePageVO page) {
		//총 글의 개수에 따라 페이지 정보가 결정된다.
		page.setTotalList( (Integer)sql.selectOne("notice.mapper.totalCount", page) );
		List<NoticeVO> list = sql.selectList("notice.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public NoticeVO notice_detail(int id) {
		return sql.selectOne("notice.mapper.detail", id);
	}

	@Override
	public void notice_read(int id) {
		sql.update("notice.mapper.read", id);
	}

	@Override
	public void notice_update(NoticeVO vo) {
		sql.update("notice.mapper.update", vo);
	}

	@Override
	public void notice_delete(int id) {
		sql.delete("notice.mapper.delete", id);
	}

}

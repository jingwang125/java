package event;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EventDAO implements EventService {
	@Autowired private SqlSession sql;
	
	@Override
	public void event_insert(EventVO vo) {
		sql.insert("event.mapper.insert", vo);
	}

	@Override
	public EventPageVO event_list(EventPageVO page) {
		page.setTotalList( (Integer)sql.selectOne("event.mapper.totalCount", page) );
		List<EventVO> list = sql.selectList("event.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public EventVO event_detail(int id) {
		return sql.selectOne("event.mapper.detail", id);
	}

	@Override
	public void event_read(int id) {
		sql.update("event.mapper.read", id);
	}

	@Override
	public void event_update(EventVO vo) {
		sql.update("event.mapper.update", vo);
	}

	@Override
	public void event_delete(int id) {
		sql.delete("event.mapper.delete", id);
	}

	@Override
	public boolean event_comment_insert(HashMap<String, Object> map) {
		return sql.insert("event.mapper.comment_insert", map) > 0 ? true : false;
	}

	@Override
	public List<CommentVO> event_comment_list(int pid) {
		return sql.selectList("event.mapper.comment_list", pid);
	}

	@Override
	public boolean event_comment_delete(int id) {
		return sql.delete("event.mapper.comment_delete", id) >0 ? true : false;
	}

	@Override
	public boolean event_comment_update(CommentVO vo) {
		return sql.update("event.mapper.comment_update", vo) >0 ? true : false;
	}

}

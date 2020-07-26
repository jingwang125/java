package event;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EventServiceImpl implements EventService {
	@Autowired private EventDAO dao;
	
	@Override
	public void event_insert(EventVO vo) {
		dao.event_insert(vo);
	}

	@Override
	public EventPageVO event_list(EventPageVO page) {
		return dao.event_list(page);
	}

	@Override
	public EventVO event_detail(int id) {
		return dao.event_detail(id);
	}

	@Override
	public void event_read(int id) {
		dao.event_read(id);
	}

	@Override
	public void event_update(EventVO vo) {
		dao.event_update(vo);
	}

	@Override
	public void event_delete(int id) {
		dao.event_delete(id);
	}

	@Override
	public boolean event_comment_insert(HashMap<String, Object> map) {
		return dao.event_comment_insert(map);
	}

	@Override
	public List<CommentVO> event_comment_list(int pid) {
		return dao.event_comment_list(pid);
	}

	@Override
	public boolean event_comment_delete(int id) {
		return dao.event_comment_delete(id);
	}

	@Override
	public boolean event_comment_update(CommentVO vo) {
		return dao.event_comment_update(vo);
	}

}

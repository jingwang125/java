package event;

import java.util.HashMap;
import java.util.List;

public interface EventService {
	//CRUD
	void event_insert(EventVO vo);
	EventPageVO event_list(EventPageVO page);
	EventVO event_detail(int id);
	void event_read(int id);
	void event_update(EventVO vo);
	void event_delete(int id);
	
	boolean event_comment_insert(HashMap<String, Object> map);
	List<CommentVO> event_comment_list(int pid);
	boolean event_comment_delete(int id);
	boolean event_comment_update(CommentVO vo);
}

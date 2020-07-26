package board;

public interface BoardService {
	//CRUD
	void board_insert(BoardVO vo);
	BoardPageVO board_list(BoardPageVO page);
	BoardVO board_detail(int id);
	void board_read(int id);
	void board_update(BoardVO vo);
	void board_delete(int id);
	void board_reply_insert(BoardVO vo);
}

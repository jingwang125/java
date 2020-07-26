package board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired private BoardDAO dao;

	@Override
	public void board_insert(BoardVO vo) {
		dao.board_insert(vo);
	}

	@Override
	public BoardPageVO board_list(BoardPageVO page) {
		return dao.board_list(page);
	}

	@Override
	public BoardVO board_detail(int id) {
		return dao.board_detail(id);
	}

	@Override
	public void board_read(int id) {
		dao.board_read(id);
	}

	@Override
	public void board_update(BoardVO vo) {
		dao.board_update(vo);
	}

	@Override
	public void board_delete(int id) {
		dao.board_delete(id);
	}

	@Override
	public void board_reply_insert(BoardVO vo) {
		dao.board_reply_insert(vo);
	}

}

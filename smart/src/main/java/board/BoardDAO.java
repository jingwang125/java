package board;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements BoardService {
	@Autowired private SqlSession sql;

	@Override
	public void board_insert(BoardVO vo) {
		sql.insert("board.mapper.insert", vo);
	}

	@Override
	public BoardPageVO board_list(BoardPageVO page) {
		page.setTotalList( (Integer)sql.selectOne("board.mapper.totalCount", page) );
		List<BoardVO> list = sql.selectList("board.mapper.list", page);
		page.setList(list);
		return page;
	}

	@Override
	public BoardVO board_detail(int id) {
		return sql.selectOne("board.mapper.detail", id);
	}

	@Override
	public void board_read(int id) {
		sql.update("board.mapper.read", id);
	}

	@Override
	public void board_update(BoardVO vo) {
		sql.update("board.mapper.update", vo);
	}

	@Override
	public void board_delete(int id) {
		sql.delete("board.mapper.delete", id);
	}

	@Override
	public void board_reply_insert(BoardVO vo) {
		sql.insert("board.mapper.reply_insert", vo);
	}

}

package menu;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO implements ShopService {

	@Autowired
	private SqlSession sql;

	@Override
	public List<ShopVO> shop_list() {
		return sql.selectList("menu.mapper.shoplist");
	}

	@Override
	public List<ShopVO> room_list(Map<String, Object> commandMap) throws Exception {
		return sql.selectList("menu.mapper.roomlist", commandMap);
	}

	@Override
	public boolean setshop_list(Map<String, Object> map) throws Exception {
		return false;
	}

	public boolean insertshop(Map<String, Object> map) {
		return sql.insert("menu.mapper.insertshop", map) > 0 ? true : false;
		
	}
	
	public boolean updateshop(Map<String, Object> map) {
		return sql.update("menu.mapper.updateshop", map) > 0 ? true : false;
		
	}

	@Override
	public void shopDelete(ShopVO shopVo) throws Exception {
		sql.delete("menu.mapper.deleteshop", shopVo);
	}


}

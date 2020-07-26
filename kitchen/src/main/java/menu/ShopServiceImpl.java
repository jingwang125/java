package menu;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ShopServiceImpl implements ShopService {

	@Autowired
	private ShopDAO dao;

	@Override
	public List<ShopVO> shop_list() {
		return dao.shop_list();
	}

	@Override
	public List<ShopVO> room_list(Map<String, Object> commandMap) throws Exception {
		return dao.room_list(commandMap);
	}

	@Override
	public boolean setshop_list(Map<String, Object> map) throws Exception {
		 if(map.get("shop_id").equals(0) == true) {
			 dao.insertshop(map);
			 System.out.println("삽입");
		 }else {
			 dao.updateshop(map);
			 System.out.println("저장");
		 }
		return true;
	}

	@Override
	public void shopDelete(ShopVO shopVo) throws Exception {
		dao.shopDelete(shopVo);
		
	}

	


}

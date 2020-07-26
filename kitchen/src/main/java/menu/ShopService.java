package menu;

import java.util.List;
import java.util.Map;

public interface ShopService {
	//상점 목록 조회
	List<ShopVO> shop_list();
	
	//상점 목록 1개 조회
	public List<ShopVO> room_list(Map<String, Object> commandMap) throws Exception;

	boolean setshop_list(Map<String, Object> map) throws Exception;
	
	public void shopDelete(ShopVO shopVo) throws Exception;
	
}

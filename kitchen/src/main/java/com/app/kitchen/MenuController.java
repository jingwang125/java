package com.app.kitchen;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import menu.ShopServiceImpl;
import menu.ShopVO;

@Controller
public class MenuController {

	@Autowired
	private ShopServiceImpl service;
	
	//메뉴 화면 로딩
	@RequestMapping(value = "/menu.re", method = RequestMethod.GET)
	public String formGetPage(@RequestParam Map<String, Object> commandMap, Model model) {
		model.addAttribute("commandMap", commandMap);
		return "menu/menu";
	}
	
	//shop 전체 리스트 조회
	@RequestMapping(value = "shopList", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getShopList(@RequestParam Map<String, Object> commandMap) {

		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<ShopVO> list = service.shop_list();
			map.put("shopList", list);
			entity = new ResponseEntity<>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errors", e.getMessage());
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//shop 1개의 정보 조회
	@RequestMapping(value = "roomList", method = RequestMethod.GET)
	  public ResponseEntity<List<ShopVO>> getShopOneList(@RequestParam Map<String, Object> commandMap) {
	    ResponseEntity<List<ShopVO>> entity = null;
	    try {
	      entity = new ResponseEntity<>(service.room_list(commandMap), HttpStatus.OK);
	      
	    } catch (Exception e) {
	      e.printStackTrace();
	      entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	  }
	
	//shop 저장&수정 처리
	@RequestMapping(value = "shopSave", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> setShopList(@RequestBody ShopVO shopVo) {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("shop_id", shopVo.getShop_id());
			map.put("shop_place", shopVo.getShop_place());
			map.put("ro_name1", shopVo.getRo_name1());
			map.put("ro_name2", shopVo.getRo_name2());
			map.put("ro_name3", shopVo.getRo_name3());
			map.put("ro_name4", shopVo.getRo_name4());
			map.put("ro_name5", shopVo.getRo_name5());
			map.put("ro_name6", shopVo.getRo_name6());
			map.put("ro_name7", shopVo.getRo_name7());
			map.put("ro_name8", shopVo.getRo_name8());
			map.put("ro_name9", shopVo.getRo_name9());
			map.put("ro_name10", shopVo.getRo_name10());	
			service.setshop_list(map);
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errors", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	//로직은 언제나 Service에서 짜도록 하자.
    //중간실패시 rollback은 고려하지 않았음.
    @ResponseBody
    @RequestMapping(value="/imageupload", method=RequestMethod.POST)
    public int multiImageUpload(@RequestParam("files")List<MultipartFile> images) {
    	System.out.println("이미지"+images);
        long sizeSum = 0;
        for(MultipartFile image : images) {
            String originalName = image.getOriginalFilename();
        }
        
        return 0;
    }
    
    
	
	//shop 삭제 처리
	@RequestMapping(value = "shopDelete", method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> shopListDelete(@RequestBody ShopVO shopVo) {
		ResponseEntity<Map<String, Object>> entity = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			service.shopDelete(shopVo);
			map.put("result", "success");
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("errors", e.getMessage());
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.BAD_REQUEST);
		}
		return entity;
	}
	
	

}

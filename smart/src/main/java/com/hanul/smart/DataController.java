package com.hanul.smart;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import data.DataService;

@Controller
public class DataController {
	private String pharmacy_url = "http://apis.data.go.kr/B551182/pharmacyInfoService/getParmacyBasisList";
	private String serviceKey = "FPgj2NXbJw46TcGkmAfZEiYFDbxilys7KLjk3KaB7AfeJE00ZhPNM0M8unwbsI69fSmT8SNfVEimE6ZZ2U14hA%3D%3D";
	private String animal_url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc";
	
	@Autowired private DataService service;
	
	//공공데이터 목록 화면 요청
	@RequestMapping("/list.da")
	public String list() {
		return "data/list";
	}
	
	//약국 목록요청
	@ResponseBody @RequestMapping(value= "/data/pharmacy", produces="application/text; charset=utf-8")
	public String pharmacy_list() {
		StringBuilder url = new StringBuilder(pharmacy_url);
		url.append("?ServiceKey=" + serviceKey);
		url.append("&pageNo=1");
		url.append("&numOfRows=10");
		return service.xml_list(url);
	}
	
	//유기동물 시도 요청
	@ResponseBody @RequestMapping(value="/data/animal/sido", produces="application/text; charset=utf-8")
	public String animal_sido() {
		StringBuilder url = new StringBuilder(animal_url + "/sido");
		url.append("?ServiceKey=" + serviceKey);
		return service.xml_list(url);
	}
	
	//유기동물 정보 조회 요청
	@ResponseBody @RequestMapping("/data/animal/list")
	public ArrayList<HashMap<String, Object>> animal_list() {
		StringBuilder url = new StringBuilder(animal_url + "/abandonmentPublic");
		url.append("?ServiceKey=" + serviceKey);
		url.append("&_type=json");
		return service.json_list(url);
	}
	
	//유기동물 시군구 요청
	@ResponseBody @RequestMapping("/data/animal/sigungu")
	public ArrayList<HashMap<String, Object>> animal_sigungu(String sido) {
		StringBuilder url = new StringBuilder(animal_url + "/sigungu");
		url.append("?ServiceKey=" + serviceKey);
		url.append("&_type=json");
		url.append("&upr_cd=" + sido);
		
		return service.json_list(url);
	}
}
package data;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class DataServiceImpl implements DataService {

	private ArrayList<HashMap<String, Object>> xml_to_json(String xml) {
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		try {
			JSONObject json = (JSONObject)new JSONParser().parse(xml);
			json = (JSONObject)json.get("response");
			json = (JSONObject)json.get("body");
			
			if( json.get("totalCount")==null || (Long)json.get("totalCount") >0 ) {
				json = (JSONObject)json.get("items");
				JSONArray item = (JSONArray)json.get("item");
				list = new ObjectMapper().readValue(item.toString(), new TypeReference<ArrayList<HashMap<String, Object>>>() {});
			}
		}catch (Exception e) {
		}
		return list;
	}
	
	@Override
	public String xml_list(StringBuilder url) {
		String result = url.toString();
		try {
			HttpURLConnection conn = (HttpURLConnection)new URL(result).openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json");
			BufferedReader reader;
			if( conn.getResponseCode() >= 200 && conn.getResponseCode() <=300 ) {
				reader = new BufferedReader( new InputStreamReader(conn.getInputStream(), "utf-8") );
			}else {
				reader = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "utf-8"));	//에러도 버퍼드리더에서 한글로 읽어올수있도록 처리
			}
			url = new StringBuilder();
			String line;
			while( (line = reader.readLine()) != null ) {
				url.append(line); 	//읽어온 데이터를 line에 담는다
			}
			reader.close();
			conn.disconnect();
			result = url.toString(); //읽어온 데이터를 문자로 만들어 result에 담는다
		} catch (Exception e) {
		}
		System.out.println(result);
		return result;
	}

	@Override
	public ArrayList<HashMap<String, Object>> json_list(StringBuilder url) {
		return xml_to_json(xml_list(url));
	}

}

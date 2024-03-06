package com.with.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.with.dao.UserDAO;
import com.with.vo.UserVO;

@Service
public class NaverServiceImpl implements NaverService{
	
	@Inject
	UserDAO dao;
	
	@Override
	public String getAccessToken(String authorize_code) throws Throwable {
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://nid.naver.com/oauth2.0/token";

		try {
			URL url = new URL(reqURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// POST 요청을 위해 기본값이 false인 setDoOutput을 true로

			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			// POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송

			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");

			sb.append("&client_id=Lhss0_klqmPUr2XB7kQ1"); // REST_API키 본인이 발급받은 key 넣어주기
			sb.append("&client_secret=Jpsg4kZMAt");
			sb.append("&redirect_uri=http://localhost:8080/account/login/oauth2/code/naver"); // REDIRECT_URI 본인이 설정한 주소 넣어주기
			sb.append("&service_provider=NAVER");

			sb.append("&code=" + authorize_code);
			bw.write(sb.toString());
			bw.flush();

			// 결과 코드가 200이라면 성공
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			// 요청을 통해 얻은 JSON타입의 Response 메세지 읽어오기
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			// jackson objectmapper 객체 생성
			ObjectMapper objectMapper = new ObjectMapper();
			// JSON String -> Map
			Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
			});
			
			access_Token = jsonMap.get("access_token").toString();
			refresh_Token = jsonMap.get("refresh_token").toString();

			System.out.println("access_token : " + access_Token);
			System.out.println("refresh_token : " + refresh_Token);

			br.close();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return access_Token;
	}
	
	//	네이버 사용자 정보 가져와서 db저장
	public UserVO getNaverUserInfo (String access_Token) throws Exception{

		//KakaoUserVO userInfo = new KakaoUserVO();
		UserVO userInfo = new UserVO();
		String reqURL = "https://openapi.naver.com/v1/nid/me";
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");

			//    요청에 필요한 Header에 포함될 내용
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);

			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);

			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

			String line = "";
			String result = "";

			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("response body : " + result);

			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			ObjectMapper objectMapper = new ObjectMapper();
			Map<String, Object> jsonMap = objectMapper.readValue(result, new TypeReference<Map<String, Object>>() {
			});

			JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			JsonObject naver_account = element.getAsJsonObject().get("naver_account").getAsJsonObject();

			String id = String.valueOf(jsonMap.get("id"));
			String nickname = properties.getAsJsonObject().get("nickname").getAsString();
			String email = naver_account.getAsJsonObject().get("email").getAsString();
			//String access_token = access_Token;

			userInfo.setUser_id(id);
			userInfo.setNickname(nickname);
			userInfo.setUser_email(email);
			//userInfo.setAccess_token(access_token);
			

		} catch (IOException e) {
			e.printStackTrace();
		}
		UserVO result =dao.findNaver(userInfo);
		System.out.println("저장값 : " + result);

		if(result ==null) {
			//result null 이면 정보가 저장 안되어있는거라서 정보를 저장.
			dao.naverInsert(userInfo);
			//저장하기위해 repository 로 이동
			//return dao.findKakao(userInfo);
			return dao.naverlogin(userInfo);
			// 정보 저장후 컨트롤러에 정보를 보냄
			//result 를 리턴으로 보내면 null 이 리턴되므로 위코드를 사용.
		}else {
			return dao.naverlogin(userInfo);
			//정보가 있으므로 result 를 리턴함
		}
	}
}

package com.with.service;

import com.with.vo.UserVO;

public interface KakaoService {
	
	public  UserVO getKakaoUserInfo (String access_Token) throws Exception;

	String getAccessToken(String authorize_code) throws Throwable;
	
	//public KakaoUserVO getUserInfo(String access_Token) throws Throwable;
}

package com.with.service;

import com.with.vo.UserVO;

public interface NaverService {
	
	public  UserVO getNaverUserInfo (String access_Token) throws Exception;

	String getAccessToken(String authorize_code) throws Throwable;
}

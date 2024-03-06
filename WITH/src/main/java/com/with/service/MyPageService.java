package com.with.service;

import java.util.Map;

import com.with.vo.UserVO;
import com.with.vo.myPageVO;

public interface MyPageService {
	
	
	//비밀번호 변경
	public int changePw(Map<String, Object> paramMap) throws Exception;

}
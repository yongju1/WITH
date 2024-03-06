package com.with.dao;

import java.util.Map;

import com.with.vo.UserVO;
import com.with.vo.myPageVO;

public interface MyPageDAO {

	
	//현재 로그인한 회원의 암호화된 비번 조회
	public String selectEncPw(int user_no) throws Exception;
	
	//비밀번호 변경
	public int changePw(Map<String, Object> paramMap) throws Exception;
	
}

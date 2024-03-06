package com.with.service;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.with.dao.MyPageDAO;
import com.with.dao.UserDAO;
import com.with.vo.UserVO;
import com.with.vo.myPageVO;

@Service
public class MyPageServiceImpl implements MyPageService {

	@Inject
	UserDAO dao;
	@Inject
	MyPageDAO md; 
	
	@Inject
	BCryptPasswordEncoder bcyrpt;
	
	//비밀번호 변경
	@Override
	public int changePw(Map<String, Object> paramMap) throws Exception{
		//현재 비밀번호 조회
		String encPw = md.selectEncPw((int)paramMap.get(("user_no")));
		
		//입력된 현재 비밀번호(평문)와 조회된 암호화된 비밀번호를 bcytpt.matches() 이용하여 비교 후 일치하면 새 비번을 암호화 후 update
		if(bcyrpt.matches((String)paramMap.get("currentPw"),encPw)) {
			paramMap.put("newPw", bcyrpt.encode((String)paramMap.get("newPw")));
			return md.changePw(paramMap);
		}
		return 0;
	}

}

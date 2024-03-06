package com.with.dao;

import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MypageDAOImpl implements MyPageDAO{
	
	@Inject
	private SqlSession sql;
	
	//현재 로그인한 회원의 암호화된 비번 조회
	public String selectEncPw(int user_no) throws Exception{
		return sql.selectOne("userMapper.selectEncPw", user_no);
	}
	
	//비밀번호 변경
	public int changePw(Map<String, Object> paramMap) throws Exception{
		return sql.update("userMapper.changePw", paramMap);
	}

}

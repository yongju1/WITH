package com.with.service;

import java.util.List;
import java.util.Map;

import com.with.Pagination;
import com.with.vo.UserVO;

public interface UserService {
	
	//회원가입
	public void register(UserVO vo) throws Exception;
	
	//로그인
	public UserVO login(UserVO vo) throws Exception;
	
	//아이디 중복 확인
	public int idChk(UserVO vo) throws Exception;
	
	//아이디 찾기
	public UserVO findUserId(UserVO vo) throws Exception;
	
	//비번찾기
	public int pwCheck(UserVO vo) throws Exception;
	public void pwUpdate(UserVO vo) throws Exception;
	
	//회원정보 찾기
	public void updateUser(UserVO vo) throws Exception;
	
	// 유저 목록 가져오기
	public List<UserVO> getUserList(Pagination pagination) throws Exception;
	
	//회원 삭제
	public void deleteUser(int user_no) throws Exception;
	
	//회원 리스트 검색
	public List<UserVO> searchUser(String keyword) throws Exception;
	
	//회원 리스트 정렬
	public List<UserVO> getUserListOrdered(Map<String, String> params) throws Exception;
	
	// 회원 리스트 총 수 불러오기
	public int getUserListCnt(String keyword) throws Exception;


}

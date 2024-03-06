package com.with.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.with.Pagination;
import com.with.dao.UserDAO;
import com.with.vo.UserVO;

@Service
public class UserServiceImple implements UserService {

	@Inject
	UserDAO dao;

	// 회원정보
	@Override
	public void register(UserVO vo) throws Exception {

		dao.register(vo);
	}
	
	//로그인
	@Override
	public UserVO login(UserVO vo) throws Exception {
		return dao.login(vo);
	}
	
	// 아이디 중복 확인
	@Override
	public int idChk(UserVO vo) throws Exception {
		int result = dao.idChk(vo);
		return result;
	}
	
	//아이디 찾기
	@Override
	public UserVO findUserId(UserVO vo) throws Exception {
		return dao.findUserId(vo);
	}
	
	//비번찾기
	public int pwCheck(UserVO vo) throws Exception {
		return dao.pwCheck(vo);
	}
	
	//비밀번호 수정
	public void pwUpdate(UserVO vo) throws Exception {
		dao.pwUpdate(vo);
	}
	
	//회원정보수정
	@Override
	public void updateUser(UserVO vo) throws Exception {
		dao.updateUser(vo);
	}
	
	//회원 리스트
	@Override
	public List<UserVO> getUserList(Pagination pagination) throws Exception {
		return dao.getUserList(pagination);
	}
	
	//회원삭제
	 @Override
	public void deleteUser(int user_no) throws Exception {
		 dao.deleteUser(user_no);
	}
	 
	//회원 리스트 검색
	@Override
	public List<UserVO> searchUser(String keyword) throws Exception {
		return dao.searchUser(keyword);
	}
	 
	//회원 리스트 정렬
	@Override
	public List<UserVO> getUserListOrdered(Map<String, String> params) throws Exception {
		return dao.getUserListOrdered(params);
	}
	
	// 회원 리스트 총 수 불러오기
	@Override
	public int getUserListCnt(String keyword) throws Exception {
		return dao.getUserListCnt(keyword);
	}
}

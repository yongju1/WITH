package com.with.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.with.Pagination;
import com.with.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class UserDAOImpl implements UserDAO {
	
	@Inject
	private SqlSession sql;
	
	//회원가입
	@Override
	public void register(UserVO vo) throws Exception {
		sql.insert("userMapper.register", vo);
	}
	
	//로그인
	@Override
	public UserVO login(UserVO vo) throws Exception {
		return sql.selectOne("userMapper.login", vo);
	}
	
	// 아이디 중복 확인
	@Override
	public int idChk(UserVO vo) throws Exception {
		int result = sql.selectOne("userMapper.idChk", vo);
		return result;
	}
	
	//카카오 회원정보 저장
	@Override
	public void kakaoInsert(UserVO userInfo) throws Exception{
		sql.insert("userMapper.kakaoInsert", userInfo);
	}
	
	//카카오로그인
	@Override
	public UserVO kakaologin(UserVO vo) throws Exception{
		return sql.selectOne("userMapper.kakaologin", vo);
	}

	//카카오 회원정보 가져오기
	@Override
	public UserVO findKakao(UserVO userInfo) throws Exception{
		return sql.selectOne("userMapper.findKakao", userInfo);
	}
	
	//아이디 찾기
	@Override
	public UserVO findUserId(UserVO vo) throws Exception {
		
		return sql.selectOne("userMapper.findId", vo);
	}
	
	//비번찾기
	@Override
	public int pwCheck(UserVO vo) {
		return sql.selectOne("userMapper.pwCheck", vo);
	}
	@Override
	public void pwUpdate(UserVO vo) {
		//		System.out.println("비번 변경 전 : " + dto.getPwd());
		//		String newUpdatePwd = pwEncoder.encode(dto.getPwd());
		//		System.out.println("비번 변경 후 : " + newUpdatePwd);
		//		dto.setPwd(newUpdatePwd); 
		sql.update("userMapper.pwUpdate", vo);
	}
	
	//회원정보 수정
	@Override
    public void updateUser(UserVO vo) throws Exception {
        sql.update("userMapper.updateUser", vo);
	}
	
	// 유저 목록 가져오기
	@Override
	public List<UserVO> getUserList(Pagination pagination) throws Exception {
		return sql.selectList("userMapper.getUserList", pagination);
	}
	
	//회원삭제
	@Override
    public void deleteUser(int user_no) throws Exception {
        sql.delete("userMapper.deleteUser", user_no);
    }
	
	//회원 리스트 검색
	@Override
    public List<UserVO> searchUser(String keyword) throws Exception {
        return sql.selectList("userMapper.searchUser", keyword);
    }
	
	//회원 리스트 정렬
	@Override
	public List<UserVO> getUserListOrdered(Map<String, String> params) throws Exception {
	    return sql.selectList("userMapper.getUserListOrdered", params);
	}
	
	// 회원 리스트 총 갯수 불러오기
	@Override
	public int getUserListCnt(String keyword) throws Exception {
		return sql.selectOne("userMapper.getUserListCnt", keyword);
	}
	
	
	// 네이버 로그인
	@Override
	public UserVO naverlogin(UserVO vo) throws Exception {
		return sql.selectOne("userMapper.naverlogin", vo);
	}
	
	// 네이버 회원가입 
	@Override
	public void naverInsert(UserVO userInfo) throws Exception {
		sql.insert("userMapper.naverInsert", userInfo);
	}

	// 네이버 회원정보 가져오기
	@Override
	public UserVO findNaver(UserVO userInfo) throws Exception {
		return sql.selectOne("userMapper.findNaver", userInfo);
	}


}

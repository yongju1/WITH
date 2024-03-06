package com.with.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.with.Pagination;
import com.with.vo.GbookVO;

@Repository
public class GbookDAOImpl implements GbookDAO {

	@Inject
	private SqlSession session;

	// 모든 장소 불러오기
	@Override
	public List<GbookVO> gbookList(Pagination pagination) {
		return session.selectList("gbookMapper.getGbookList", pagination);
	}
	
	// 장소별 방명록 리스트
	@Override
	public List<GbookVO> gbookList(int place_no) {
		return session.selectList("gbookMapper.list", place_no);
	}

	// 방명록 추가
	@Override
	public int add(GbookVO gbookVO) throws Exception {
		return session.insert("gbookMapper.add", gbookVO);
	}
	
	//유저별 방명록 수
	@Override
	public int getMyGbookListCnt(int user_no) throws Exception{
		return session.selectOne("gbookMapper.myGbookListCnt", user_no);
	}

	// 유저별 방명록 가져오기
	@Override
	public List<GbookVO> myGbooklist(Pagination pagination) throws Exception {
		return session.selectList("gbookMapper.myGbooklist", pagination);
	}

	// 방명록 삭제
	@Override
	public int delete(int gbook_no) throws Exception {
		return session.delete("gbookMapper.delete", gbook_no);
	}
	
	// 방명록 넘버 가져오기
	@Override
	public GbookVO gbook(int gbook_no) throws Exception{
		return session.selectOne("gbookMapper.gbook", gbook_no);
	}

	// 방명록 수정
	@Override
	public int update(GbookVO gbookVO) throws Exception {
		return session.update("gbookMapper.update", gbookVO);
	}
	
	// 방명록 수 업데이트
	@Override
	public void updateGbookCnt(int place_no) throws Exception{
		session.update("gbookMapper.updateGbookCnt", place_no);
	}

	// 총 방명록 수 
	@Override
	public int getGbookCnt(String keyword) throws Exception {
		return session.selectOne("gbookMapper.getGbookCnt", keyword);
	}
}

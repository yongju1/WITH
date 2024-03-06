package com.with.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.with.Pagination;
import com.with.dao.GbookDAO;
import com.with.vo.GbookVO;
import com.with.vo.PlaceVO;
import com.with.vo.ScheduleVO;

@Service
public class GbookServiceImpl implements GbookService{
 
    @Inject
    private GbookDAO dao;
 
	// 게시판 리스트
    @Override
    public List<GbookVO> gbookList(int place_no) {
        return dao.gbookList(place_no);
    }
    
	// 방명록 추가
    @Override
    public void addGbook(GbookVO gbookVO) throws Exception {
    	dao.add(gbookVO);
    }
    
    //유저별 방명록 수
    @Override
  	public int getMyGbookListCnt(int user_no) throws Exception{
  		return dao.getMyGbookListCnt(user_no);
  	}
  	
	// 나의 방명록
    @Override
    public List<GbookVO> myGbooklist(Pagination pagination) throws Exception {
        return dao.myGbooklist(pagination);
    }
    
	// 방명록 삭제
    @Override
    public int deleteGbook(int gbook_no) throws Exception {
        return dao.delete(gbook_no);
    }
    
	// 방명록 수 가져오기
    @Override
    public GbookVO gbook(int gbook_no) throws Exception{
    	return dao.gbook(gbook_no);
    }
    
	// 방명록 수정
    @Override
    public int updateGbook(GbookVO gbookVO) throws Exception {
        return dao.update(gbookVO);
    }
    
	// 방명록 수정, 삭제에 따른 수
    @Override
	public void updateGbookCnt(int place_no) throws Exception{
		dao.updateGbookCnt(place_no);
	}
    
	// 모든 게시글 목록 가져오기
    @Override
	public List<GbookVO> gbookList(Pagination pagination) throws Exception {
    	 return dao.gbookList(pagination);
	}

	// 총 방명록 수 
	@Override
	public int getGbookCnt(String keyword) throws Exception {
		return dao.getGbookCnt(keyword);
	}
}
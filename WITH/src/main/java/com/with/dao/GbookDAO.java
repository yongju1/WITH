package com.with.dao;

import java.util.List;

import com.with.Pagination;
import com.with.vo.GbookVO;
import com.with.vo.PlaceVO;
import com.with.vo.ScheduleVO;

public interface GbookDAO {

	// 모든 장소 불러오기
	public List<GbookVO> gbookList(Pagination pagination) throws Exception;

	// 장소별 방명록 리스트
	public List<GbookVO> gbookList(int place_no);

	// 방명록 추가
	public int add(GbookVO gbookVO) throws Exception;

	// 유저별 방명록 수
	public int getMyGbookListCnt(int user_no) throws Exception;

	// 유저별 방명록 가져오기
	public List<GbookVO> myGbooklist(Pagination pagination) throws Exception;

	// 방명록 삭제
	public int delete(int gbook_no) throws Exception;

	// 방명록 넘버 가져오기
	public GbookVO gbook(int gbook_no) throws Exception;

	// 방명록 수정
	public int update(GbookVO gbookVO) throws Exception;

	// 방명록 수 업데이트
	public void updateGbookCnt(int place_no) throws Exception;
	
	// 총 방명록 수 
	public int getGbookCnt(String keyword) throws Exception;
}

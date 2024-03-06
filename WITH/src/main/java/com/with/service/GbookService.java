package com.with.service;

import com.with.Pagination;
import com.with.vo.BoardVO;
import com.with.vo.GbookVO;
import com.with.vo.ScheduleVO;

import java.util.List;

public interface GbookService {
	
	// 게시판 리스트
	public List<GbookVO> gbookList(int place_no);

	// 방명록 추가
	public void addGbook(GbookVO gbookVO) throws Exception;

	// 유저별 방명록 수
	public int getMyGbookListCnt(int user_no) throws Exception;
	
	// 나의 방명록
	public List<GbookVO> myGbooklist(Pagination pagination) throws Exception;

	// 방명록 삭제
	public int deleteGbook(int gbook_no) throws Exception;
	
	// 방명록 수 가져오기
	public GbookVO gbook(int gbook_no) throws Exception;

	// 방명록 수정
	public int updateGbook(GbookVO gbookVO) throws Exception;

	// 방명록 수정, 삭제에 따른 수
	public void updateGbookCnt(int place_no) throws Exception;

	// 모든 게시글 목록 가져오기
	public List<GbookVO> gbookList(Pagination pagination) throws Exception;
	
	// 총 방명록 수 
	public int getGbookCnt(String keyword) throws Exception;
}
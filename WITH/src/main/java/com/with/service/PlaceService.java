package com.with.service;

import java.util.List;

import com.with.Pagination;
import com.with.vo.BookmarkVO;
import com.with.vo.FileVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;

public interface PlaceService {
	
	//장소추가
	public void register(PlaceVO vo) throws Exception;
	
	//장소추가
	public void update(PlaceVO vo) throws Exception;
	
	//장소삭제
    public void deletePlace(int place_no) throws Exception;
	
	//장소불러오기
	public PlaceVO get(int place_no) throws Exception;
	
	// 모든 장소 불러오기
	public List<PlaceVO> getList() throws Exception;
	
	// 장소 여러개 불러오기
	public List<PlaceVO> getList(Pagination pagination) throws Exception;
	
	// 장소 여러개 불러오기 타입별
	public List<PlaceVO> getList(int type) throws Exception;
	
	// 장소 여러개 불러오기 지역별
	public List<PlaceVO> getList(String type) throws Exception;
	
	// 장소 사진 넣기
	public void registerFile(FileVO vo) throws Exception;
	
	// 장소 리스트 총 수 불러오기
	public int getPlaceListCnt(String keyword) throws Exception;
	
	//헤더 장소 검색
	public List<PlaceVO> searchPlace(Pagination pagination) throws Exception;
	
	// 카테고리 별 장소 리스트 갯수 불러오기
	public int getCateListCnt(int cate) throws Exception;
	
	//카테고리 별 장소 리스트
	public List<PlaceVO> categoryPlace(Pagination pagination) throws Exception;
	
	// 북마크 추가
	public void addBookmark(BookmarkVO vo) throws Exception;
		
	// 북마크 제거
	public void removeBookmark(BookmarkVO vo) throws Exception;

	// 사용자의 모든 북마크 장소 불러오기
	public List<PlaceVO> getBookmarksByUserId(int user_no) throws Exception;

	// 사용자의 모든 북마크 장소 불러오기
	public List<Integer> getBookmarksList(int user_no) throws Exception;
	
	// 나의 북마크 페이지
	public List<PlaceVO> getPagination(Pagination pagination) throws Exception;
		
	// 나의 북마크 페이지 수
	public int myCountBookmark(int user_no) throws Exception;
}

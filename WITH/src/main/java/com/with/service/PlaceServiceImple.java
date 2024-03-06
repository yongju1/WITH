package com.with.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.with.Pagination;
import com.with.dao.PlaceDAO;
import com.with.vo.BookmarkVO;
import com.with.vo.FileVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class PlaceServiceImple implements PlaceService {

	@Inject
	PlaceDAO dao;

	// 장소추가
	@Override
	public void register(PlaceVO vo) throws Exception {
		dao.register(vo);
	}
	
	// 장소추가
	@Override
	public void update(PlaceVO vo) throws Exception {
		dao.update(vo);
	}
	
	//장소삭제
    public void deletePlace(int place_no) throws Exception{
    	dao.deletePlace(place_no);
    }
	
	// 장소 불러오기
	@Override
	public PlaceVO get(int place_no) throws Exception {
		log.info("get...." + place_no);
		return dao.get(place_no);
	}
	
	//모든 장소 불러오기
	@Override
	public List<PlaceVO> getList() throws Exception {
		return dao.getList();
	}
	
	// 장소 여러개 불러오기
	@Override
	public List<PlaceVO> getList(Pagination pagination) throws Exception {
		return dao.getList(pagination);
	}
	
	// 장소 여러개 불러오기 타입별
	@Override
	public List<PlaceVO> getList(int type) throws Exception {
		log.info("getList...int" + type);
		return dao.getList(type);
	}
	
	// 장소 여러개 불러오기 지역별
	@Override
	public List<PlaceVO> getList(String type) throws Exception {
		log.info("getList...String"+type);
		return dao.getList(type);
	}

	// 파일 업로드
	@Override
	public void registerFile(FileVO vo) throws Exception {
		dao.registerFile(vo);
	}
	
	// 장소 리스트 총 갯수 불러오기
	@Override
	public int getPlaceListCnt(String keyword) throws Exception {
		return dao.getPlaceListCnt(keyword);
	}
	
	//헤더 장소 검색
	@Override
	public List<PlaceVO> searchPlace(Pagination pagination) throws Exception {
		return dao.searchPlace(pagination);
	}
	
	// 카테고리 별 장소 리스트 갯수 불러오기
	public int getCateListCnt(int cate) throws Exception{
		return dao.getCateListCnt(cate);
	}
	
	//카테고리 별 장소 리스트
	public List<PlaceVO> categoryPlace(Pagination pagination) throws Exception{
		return dao.categoryPlace(pagination);
	}
	
	// 북마크 생성
	@Override
	public void addBookmark(BookmarkVO vo) throws Exception {
		dao.addBookmark(vo);
	}

	// 북마크 제거
	@Override
	public void removeBookmark(BookmarkVO vo) throws Exception {
		dao.removeBookmark(vo);
	}

	// 북마크 장소 불러오기
	@Override
	public List<PlaceVO> getBookmarksByUserId(int user_no) throws Exception {
		return dao.getBookmarksByUserId(user_no);
	}
	
	// 북마크 불러오기
	@Override
	public List<Integer> getBookmarksList(int user_no) throws Exception {
		return dao.getBookmarksList(user_no);
	}
	
	// 북마크 리스트 갯수 불러오기
	@Override
	public int myCountBookmark(int user_no) throws Exception{
	     return dao.myCountBookmark(user_no);
	}
		
	//북마크  별 장소 리스트
	@Override
	public List<PlaceVO> getPagination(Pagination pagination) throws Exception{
		return dao.getPagination(pagination);
	}
}

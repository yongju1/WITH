package com.with.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.with.Pagination;
import com.with.vo.BookmarkVO;
import com.with.vo.FileVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PlaceDAOImpl implements PlaceDAO {

	@Inject
	private SqlSession sql;

	// 장소 추가
	@Override
	public void register(PlaceVO vo) throws Exception {
		sql.insert("placeMapper.register", vo);
	}
	
	// 장소수정
	@Override
	public void update(PlaceVO vo) throws Exception{
		sql.update("placeMapper.update", vo);
	}
	
	//장소삭제
    public void deletePlace(int place_no) throws Exception{
    	sql.delete("placeMapper.deletePlace", place_no);
    }

	// 장소 불러오기
	@Override
	public PlaceVO get(int place_no) throws Exception {
		return sql.selectOne("placeMapper.placeInfo", place_no);
	}
	
	// 장소 리스트 불러오기
	@Override
	public List<PlaceVO> getList(Pagination pagination) throws Exception {
		return sql.selectList("placeMapper.placeInfoAll", pagination);
	}

	// 장소 리스트로 불러오기 타입별
	@Override
	public List<PlaceVO> getList(int type) throws Exception {
		return sql.selectList("placeMapper.placeInfoMainList", type);
	}
	
	// 장소 리스트로 불러오기 장소별
	@Override
	public List<PlaceVO> getList(String type) throws Exception {
		return sql.selectList("placeMapper.placeInfoMainList2", type);
	}

	// 파일 올리기
	@Override
	public void registerFile(FileVO vo) throws Exception {
		sql.insert("placeMapper.placeImgRegister", vo);
	}
	
	// 장소 리스트 총 갯수 불러오기
	@Override
	public int getPlaceListCnt(String keyword) throws Exception {
		return sql.selectOne("placeMapper.getPlaceListCnt", keyword);
	}
	
	//헤더 장소 검색
	@Override
    public List<PlaceVO> searchPlace(Pagination pagination) throws Exception {
        return sql.selectList("placeMapper.searchPlace", pagination);
    }
	
	// 카테고리 별 장소 리스트 갯수 불러오기
	public int getCateListCnt(int cate) throws Exception{
		return sql.selectOne("placeMapper.getCateListCnt", cate);
	}
	
	//카테고리 별 장소 리스트
	public List<PlaceVO> categoryPlace(Pagination pagination) throws Exception{
		return sql.selectList("placeMapper.categoryPlace", pagination);
	}
	
	//모든 장소 불러오기
	@Override
	public List<PlaceVO> getList() throws Exception {
		return sql.selectList("placeMapper.getPlaceList");
	}
	
	// 북마크 생성
	@Override
	public void addBookmark(BookmarkVO vo) throws Exception {
		sql.insert("placeMapper.bookmarkRegister", vo);
	}

	// 북마크 제거
	@Override
	public void removeBookmark(BookmarkVO vo) throws Exception {
		sql.delete("placeMapper.bookmarkDelete", vo);
	}
	
	// 북마크 장소 불러오기
	@Override
	public List<PlaceVO> getBookmarksByUserId(int user_no) throws Exception {
		return sql.selectList("placeMapper.getBookmarkPlaceList", user_no);
	}

	// 북마크 리스트 불러오기
	@Override
	public List<Integer> getBookmarksList(int user_no) throws Exception {
		return sql.selectList("placeMapper.getBookmarkList", user_no);
	}
	
	// 북마크 갯수 불러오기
	@Override
	public int myCountBookmark(int user_no) throws Exception{
			return sql.selectOne("placeMapper.myCountBookmark", user_no);
	}
		
	// 북마크 페이지 
	@Override
	public List<PlaceVO> getPagination(Pagination pagination) throws Exception{
			return sql.selectList("placeMapper.getPagination", pagination);
	}

}

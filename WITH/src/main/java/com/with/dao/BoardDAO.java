package com.with.dao;

import java.util.List;
import java.util.Map;

import com.with.Pagination;
import com.with.vo.BcommentVO;
import com.with.vo.BoardVO;
import com.with.vo.FileVO;


public interface BoardDAO {
	
    // 게시글 불러오기 
	public List<BoardVO> boardList() throws Exception;
	
	//게시글 목록 불러오기
	public List<BoardVO> boardList(Pagination pagination) throws Exception;
	
	//게시글 상세보기
	public BoardVO boardDetail(int board_no) throws Exception;
	
	//게시글 업로드
	public void boardUpload(BoardVO vo) throws Exception;
	
	// 게시글 삭제 
	public void boardDelete(int board_no) throws Exception;
	
	//게시글 수정 
	public void boardUpdate(BoardVO vo) throws Exception;
	
	// 모든 게시글 목록 가져오기
	public List<BoardVO> boardAllList(Pagination pagination) throws Exception;
	
	//이미지 저장, 업로드
	public void registerFile(FileVO vo) throws Exception;
	
	
	//조회수
	public void addView(int board_no) throws Exception;
	
	public int getBoardListCnt(String keyword) throws Exception;
	
	// 댓글 불러오기
	public List<BcommentVO> getBcommentList(int board_no) throws Exception;
	
	// 댓글 업데이트
	public void bcommentUpdate(BcommentVO vo) throws Exception;
	
	// 댓글 삭제
	public void bcommentDelete(int comment_no) throws Exception;
	
	// 댓글 등록
	public void bcommentInsert(BcommentVO vo) throws Exception;
	
	// 댓글 하나만 가져오기
	public BcommentVO getComment(int comment_no) throws Exception;
	
	// 댓글 수 업데이트
	public void updateCommentCnt(int board_no) throws Exception;

	//관리자 게시글 삭제
	public void deleteBoard(int board_no) throws Exception;
	
	//관리자 게시글 검색
	public List<BoardVO> searchBoard(String keyword) throws Exception;
	
	//관리자 게시글 정렬
	public List<BoardVO> getBoardListOrdered(Map<String, String> params) throws Exception;
	
	// 관리자 게시글 리스트 갯수 불러오기
	public int getAdminBoardListCnt(String keyword) throws Exception;
	
	// 나의 게시글 목록 
	public List<BoardVO> getMyBoardList(Pagination pagination) throws Exception;
			
	// 나의 게시글 페이지 수
	public int myCountBoardList(int user_no) throws Exception;
	
	// 나의 게시글 리스트 검색
	public List<BoardVO> mySearchBoard(String keyword) throws Exception;
			
	// 나의 게시글 정렬
	public List<BoardVO> getMyBoardListOrdered(Map<String, String> params) throws Exception;
	
	// 나의 게시글 상세
	public BoardVO myBoardDetail(int board_no) throws Exception;
	      
	// 나의 게시글 삭제 
	public void myBoardDelete(int board_no) throws Exception;
	
	// 나의 게시글 상세 댓글
	public List<BcommentVO> getMyComments(int board_no) throws Exception;
	
	// 나의 게시글 수정 
	public void myBoardUpdate(BoardVO vo) throws Exception;
	
	// 파일 업로드
	public void boardFileUpdate(FileVO vo) throws Exception;
}
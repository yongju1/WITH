package com.with.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.with.Pagination;
import com.with.dao.BoardDAO;
import com.with.vo.BcommentVO;
import com.with.vo.BoardVO;
import com.with.vo.FileVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Inject
	BoardDAO dao;
	
	// 게시글 리스트
	@Override
	public List<BoardVO> boardList() throws Exception {
		return dao.boardList();
	}
	
	//게시글 목록 불러오기
	@Override
	public List<BoardVO> boardList(Pagination pagenation) throws Exception {
		return dao.boardList(pagenation);
	}
	
	//게시글 상세보기
	@Override
	public BoardVO boardDetail(int board_no) throws Exception {
		return dao.boardDetail(board_no);
	}
	
	//게시글 업로드
	@Override
	public void boardUpload(BoardVO vo) throws Exception {
		dao.boardUpload(vo);
	}
	
	// 게시글 삭제 
	@Override
	public void boardDelete(int board_no) throws Exception {
		 dao.boardDelete(board_no);
	}
	 
	// 게시글 수정 
	@Override
	public void boardUpdate(BoardVO vo) throws Exception {
		dao.boardUpdate(vo);
	}
	
	// 모든 게시글 목록 가져오기
	@Override
	public List<BoardVO> boardAllList(Pagination pagination) throws Exception{
		return dao.boardAllList(pagination);
	}
	
	// 댓글 수 업데이트
	@Override
	public void updateCommentCnt(int board_no) throws Exception{
		dao.updateCommentCnt(board_no);
	}
	
	@Override
	public void registerFile(FileVO vo) throws Exception {
		dao.registerFile(vo);
		
	}

	//조회수
	@Override
	public void addView(int board_no) throws Exception {
		dao.addView(board_no);
		
	}
	
	
	//글 개수
	@Override
	public int getBoardListCnt(String keyword) throws Exception {
		return dao.getBoardListCnt(keyword);
	}
	
	//댓글 목록
	@Override
	public List<BcommentVO> getBcommentList(int board_no) throws Exception {
		return dao.getBcommentList(board_no);
	}
	
	//댓글 수정하기
	@Override
	public void bcommentUpdate(BcommentVO vo) throws Exception {
		dao.bcommentUpdate(vo);
		
	}

	//댓글 삭제
	@Override
	public void bcommentDelete(int comment_no) throws Exception {
		dao.bcommentDelete(comment_no);
	}

	
	//댓글 입력
	@Override
	public void bcommentInsert(BcommentVO vo) throws Exception {
		dao.bcommentInsert(vo);
	}

	
	//댓글 수정을 위한 정보 불러오기
	@Override
	public BcommentVO getComment(int comment_no) throws Exception {
		return dao.getComment(comment_no);
	}
	
	// 관리자 게시글 삭제
	@Override
	public void deleteBoard(int board_no) throws Exception {
		dao.deleteBoard(board_no);
	}
	
	// 관리자 게시글 검색
	@Override
	public List<BoardVO> searchBoard(String keyword) throws Exception {
		return dao.searchBoard(keyword);
	}
	
	//관리자 게시글 정렬
	@Override
	public List<BoardVO> getBoardListOrdered(Map<String, String> params) throws Exception {
		return dao.getBoardListOrdered(params);
	}
	
	// 관리자 게시글 리스트 총 수 불러오기
	@Override
	public int getAdminBoardListCnt(String keyword) throws Exception {
		return dao.getAdminBoardListCnt(keyword);
	}
	
	// 나의 게시글 상세
	@Override
	public BoardVO myBoardDetail(int board_no) throws Exception {
		return dao.myBoardDetail(board_no);
	}
		
	// 나의 게시글 삭제 
	@Override
	public void myBoardDelete(int board_no) throws Exception {
		dao.myBoardDelete(board_no);
	}

	// 게시글 상세 댓글 
	@Override
	public List<BcommentVO> getMyComments(int board_no) throws Exception {
		return dao.getMyComments(board_no);
	}

	// 나의 게시글 수정 
	@Override
	public void myBoardUpdate(BoardVO vo) throws Exception {
		dao.myBoardUpdate(vo);
	}
		
			
	// 게시글 리스트
	@Override
	public List<BoardVO> getMyBoardList(Pagination pagination) throws Exception {
				return dao.getMyBoardList(pagination);
			}
	
	// 게시글 리스트 갯수 불러오기
	@Override
	public int myCountBoardList(int user_no) throws Exception {
		return dao.myCountBoardList(user_no);
	}
	
	// 나의 게시글 검색
	@Override
	public List<BoardVO> mySearchBoard(String keyword) throws Exception {
			return dao.mySearchBoard(keyword);
		}
		 
	// 나의 게시글 정렬
	@Override
	public List<BoardVO> getMyBoardListOrdered(Map<String, String> params) throws Exception {
			return dao.getMyBoardListOrdered(params);
	}
	
	//게시물 파일 업로드
	@Override
	public void boardFileUpdate(FileVO vo) throws Exception {
		dao.boardFileUpdate(vo);
	}
}
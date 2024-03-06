package com.with.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.with.Pagination;
import com.with.vo.BcommentVO;
import com.with.vo.BoardVO;
import com.with.vo.FileVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	private SqlSession sql;
		
	// 게시글 가져오기
	@Override
	public List<BoardVO> boardList() throws Exception {
		return sql.selectList("boardMapper.boardList");
	}
	
	//게시글 목록 불러오기
	@Override
	public List<BoardVO> boardList(Pagination pagination) throws Exception {
		return sql.selectList("boardMapper.boardList", pagination);
	}
	
	
	//게시글 상세보기
	@Override
	public BoardVO boardDetail(int board_no) throws Exception {
		return sql.selectOne("boardMapper.boardDetail", board_no);
	}
	
	//게시글 업로드
	@Override
	public void boardUpload(BoardVO vo) throws Exception {
		sql.selectList("boardMapper.boardUpload", vo);
	}
	
	// 게시글 삭제 
	@Override
    public void boardDelete(int board_no) throws Exception {
        sql.delete("boardMapper.boardDelete", board_no);
    }
	
	// 게시글 수정 
	@Override
    public void boardUpdate(BoardVO vo) throws Exception {
		sql.update("boardMapper.boardUpdate", vo);
	}
	
	// 모든 게시글 목록 가져오기
	@Override
	public List<BoardVO> boardAllList(Pagination pagination) throws Exception{
		return sql.selectList("boardMapper.boardAllList", pagination);
	}
	
	// 댓글 수 업데이트
	@Override
	public void updateCommentCnt(int board_no) throws Exception{
		sql.update("boardMapper.updateCommentCnt", board_no);
	}
	
	//파일 업로드
	@Override
	public void registerFile(FileVO vo) throws Exception {
		sql.insert("boardMapper.fileUpload", vo);
		
	}

	//조회수
	@Override
	public void addView(int board_no) throws Exception {
		sql.update("boardMapper.addView", board_no);
		
	}

	//글 갯수
	@Override
	public int getBoardListCnt(String keyword) throws Exception {
		return sql.selectOne("boardMapper.getBoardListCnt", keyword);
	}


	//댓글 리스트
	@Override
	public List<BcommentVO> getBcommentList(int board_no) throws Exception {
		return sql.selectList("boardMapper.boardCommentList", board_no);
	}

	//댓글 수정
	@Override
	public void bcommentUpdate(BcommentVO vo) throws Exception {
		sql.update("boardMapper.boardCommentUpdate", vo);
	}

	//댓글 삭제
	@Override
	public void bcommentDelete(int comment_no) throws Exception {
		sql.delete("boardMapper.boardCommentDelete", comment_no);
	}

	//댓글 작성
	@Override
	public void bcommentInsert(BcommentVO vo) throws Exception {
		sql.insert("boardMapper.boardCommentInsert", vo);
	}

	//댓글 가져오기
	@Override
	public BcommentVO getComment(int comment_no) throws Exception {
		return sql.selectOne("boardMapper.getComment", comment_no);
	}
	
	// 관리자 게시글 삭제
    @Override
     public void deleteBoard(int board_no) throws Exception {
         sql.delete("boardMapper.deleteBoard", board_no);
     }
    
    // 관리자 게시글 검색
    @Override
    public List<BoardVO> searchBoard(String keyword) throws Exception {
        return sql.selectList("boardMapper.searchBoard", keyword);
    }
    
    // 관리자 게시글 정렬
    @Override
	public List<BoardVO> getBoardListOrdered(Map<String, String> params) throws Exception {
	    return sql.selectList("boardMapper.getBoardListOrdered", params);
	}
    
    // 관리자 게시글 리스트 총 갯수 불러오기
 	@Override
 	public int getAdminBoardListCnt(String keyword) throws Exception {
 		return sql.selectOne("boardMapper.getAdminBoardListCnt", keyword);
 	}
 	
 	// 나의 게시글 목록
 	@Override
	public List<BoardVO> getMyBoardList(Pagination pagination) throws Exception{
 		return sql.selectList("boardMapper.getMyBoardList", pagination);
	}
 	
 	// 나의 게시글 갯수 불러오기
 	@Override
 	public int myCountBoardList(int user_no) throws Exception{
 		return sql.selectOne("boardMapper.myCountBoardList", user_no);
	}
 	
 	// 나의 게시글 상세
    @Override
    public BoardVO myBoardDetail(int board_no) throws Exception {
        return sql.selectOne("boardMapper.myBoardDetail", board_no);
    }
    
    // 나의 게시글 삭제 
 	@Override
     public void myBoardDelete(int board_no) throws Exception {
         sql.delete("boardMapper.boardDelete", board_no);
     }

 	// 나의 게시글 상세 댓글 
	@Override
	public List<BcommentVO> getMyComments(int board_no) throws Exception {
		return sql.selectList("boardMapper.getMyComments", board_no);
	}

	// 나의 게시글 수정
	@Override
	public void myBoardUpdate(BoardVO vo) throws Exception {
		sql.update("boardMapper.boardUpdate", vo);
	}
	
	// 나의 게시글 검색
	@Override
	public List<BoardVO> mySearchBoard(String keyword) throws Exception {
		return sql.selectList("boardMapper.mySearchBoard", keyword);
	}
		
	// 나의 게시글 정렬
	@Override
	public List<BoardVO> getMyBoardListOrdered(Map<String, String> params) throws Exception {
		return sql.selectList("boardMapper.getMyBoardListOrdered", params);
	}
	
	//게시물 파일 업로드
	@Override
	public void boardFileUpdate(FileVO vo) throws Exception {
		sql.update("boardMapper.fileUpdate", vo);
	}
}
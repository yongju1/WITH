package com.with.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.Pagination;
import com.with.dao.BoardDAO;
import com.with.service.BoardService;
import com.with.service.GbookService;
import com.with.vo.BcommentVO;
import com.with.vo.BoardVO;
import com.with.vo.FileVO;
import com.with.vo.GbookVO;
import com.with.vo.UserVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	
	@Autowired
	public BoardDAO boardDAO;

	@Inject
	BoardService boardService;

	@Inject
	GbookService gbookservice;

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	//글 리스트
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public void getRegister(Model model, HttpSession session, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword, String order) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
		int listCnt = boardService.getBoardListCnt(keyword);
		
		Pagination pagination = new Pagination();
		pagination.setKeyword(keyword);
		pagination.setOrder(order);
		//pagination.setCate(cate);
	    pagination.pageInfo(page,range,listCnt);
	    
	    
	    model.addAttribute("pagination", pagination);
		//List<BoardVO> list = boardService.boardList(pagination);
		model.addAttribute("boardList", boardService.boardList(pagination));
		
		//return "/boardList";
	}

	private static final String filePath = "C:\\stsApp\\WITH\\src\\main\\webapp\\resources\\img\\board\\";

	
	//글쓰기
	@RequestMapping(value = "/boardUpload", method = RequestMethod.POST)
	public String Upload(BoardVO vo, HttpServletRequest request) throws Exception {
		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest)request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;
		
		FileVO fileVO = new FileVO(); 
		 
		File file = new File(filePath);
		
		if(file.exists() == false){
			file.mkdirs();
		}

		while(iterator.hasNext()){
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
	 		
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
	 		
				fileVO.setBOARD_NO(vo.getBoard_no());
				fileVO.setOriginal_file_name(originalFileName);
				fileVO.setStored_file_name(storedFileName);
				fileVO.setFile_size(multipartFile.getSize());
	 		
				boardService.registerFile(fileVO);
				vo.setBoard_img(storedFileName);

			}
		}
		
		boardService.boardUpload(vo);
		
        return "redirect:/board/boardList";
    }
	   public static String getRandomString(){
		   return UUID.randomUUID().toString().replaceAll("-", "");
	  }

	// 글쓰기 페이지로 이동
	@RequestMapping(value = "/boardUpload", method = RequestMethod.GET)
	public String boardUpload(HttpSession session, HttpServletRequest request) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");

		// 로그인하지 않은 사용자가 접근한 경우 처리
		if (user == null) {
			request.setAttribute("msg", "로그인을 해주세용!");
			request.setAttribute("url", "/login");
			return "alert";
		} else {
			return "/board/boardUpload";
		}

	}

	//게시글 삭제
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
    public String boardDelete(int board_no, Model model, HttpSession session, HttpServletRequest request) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
		BoardVO data = boardService.boardDetail(board_no);
		//로그인 유무 확인
		if (user == null) {
			request.setAttribute("msg", "로그인을 해주세용!");
			request.setAttribute("url", "/login");
	        return "alert";
		}
		
		//글쓴이와 유저가 같은지 확인하기
		if (user.getUser_no() == data.getUser_no()) {
			model.addAttribute("data", data);
			
			boardService.boardDelete(board_no);
			
			return "redirect:/board/boardList";
			
		} else  {
			request.setAttribute("msg", "권한이 없습니다!");
			request.setAttribute("url", "/board/boardList");
	        return "alert";
		} 
	}

	//글 상세보기, 댓글 불러오기, 댓글 개수 불러오기
	@RequestMapping(value = "/boardDetail", method = RequestMethod.GET)
	public void getBoardDetail(Model model, int board_no, HttpSession session) throws Exception {
		BoardVO data = boardService.boardDetail(board_no);
		List<BcommentVO> comment = boardService.getBcommentList(board_no);
		UserVO user = (UserVO) session.getAttribute("user");
		
		model.addAttribute("boardDetail", data);
		model.addAttribute("commentList", comment);
		boardService.addView(board_no);
		
		//return "/BoardDetail";
	}

	//댓글 삭제
	@RequestMapping(value = "/commentDelete", method = RequestMethod.POST)
	public String commentDelete(int comment_no, int board_no) throws Exception {
		boardService.bcommentDelete(comment_no);
		return "redirect:/board/boardDetail?board_no="+board_no;
	}
			
			
	//댓글 입력
	@RequestMapping(value = "/commentInsert", method = RequestMethod.POST)
	public String commentInsert(BcommentVO vo) throws Exception {
		boardService.bcommentInsert(vo);
		boardService.updateCommentCnt(vo.getBoard_no());
		return "redirect:/board/boardDetail?board_no="+vo.getBoard_no();
	}
			
			
	// 댓글 수정 POST
	@RequestMapping(value="/commentModify", method=RequestMethod.POST)
	public String commentUpdate2(Model model, HttpServletRequest request, @RequestParam("comment_no") int no, BcommentVO bcommentVO, HttpSession session,
	        RedirectAttributes rttr) throws Exception {
		
		BcommentVO comment = boardService.getComment(no);
	    
	    bcommentVO.setComment_no(no);
	    boardDAO.bcommentUpdate(bcommentVO);
	    
	    model.addAttribute("comment", comment);
	    return "modify_confirm"; // 업데이트 성공 여부를 보여주는 화면으로 리다이렉트
	    
	}		
			
	// 댓글 수정 GET(이동)
	@RequestMapping(value="/commentUpdate", method=RequestMethod.GET)
	public String commentUpdate(Model model, HttpServletRequest request, @RequestParam("comment_no") int comment_no, HttpSession session) throws Exception {
		
		BcommentVO comment = boardService.getComment(comment_no);
		UserVO user = (UserVO) session.getAttribute("user");
		
		//로그인 유무 확인
		if (user == null) {
			request.setAttribute("msg", "로그인을 해주세용!");
			request.setAttribute("url", "/login");
	        return "alert";
		}
		
		//글쓴이와 유저가 같은지 확인하기
		if (user.getUser_no() == comment.getUser_no()) {
			model.addAttribute("comment", comment);
			return "/board/commentUpdate";
		} else  {
			request.setAttribute("msg", "권한이 없습니다!");
			request.setAttribute("url", "/Board/BoardList");
	        return "alert";
		} 
		
	}
			
		
			
			
	//수정하기 페이지로 이동
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdate(int board_no, Model model, HttpSession session, HttpServletRequest request) throws Exception {
		BoardVO data = boardService.boardDetail(board_no);
		UserVO user = (UserVO) session.getAttribute("user");
		
		
		//로그인 유무 확인
		if (user == null) {
			request.setAttribute("msg", "로그인을 해주세용!");
			request.setAttribute("url", "/login");
	        return "alert";
		}
		
		//글쓴이와 유저가 같은지 확인하기
		if (user.getUser_no() == data.getUser_no()) {
			model.addAttribute("data", data);
			return "/board/boardUpdate";
		} else  {
			request.setAttribute("msg", "권한이 없습니다!");
			request.setAttribute("url", "/Board/BoardList");
	        return "alert";
		} 
	}
		
		
    //게시글 수정
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdate(BoardVO vo, HttpServletRequest request) throws Exception {
	    boardService.boardUpdate(vo); 
	    
	    return "redirect:/board/boardList";
	}

	// 방명록목록
	@RequestMapping(value = "/gbookList", method = RequestMethod.GET)
	public String getGbookList(Model model, HttpSession session, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword, @RequestParam(value="order", required=false) String order) throws Exception {

		UserVO user = (UserVO) session.getAttribute("user");
		//int user_no = user.getUser_no();
		
		System.out.println(keyword);
		
		int listCnt = gbookservice.getGbookCnt(keyword);
		
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, listCnt);
		pagination.setKeyword(keyword);
		pagination.setOrder(order);

		List<GbookVO> gbooklist = gbookservice.gbookList(pagination);
		model.addAttribute("pagination", pagination);
		model.addAttribute("gbookList", gbooklist);

		return "board/gbookList";
	}

}

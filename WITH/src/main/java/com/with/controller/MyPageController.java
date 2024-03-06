package com.with.controller;

import java.io.File;
import java.net.URLDecoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.service.UserService;
import com.with.Pagination;
import com.with.dao.GbookDAO;
import com.with.service.BoardService;
import com.with.service.GbookService;
import com.with.service.MyPageService;
import com.with.service.PlaceService;
import com.with.vo.BcommentVO;
import com.with.vo.BoardVO;
import com.with.vo.BookmarkVO;
import com.with.vo.FileVO;
import com.with.vo.GbookVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;
import com.with.vo.myPageVO;

@Controller
@RequestMapping("/myPage")
public class MyPageController {
	
	private static final Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@Autowired
	public GbookDAO gbookdao;
	
	@Inject
	MyPageService service;
	
	@Inject
	UserService userService;
	
	@Inject
	BoardService boardService;
	
	@Inject
	PlaceService placeService;
	
	@Inject
	GbookService gbookservice;

	
    // 회원정보 불러오기
	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String getRegister(HttpSession session, Model model) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    
	    if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
	        return "redirect:/login";
	    }
	    
//	    int user_birth = user.getUser_birth();
//	    String year = String.valueOf(user_birth).substring(0,2) + "년 ";
//	    String month = " " + String.valueOf(user_birth).substring(2,4) + "월 ";
//	    String day = " "+String.valueOf(user_birth).substring(4,6) + "일 ";
//	    String birth = year+month+day;
	    
	    String year =  user.getUser_birth().substring(0,2) + "년 ";
	    String month = " " +  user.getUser_birth().substring(2,4) + "월 ";
	    String day = " "+ user.getUser_birth().substring(4,6) + "일 ";
	    String birth = year+month+day;
	    
	    model.addAttribute("info", user);
	    model.addAttribute("birth", birth);
	    
	    return "/myPage/myPage";
	}
	
	// 회원정보 수정 폼
	@RequestMapping(value = "/myPageUpdate", method = RequestMethod.GET)
	public String getUpdatePage(HttpSession session, Model model) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    
	    if(user==null) {
	        return "redirect:/login";
	    }
	    
	    model.addAttribute("info", user);
	    
	    return "/myPage/myPageUpdate";
	}
	
	// 회원정보 수정 처리
	@RequestMapping(value = "/myPageUpdate", method = RequestMethod.POST)
	public String updateUser(UserVO vo, HttpSession session, RedirectAttributes rttr) {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }
	    try {
	    	userService.updateUser(vo);
	        session.setAttribute("user", vo); // Update the user in the session
	        rttr.addFlashAttribute("msg", "정보 수정이 완료되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace();
	        rttr.addFlashAttribute("msg", "정보 수정 중 오류가 발생했습니다.");
	    }
	    return "redirect:/myPage/myPage";
	}
	
	// 비번 수정 폼
	@RequestMapping(value = "/changePw", method = RequestMethod.GET)
	public String getChangePw(HttpSession session, Model model) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
	        return "redirect:/login";
	    }
	    
	    model.addAttribute("info", user);
	    
	    return "/myPage/pw";
	}
	
	//비밀번호 변경
	@RequestMapping(value = "/changePw", method = RequestMethod.POST)
	public String changePw(@RequestParam Map<String, Object> paramMap, UserVO vo, RedirectAttributes rttr, Model model, HttpSession session) throws Exception {

		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
	        return "redirect:/login";
	    }
		
	    model.addAttribute("info", user);
	    
	    //로그인된 회원번호를 paramMap에 추가 후 MyPageService로 보냄
	    paramMap.put("user_no", vo.getUser_no());
		int result = service.changePw(paramMap);
		
		String msg = null;
		String path = null;
		
		if(result >0) {
			msg = "비밀번호 변경 성공";
			path = "/myPage/myPage";
			model.addAttribute("msg", "비밀번호 변경 성공");
			model.addAttribute("url", "myPage");
			return "alert";
		} else {
			msg = "현재 비밀번호와 일치하지 않습니다.";
			path = "/myPage/pw";
		}
		
		rttr.addFlashAttribute("msg",msg);
		return path;
	}
	
	// 나의 게시글 목록
	@RequestMapping(value = "/myBoardList", method = RequestMethod.GET)
	public String getRegister(Model model, HttpSession session, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(value="order",required = false) String order, String keyword) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
		   
		    return "redirect:/login";
		}
		
		Pagination pagination = new Pagination();   
		int user_no = user.getUser_no(); 
		pagination.setUser_no(user.getUser_no());
		int listCnt = boardService.myCountBoardList(user_no);
		pagination.pageInfo(page, range, listCnt);
		pagination.setKeyword(keyword);
		pagination.setOrder(order);
		
		List<BoardVO> list = boardService.getMyBoardList(pagination);

		
		model.addAttribute("pagination", pagination); 
		model.addAttribute("boardList", list);

		return "/myPage/myBoardList";
	}
	
	// 게시글 상세+댓글
	@RequestMapping(value = "/myBoardDetail/{board_no}", method = RequestMethod.GET)
	public String getBoardDetail(@PathVariable("board_no") int board_no, Model model,HttpSession session) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }
		BoardVO board = boardService.myBoardDetail(board_no);
		List<BcommentVO> comments = boardService.getMyComments(board_no);

		model.addAttribute("board", board);
		model.addAttribute("comments", comments);
		model.addAttribute("cnt", comments.size());

		return "/myPage/myBoardDetail";
	}
	
    //게시글 삭제
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
    public String boardDelete(int board_no,HttpSession session) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }
		
		boardService.myBoardDelete(board_no);
		
        return "redirect:/myPage/myBoardList";
    }
	
	private static final String filePath = "C:\\stsApp\\WITH\\src\\main\\webapp\\resources\\img\\board\\";
    
	// 게시글 수정
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdate(BoardVO vo, int board_no, HttpServletRequest request) throws Exception {
	    vo.setBoard_no(board_no);

	    // 현재 있는 파일 지우기
	   File ffile = null;
	   if(vo.getBoard_img()!=null && vo.getBoard_img()!="") {
		   ffile = new File(filePath+URLDecoder.decode(vo.getBoard_img(),"UTF-8"));
		   ffile.delete();
		   
		   String originFileN = ffile.getAbsolutePath().replace("s_", "");
		   ffile = new File(originFileN);
		   ffile.delete();
	   }
	    
	    MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
		Iterator<String> iterator = multipartHttpServletRequest.getFileNames();
		MultipartFile multipartFile = null;
		String originalFileName = null;
		String originalFileExtension = null;
		String storedFileName = null;

		FileVO fileVO = new FileVO();

		File file = new File(filePath);

		if (file.exists() == false) {
			file.mkdirs();
		}

		while (iterator.hasNext()) {
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if (multipartFile.isEmpty() == false) {
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;

				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);

				fileVO.setBOARD_NO(vo.getBoard_no());
				fileVO.setOriginal_file_name(originalFileName);
				fileVO.setStored_file_name(storedFileName);
				fileVO.setFile_size(multipartFile.getSize());

				boardService.boardFileUpdate(fileVO);
				vo.setBoard_img(storedFileName);
			}
		}


	    boardService.myBoardUpdate(vo);

	    return "redirect:/myPage/myBoardDetail/" + vo.getBoard_no();
	}
	
	public static String getRandomString() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	// 나의 북마크 리스트
	@RequestMapping(value = "/myBookMark", method = RequestMethod.GET)
	public void showBookmarks(HttpSession session, Model model,
	        @RequestParam(required = false, defaultValue = "1") int page,
	        @RequestParam(required = false, defaultValue = "1") int range) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if (user == null) {
	        throw new Exception("로그인이 필요한 서비스입니다.");
	    }

	    Pagination pagination = new Pagination();
	    
	    int user_no = user.getUser_no();
	    
	    pagination.setUser_no(user.getUser_no());
	    int listCnt = placeService.myCountBookmark(user_no);
	    pagination.pageInfo(page, range, listCnt);

	    List<PlaceVO> bookmarks = placeService.getPagination(pagination);

	    model.addAttribute("pagination", pagination);
	    model.addAttribute("bookMark", bookmarks);
	}


	//북마크 추가
	@RequestMapping(value = "/bookmarkAdd", method = RequestMethod.GET)
	public String addBookmark(BookmarkVO vo, HttpSession session) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    placeService.addBookmark(vo);

//		    return "redirect:/place/?place_no=" + vo.getPlace_no();
	    return "redirect:/";
	}

	//북마크 삭제
	@RequestMapping(value = "/bookmarkRemove", method = RequestMethod.GET)
	public String removeBookmark(BookmarkVO vo, HttpSession session) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");	
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    
	    placeService.removeBookmark(vo);

//		    return "redirect:/place/?place_no=" + vo.getPlace_no();
	    return "redirect:/myPage/myBookMark";
	}
	
	// 나의 방명록
	@RequestMapping(value = "/myGbookList", method = RequestMethod.GET)
	public String getMyGbookList(Model model, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
		if(user==null) {
	        return "redirect:/login";
	    }
		Pagination pagination = new Pagination();
		pagination.setUser_no(user.getUser_no());
		int listCnt = gbookservice.getMyGbookListCnt(user.getUser_no());
		pagination.pageInfo(page, range, listCnt);
		
		// 모든 장소의 방명록을 가져옵니다.
		List<GbookVO> list = gbookservice.myGbooklist(pagination);
		model.addAttribute("pagination", pagination);
		model.addAttribute("gbookList", list);
		return "/myPage/myGbookList";
	}

	// 방명록 삭제
	@RequestMapping(value = "/gbookDelete", method = RequestMethod.GET)
	public String gbook_delete(Model model, HttpServletRequest request, @RequestParam("gbook_no") int gbookNo,
			@RequestParam("place_no") int place_no, RedirectAttributes rttr,HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
	    if (user == null) {
	        throw new Exception("로그인이 필요한 서비스입니다.");
	    }
		System.out.println(place_no);
		gbookdao.delete(gbookNo);
		gbookservice.updateGbookCnt(place_no);
		model.addAttribute("gbookDelete", gbookNo);
		return "redirect:/myPage/myGbookList";
	}

	//장소 상세
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String viewPlaceDetail(@RequestParam("place_no") int placeNo, Model model) throws Exception {
		// 장소 상세 정보를 가져오는 서비스 호출
		PlaceVO place = placeService.get(placeNo);

		// 모델에 장소 정보 추가
		model.addAttribute("place", place);

		// 장소 상세 페이지로 이동
		return "/place/detail";
	}
	
	//방명록 수정
	@RequestMapping(value = "/gbookUpdate", method = RequestMethod.GET)
	public String gbookUpdate(Model model, HttpServletRequest request, @RequestParam("gbook_no") int no,
			RedirectAttributes rttr, HttpSession session) throws Exception {
		GbookVO gbook = gbookdao.gbook(no);
		UserVO user = (UserVO) session.getAttribute("user");
	    if (user == null) {
	        throw new Exception("로그인이 필요한 서비스입니다.");
	    }
		model.addAttribute("gbook", gbook);
		model.addAttribute("gbook_no", no); // gbook_no를 파라미터로 전달받은 값으로 설정

		return "myPage/gbookUpdate";
	}

	//방명록 수정 확인
	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String updateGbook(Model model, HttpServletRequest request, @RequestParam("gbook_no") int no,
			GbookVO gbookVO, HttpSession session, RedirectAttributes rttr) throws Exception {
		GbookVO gbook = gbookdao.gbook(no);
		UserVO user = (UserVO) session.getAttribute("user");
		
	    if (user == null) {
	        throw new Exception("로그인이 필요한 서비스입니다.");
	    }
		gbookVO.setGbook_no(no);
		gbookdao.update(gbookVO); // 업데이트한 결과를 받아옴
		// model.addAttribute("gbook_update", result); // 결과를 모델에 추가
		model.addAttribute("gbook", gbook);
		return "modify_confirm"; 
	}
}

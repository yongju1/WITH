package com.with.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.with.service.PlaceService;
import com.with.service.UserService;
import com.with.vo.BookmarkVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
//	@Inject
//	UserService userService;
	@Inject
	PlaceService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) throws Exception {
		logger.info("get register");
		
		UserVO user = (UserVO) session.getAttribute("user");
	    List<Integer> blist = new ArrayList<>();
	    if(user!=null) {
	        blist = service.getBookmarksList(user.getUser_no());
	    }
	    model.addAttribute("bookList", blist);
		List<PlaceVO> type0 = new ArrayList<PlaceVO>();
		List<PlaceVO> type1 = new ArrayList<PlaceVO>();
		
		List<PlaceVO> type2 = new ArrayList<PlaceVO>();
		List<PlaceVO> type3 = new ArrayList<PlaceVO>();
		List<PlaceVO> type4 = new ArrayList<PlaceVO>();
		List<PlaceVO> type5 = new ArrayList<PlaceVO>();
		List<PlaceVO> type6 = new ArrayList<PlaceVO>();
		try {
			type0 = service.getList(0);
			type1 = service.getList(1);
			
			type2 = service.getList("서울%");
			type3 = service.getList("경기%");
			type4 = service.getList("강원%");
			type5 = service.getList("부산%");
			type6 = service.getList("제주%");
		} catch(Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("type0", type0);
		model.addAttribute("type1", type1);
		model.addAttribute("type2", type2);
		model.addAttribute("type3", type3);
		model.addAttribute("type4", type4);
		model.addAttribute("type5", type5);
		model.addAttribute("type6", type6);
		
		return "home";
	}
   
   @RequestMapping(value = "/signup", method = RequestMethod.GET)
   public String signup() {
      return "/account/signUp";
   }
   
   @RequestMapping(value = "/login", method = RequestMethod.GET)
   public String login() {
      return "/account/login";
   }
   
   @RequestMapping(value = "/id", method = RequestMethod.GET)
   public String id() {
      return "/account/findIdResult";
   }
   
   @RequestMapping(value = "/pw", method = RequestMethod.GET)
   public String pw() {
      return "/account/findPwResult";
   }
   
	//디테일 북마크 추가
	@RequestMapping(value = "/bookmarkAdd", method = RequestMethod.GET)
	public String addBookmark(BookmarkVO vo, HttpSession session) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }
	
	    vo.setUser_no(user.getUser_no());
	    service.addBookmark(vo);
	
	    return "redirect:/";
	}

	//디테일 북마크 삭제
	@RequestMapping(value = "/bookmarkRemove", method = RequestMethod.GET)
	public String removeBookmark(BookmarkVO vo, HttpSession session) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    
	    service.removeBookmark(vo);

	    return "redirect:/";
	}
   

}

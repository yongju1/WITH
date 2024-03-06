package com.with.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.Pagination;
import com.with.dao.GbookDAO;
import com.with.service.GbookService;
import com.with.service.PlaceService;
import com.with.vo.BookmarkVO;
import com.with.vo.GbookVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;

import net.sf.json.JSONArray;

@Controller
@RequestMapping("/place")
public class PlaceController {

	private static final Logger logger = LoggerFactory.getLogger(PlaceController.class);

	@Autowired
	public GbookDAO gbookdao;
	
	@Inject
	PlaceService service;
	
	@Inject
	GbookService gbookservice;

		
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String getRegister(Model model, int place_no, HttpSession session) throws Exception {
		PlaceVO place = service.get(place_no);
		
		UserVO user = (UserVO) session.getAttribute("user");
	    List<Integer> blist = new ArrayList<>();
	    if(user!=null) {
	        blist = service.getBookmarksList(user.getUser_no());
	    }
	    
	    List<GbookVO> list = gbookservice.gbookList(place_no);
		model.addAttribute("gbookList", list);
		
		model.addAttribute("place",place);
		model.addAttribute("bookList", blist);
		return "detail";
	}
	
	//헤더 장소 검색
	@RequestMapping(value = "/searchPlace", method = RequestMethod.GET)
	public String searchPlace(Model model, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword, HttpSession session) throws Exception {
		
		int listCnt = service.getPlaceListCnt(keyword);
		   
	   Pagination pagination = new Pagination();
	   pagination.pageInfo(page,range,listCnt);
	   pagination.setKeyword(keyword);
	   
	   UserVO user = (UserVO) session.getAttribute("user");
	    List<Integer> blist = new ArrayList<>();
	    if(user!=null) {
	        blist = service.getBookmarksList(user.getUser_no());
	    }
	   
	   model.addAttribute("pagination", pagination);
	   model.addAttribute("placeList", service.searchPlace(pagination));
	   model.addAttribute("bookList", blist);
	   model.addAttribute("keyword", keyword);

	   return "placeList";
	}
	
	//카테고리 별 장소 리스트
	@RequestMapping(value = "/categoryPlace", method = RequestMethod.GET)
	public String categoryPlace(Model model, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword, @RequestParam("cate") int cate, HttpSession session) throws Exception {
		
		
		   
		Pagination pagination = new Pagination();
		pagination.setCate(cate);
		int listCnt = service.getCateListCnt(cate);
		pagination.pageInfo(page,range,listCnt);
		pagination.setKeyword(keyword);
		
		UserVO user = (UserVO) session.getAttribute("user");
	    List<Integer> blist = new ArrayList<>();
	    if(user!=null) {
	        blist = service.getBookmarksList(user.getUser_no());
	    }
		
	   
		model.addAttribute("pagination", pagination);
		model.addAttribute("placeList", service.categoryPlace(pagination));
		model.addAttribute("bookList", blist);
		model.addAttribute("cate", cate);

		return "cateList";
	}
	
	//지도 API 화면
	@RequestMapping(value="/allLocation", method=RequestMethod.GET)
	public String getAllPlaceList(Model model) throws Exception {
		List<PlaceVO> placeList = service.getList();
		int cnt = placeList.size();
		model.addAttribute("placeList",placeList);
		model.addAttribute("cnt", cnt);
		model.addAttribute("rdnmadrListJson", JSONArray.fromObject(placeList));
		return "allLocation";
	}
	
	//북마크 추가
	@RequestMapping(value = "/bookmarkAdd", method = RequestMethod.GET)
	public String addBookmark(BookmarkVO vo, HttpSession session, int place_no) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    service.addBookmark(vo);

	    return "redirect:/place/?place_no=" + place_no;
	}

	//북마크 삭제
	@RequestMapping(value = "/bookmarkRemove", method = RequestMethod.GET)
	public String removeBookmark(BookmarkVO vo, HttpSession session,int place_no) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    
	    service.removeBookmark(vo);

	    return "redirect:/place/?place_no=" + place_no;
	}
	
	// 카테고리 화면에서 북마크 추가
	@RequestMapping(value = "/catebookmarkAdd", method = RequestMethod.GET)
	public String cateaddBookmark(BookmarkVO vo, HttpSession session, @RequestParam("cate") int cate) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    service.addBookmark(vo);

	    return "redirect:/place/categoryPlace?cate=" + cate;

	}

	// 카테고리 화면에서 북마크 삭제
	@RequestMapping(value = "/catebookmarkRemove", method = RequestMethod.GET)
	public String cateremoveBookmark(BookmarkVO vo, HttpSession session, @RequestParam("cate") int cate) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    
	    service.removeBookmark(vo);

	    return "redirect:/place/categoryPlace?cate=" + cate;
	}
	
	// 검색 북마크 추가
	@RequestMapping(value = "/keywordbookmarkAdd", method = RequestMethod.GET)
	public String keywordaddBookmark(BookmarkVO vo, HttpSession session, String keyword) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    service.addBookmark(vo);
	    
	    String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
	    
	    return "redirect:/place/searchPlace?keyword=" + encodedKeyword;

	}

	// 검색 북마크 삭제
	@RequestMapping(value = "/keywordbookmarkRemove", method = RequestMethod.GET)
	public String keywordremoveBookmark(BookmarkVO vo, HttpSession session, String keyword) throws Exception {
	    UserVO user = (UserVO) session.getAttribute("user");
	    if(user==null) {
	        return "redirect:/login";
	    }

	    vo.setUser_no(user.getUser_no());
	    
	    service.removeBookmark(vo);

	    String encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
	    
	    return "redirect:/place/searchPlace?keyword=" + encodedKeyword;
	}
	
	// 방명록 삭제
	@RequestMapping(value = "/gbookDelete", method = RequestMethod.POST)
	public String gbook_delete(Model model, HttpServletRequest request, GbookVO vo,@RequestParam("gbook_no") int gbookNo, 
			RedirectAttributes rttr, @RequestParam("place_no") int place_no) throws Exception {
		vo.setPlace_no(place_no);
		gbookdao.delete(gbookNo);
		gbookservice.updateGbookCnt(place_no);
		model.addAttribute("gbookDelete", gbookNo);
		return "redirect:/place/?place_no=" + vo.getPlace_no();
	}
}

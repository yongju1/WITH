package com.with.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.Pagination;
import com.with.service.BoardService;
import com.with.service.PlaceService;
import com.with.service.UserService;
import com.with.vo.BoardVO;
import com.with.vo.FileVO;
import com.with.vo.PlaceVO;
import com.with.vo.UserVO;

@Controller
@RequestMapping("/admin/*")
public class AdminController {

	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);

	@Inject
	PlaceService placeService;
	
	@Inject
	UserService userService;
	
	@Inject
	BoardService boardService;
	
	// 회원 유저 리스트
	@RequestMapping(value = "/adminUserInfo", method = RequestMethod.GET)
	public String getUserList(HttpServletResponse response, Model model, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword, @RequestParam(value="order", required=false) String order, HttpSession session) throws Exception {
		logger.info("get UserList");
		UserVO user = (UserVO) session.getAttribute("user");
	    
	    if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
		//Map<String, String> params = new HashMap<>();
		//params.put("order", order);
		//List<UserVO> userList = new ArrayList<UserVO>();
		int listCnt = userService.getUserListCnt(keyword);
			   
		Pagination pagination = new Pagination();
		pagination.pageInfo(page,range,listCnt);
		pagination.setKeyword(keyword);
		pagination.setOrder(order);
		//userList = userService.getUserList(pagination);
		model.addAttribute("pagination", pagination);
		model.addAttribute("userList", userService.getUserList(pagination));
	    }
	    return "/admin/adminUserInfo";
	}
	
	//회원 삭제
	@RequestMapping(value = "/deleteUser", method = RequestMethod.POST)
    public String deleteUser(int user_no, HttpSession session,HttpServletResponse response) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
        userService.deleteUser(user_no);
        
	    }
		return "redirect:/admin/adminUserInfo";
    }
	
	//회원 리스트 검색
	@RequestMapping(value = "/searchUser", method = RequestMethod.POST)
	public String searchUser(String keyword, Model model, HttpSession session,HttpServletResponse response) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
	    
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
		List<UserVO> userList = userService.searchUser(keyword);
		model.addAttribute("userList", userList);
	    }
		return "admin/adminUserInfo";
	}
	 
	//회원 리스트 정렬
	@RequestMapping(value = "/userListOrdered", method = RequestMethod.GET)
	public String userListOrdered(@RequestParam(defaultValue="DESC") String order, Model model, HttpSession session,HttpServletResponse response) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
		Map<String, String> params = new HashMap<>();
		params.put("order", order);
		List<UserVO> userList = userService.getUserListOrdered(params);
		model.addAttribute("userList", userList);
	    }
		return "admin/adminUserInfo";
	}


	// 장소 업로드 get
   @RequestMapping(value = "/adminPlaceAdd", method = RequestMethod.GET)
   public String getRegister(HttpSession session,HttpServletResponse response) throws Exception {
	UserVO user = (UserVO) session.getAttribute("user");
	    
	if (user == null) {
        // 로그인하지 않은 사용자가 접근한 경우 처리
		/* throw new Exception("관리자 외 접근 금지"); */
    	try {
    		String msg = "관리자 외 접근 금지";
    		String url = "http://localhost:8080/account/login";
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    else if (user.getUser_type() == 0) {
        // 로그인하지 않은 사용자가 접근한 경우 처리
		/* throw new Exception("관리자 외 접근 금지"); */
    	try {
    		String msg = "관리자 외 접근 금지";
    		String url = "http://localhost:8080";
            response.setContentType("text/html; charset=utf-8");
            PrintWriter w = response.getWriter();
            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
            w.flush();
            w.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    } else if(user.getUser_type() == 1){
      logger.info("get register");
    }
	return "admin/adminPlaceAdd";
   }
   
   private static final String filePath = "C:\\stsApp\\WITH\\src\\main\\webapp\\resources\\img\\";

   // 장소 업로드 post
   @RequestMapping(value = "/adminPlaceAdd", method = RequestMethod.POST)
   public String getRegister(PlaceVO vo, HttpServletRequest request, HttpSession session,HttpServletResponse response) throws Exception{
	   
	   UserVO user = (UserVO) session.getAttribute("user");
	    
	   if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
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
		int index = 1;
		while(iterator.hasNext()){
			multipartFile = multipartHttpServletRequest.getFile(iterator.next());
			if(multipartFile.isEmpty() == false){
				originalFileName = multipartFile.getOriginalFilename();
				originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
	 		
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
	 		
				fileVO.setPLACE_NO(vo.getPLACE_NO());
				fileVO.setOriginal_file_name(originalFileName);
				fileVO.setStored_file_name(storedFileName);
				fileVO.setFile_size(multipartFile.getSize());
	 		
				placeService.registerFile(fileVO);
				switch(index) {
					case 1:
						vo.setPlace_img1(storedFileName);
						break;
					case 2:
						vo.setPlace_img2(storedFileName);
						break;
					case 3:
						vo.setPlace_img3(storedFileName);
						break;
				}
				index++;
			}
		}
		placeService.register(vo);
	    }
		return "redirect:/admin/adminPlaceList";
   }
   
   public static String getRandomString(){
	return UUID.randomUUID().toString().replaceAll("-", "");
   }
   
   // 장소 리스트 불러오기
   @RequestMapping(value = "/adminPlaceList", method = RequestMethod.GET)
   public String getPlaceInfoAll(HttpSession session, HttpServletResponse response, Model model, @RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword) throws Exception {
	   
	   UserVO user = (UserVO) session.getAttribute("user");
	    
	   if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	   
	   int listCnt = placeService.getPlaceListCnt(keyword);
	   
	   Pagination pagination = new Pagination();
	   pagination.pageInfo(page,range,listCnt);
	   pagination.setKeyword(keyword);
	   
	   model.addAttribute("pagination", pagination);
	   model.addAttribute("placeInfoList", placeService.getList(pagination));
	    }
	   return "admin/adminPlaceList";
   }
   
	// 장소 수정 get
	@RequestMapping(value = "/adminPlaceUpdate", method = RequestMethod.GET)
	public String getUpdate(Model model,int place_no, HttpSession session,HttpServletResponse response) throws Exception {
		
		UserVO user = (UserVO) session.getAttribute("user");
	    
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
		logger.info("get register");
	      
		PlaceVO placeinfo = placeService.get(place_no);
		model.addAttribute("placeinfo",placeinfo);
		System.out.println(placeinfo);
	    }
	      
		return "admin/adminPlaceUpdate";
	}
   
	// 장소 수정 post
	@RequestMapping(value = "/adminPlaceUpdate", method = RequestMethod.POST)
	public String postUpdate(Model model, HttpSession session, HttpServletResponse response,PlaceVO vo, HttpServletRequest request, RedirectAttributes rttr) throws Exception{
		
		UserVO user = (UserVO) session.getAttribute("user");
	    
		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
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
	   int index = 1;
	   while(iterator.hasNext()){
		   multipartFile = multipartHttpServletRequest.getFile(iterator.next());
		   if(multipartFile.isEmpty() == false){
			   	originalFileName = multipartFile.getOriginalFilename();
			   	originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
				storedFileName = getRandomString() + originalFileExtension;
	 		
				file = new File(filePath + storedFileName);
				multipartFile.transferTo(file);
	 		
				fileVO.setPLACE_NO(vo.getPLACE_NO());
				fileVO.setOriginal_file_name(originalFileName);
				fileVO.setStored_file_name(storedFileName);
				fileVO.setFile_size(multipartFile.getSize());
	 		
				placeService.registerFile(fileVO);
				switch(index) {
					case 1:
						vo.setPlace_img1(storedFileName);
						break;
					case 2:
						vo.setPlace_img2(storedFileName);
						break;
					case 3:
						vo.setPlace_img3(storedFileName);
						break;
				}
				index++;
		   }
	}
	
	/*
	 * PlaceVO placeinfo = placeService.get(place_no);
	 * model.addAttribute("placeinfo",placeinfo); System.out.println(placeinfo);
	 */
	try {
		placeService.update(vo);
        rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
    } catch (Exception e) {
        e.printStackTrace();
        rttr.addFlashAttribute("msg", "수정 중 오류가 발생했습니다.");
    }
	    }
	return "redirect:/admin/adminPlaceList";
   }
	
	// 장소 삭제
   @RequestMapping(value = "/deletePlace", method = RequestMethod.POST)
    public String deletePlace(int place_no, HttpSession session, HttpServletResponse response) throws Exception {
	   
	   UserVO user = (UserVO) session.getAttribute("user");
	    
	   if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
        placeService.deletePlace(place_no);
	    }
        return "redirect:/admin/adminPlaceList";
    }
   
	/*
	 * // 장소 리스트 불러오기
	 * 
	 * @RequestMapping(value = "/adminLocationList", method = RequestMethod.GET)
	 * public String getPlaceInfo() throws Exception {
	 * 
	 * return "admin/adminLocationList"; }
	 * 
	 * // 장소 리스트 불러오기
	 * 
	 * @RequestMapping(value = "/adminLocationList", method = RequestMethod.POST)
	 * public String getPlaceInfoAll(Model model, @RequestParam(required = false,
	 * defaultValue = "1")int page, @RequestParam(required = false, defaultValue =
	 * "1")int range, String keyword) throws Exception { int listCnt =
	 * placeService.getPlaceListCnt(keyword);
	 * 
	 * Pagination pagination = new Pagination();
	 * pagination.pageInfo(page,range,listCnt); pagination.setKeyword(keyword);
	 * 
	 * model.addAttribute("pagination", pagination);
	 * model.addAttribute("placeInfoList", placeService.getList(pagination));
	 * 
	 * return "admin/adminLocationList"; }
	 */
   
// 관리자 게시글 리스트
   @RequestMapping(value = "/adminBoardList", method = RequestMethod.GET)
	public String getAdminBoardList(Model model, HttpSession session, HttpServletResponse response,@RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword,@RequestParam(value="order", required=false) String order) throws Exception {
	   UserVO user = (UserVO) session.getAttribute("user");
	    
	   if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	   
	   logger.info("get BoardList");
		
		//Map<String, String> params = new HashMap<>();
		//params.put("order", order);
		//List<UserVO> userList = new ArrayList<UserVO>();
		int listCnt = boardService.getAdminBoardListCnt(keyword);
			   
		Pagination pagination = new Pagination();
		pagination.pageInfo(page,range,listCnt);
		pagination.setKeyword(keyword);
		pagination.setOrder(order);
		//userList = userService.getUserList(pagination);
		model.addAttribute("pagination", pagination);
		model.addAttribute("adminBoardList", boardService.boardAllList(pagination));
	}
	   return "admin/adminBoardList";
   }
   
   // 관리자 게시글 삭제
   @RequestMapping(value = "/deleteBoard", method = RequestMethod.POST)
    public String deleteBoard(int board_no, HttpSession session,HttpServletResponse response) throws Exception {
	   
	   UserVO user = (UserVO) session.getAttribute("user");
	    
	   if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
	    
        boardService.deleteBoard(board_no);
	    }
        return "redirect:/admin/adminBoardList";
    }
   
   // 관리자 게시글 검색
 	@RequestMapping(value = "/searchBoard", method = RequestMethod.POST)
 	public String searchBoard(Model model, HttpSession session,HttpServletResponse response,@RequestParam(required = false, defaultValue = "1")int page, @RequestParam(required = false, defaultValue = "1")int range, String keyword,@RequestParam(defaultValue="DESC") String order) throws Exception {
 		
 		UserVO user = (UserVO) session.getAttribute("user");
	    
 		if (user == null) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080/account/login";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
	    
	    else if (user.getUser_type() == 0) {
	        // 로그인하지 않은 사용자가 접근한 경우 처리
			/* throw new Exception("관리자 외 접근 금지"); */
	    	try {
	    		String msg = "관리자 외 접근 금지";
	    		String url = "http://localhost:8080";
	            response.setContentType("text/html; charset=utf-8");
	            PrintWriter w = response.getWriter();
	            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
	            w.flush();
	            w.close();
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    } else if(user.getUser_type() == 1){
 		
 		int listCnt = boardService.getAdminBoardListCnt(keyword);
 		
 		Pagination pagination = new Pagination();
		pagination.pageInfo(page,range,listCnt);
 		List<BoardVO> boardList = boardService.searchBoard(keyword);
 		model.addAttribute("adminBoardList", boardList);
	    }
 		return "admin/adminBoardList";
 	}
 	
 	// 관리자 게시글 정렬
	@RequestMapping(value = "/boardListOrdered", method = RequestMethod.GET)
	public String boardListOrdered(HttpSession session,HttpServletResponse response,@RequestParam(defaultValue="DESC") String order, Model model) throws Exception {
		
			UserVO user = (UserVO) session.getAttribute("user");
	    
			if (user == null) {
		        // 로그인하지 않은 사용자가 접근한 경우 처리
				/* throw new Exception("관리자 외 접근 금지"); */
		    	try {
		    		String msg = "관리자 외 접근 금지";
		    		String url = "http://localhost:8080/account/login";
		            response.setContentType("text/html; charset=utf-8");
		            PrintWriter w = response.getWriter();
		            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
		            w.flush();
		            w.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    }
		    
		    else if (user.getUser_type() == 0) {
		        // 로그인하지 않은 사용자가 접근한 경우 처리
				/* throw new Exception("관리자 외 접근 금지"); */
		    	try {
		    		String msg = "관리자 외 접근 금지";
		    		String url = "http://localhost:8080";
		            response.setContentType("text/html; charset=utf-8");
		            PrintWriter w = response.getWriter();
		            w.write("<script>alert('"+msg+"');location.href='"+url+"';</script>");
		            w.flush();
		            w.close();
		        } catch(Exception e) {
		            e.printStackTrace();
		        }
		    } else if(user.getUser_type() == 1){
		
		Map<String, String> params = new HashMap<>();
		params.put("order", order);
		List<BoardVO> boardList = boardService.getBoardListOrdered(params);
		model.addAttribute("adminBoardList", boardList);
		    }
		return "admin/adminBoardList";
	}
}

package com.with.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.service.KakaoService;
import com.with.service.NaverService;
import com.with.service.UserService;
import com.with.vo.UserVO;

@Controller
@RequestMapping("/account/*")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	//private final KakaoApi kakaoApi;
	
	@Inject
	UserService service;
	
	@Inject
	KakaoService kakaoservice;
	
	@Inject
	NaverService naverService;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
	
	// 회원가입 get
	@RequestMapping(value = "/signUp", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get register");
	}
	
	// 회원가입 post
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String postRegister(UserVO vo, Model model) throws Exception {
		logger.info("post register");
		
		int result = service.idChk(vo);
		try {
			if(result == 1) {
				return "/account/signUp"; // 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기 
			}
			else if(result == 0) {
				String inputPass = vo.getUser_pw();
				String pwd = pwdEncoder.encode(inputPass);
				vo.setUser_pw(pwd);
				
				service.register(vo); // 존재하지 않는다면 -> register
				model.addAttribute("msg", "회원가입 성공");
				model.addAttribute("url", "login");
				return "alert";
			}

		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "/account/login";
	}
	
	// 로그인 get
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public void getLogin() throws Exception {
		logger.info("get login");
	}
	
	//로그인 post
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(UserVO vo, HttpSession session, RedirectAttributes rttr, Model model) throws Exception{
		logger.info("post login");
	
		session.getAttribute("user");
		UserVO login = service.login(vo);
		
		boolean pwdMatch = pwdEncoder.matches(vo.getUser_pw(), login.getUser_pw());
		
		if(login != null && pwdMatch == true) {
			session.setAttribute("user", login);
			model.addAttribute("msg", "로그인 성공");
			model.addAttribute("url", "/");
			return "alert";
			
		}
		else {
			session.setAttribute("user", null);
			rttr.addFlashAttribute("msg", false);
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다");
			model.addAttribute("url", "login");
			return "alert";
		}
		
		//return "redirect:/";
	}
	
	//카카오 로그인
	
	/*
	 * @RequestMapping(value = "/login/oauth2/code/kakao") public String
	 * kakaoLogin(@RequestParam String code, HttpSession session) throws
	 * IOException{ System.out.println("코드 : " +code);
	 * 
	 * String access_Token = kakaoApi.getToken(code); KakaoUserVO userInfo =
	 * kakaoApi.getKakaoUserInfo(access_Token);
	 * 
	 * if (userInfo.getEmail() != null) { session.setAttribute("email",
	 * userInfo.getEmail()); session.setAttribute("nickName",
	 * userInfo.getNickname()); session.setAttribute("access_Token", access_Token);
	 * 
	 * System.out.println("**access_Token : " + access_Token);
	 * System.out.println("**nickname : " + userInfo.getNickname());
	 * System.out.println("**email : " + userInfo.getEmail()); } return
	 * "redirect:/account/login"; }
	 */
	 
	
	/*
	 * @RequestMapping(value = "/kakaoLogin", method = RequestMethod.GET) public
	 * ModelAndView kakaoLogin(@RequestParam(value = "code", required = false)
	 * String code) throws Throwable {
	 * 
	 * // 1번 System.out.println("code:" + code); return null;
	 * 
	 * 
	 * }
	 */
	//로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session, Model model) throws Exception{
		
		session.invalidate();
		
		model.addAttribute("msg", "로그아웃 성공");
		model.addAttribute("url", "/");
		return "alert";
		
		//return "redirect:/";
	}
	
	//아이디 중복 확인
	@ResponseBody
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	public int idChk(UserVO vo) throws Exception {
		int result = service.idChk(vo);
		return result;
	}
	
	//아이디 찾기 get
	@RequestMapping(value="/findId", method = RequestMethod.GET)
	public String findId() {
		logger.info("get findId");
		return "account/findId";
	}
	
	//아이디 찾기 post
	@RequestMapping(value="/findIdResult", method = RequestMethod.POST)
	public String findIdResult(UserVO vo, Model model) {
		
		logger.info("post findId");
		try {
					
			UserVO id = service.findUserId(vo);
			
			model.addAttribute("findId", id);

		} catch (Exception e) {
			model.addAttribute("msg", "오류가 발생되었습니다.");
			e.printStackTrace();
		}
		return "account/findIdResult";
	}
	
	//아이디 찾기
	@RequestMapping(value="/findIdResult", method = RequestMethod.GET)
	public String findIdResult() {
		return "account/findIdResult";
	}
	
	//비번 찾기 get
	@RequestMapping(value="/findPw", method = RequestMethod.GET)
	public String findPw() {
		logger.info("get findPw");
		return "account/findPw";
	}
	
	//비번 찾기 post
	@RequestMapping(value="/findPwResult", method = RequestMethod.POST)
	public String findPwResult(UserVO vo, Model model) {
		
		logger.info("post findPw");
		try {
			
			if(service.pwCheck(vo) == 0) {
				model.addAttribute("msg", "해당 정보가 없습니다. 다시 입력해주세요.");
				model.addAttribute("url", "findPw");
				return "alert";
			}
			String newPwd = RandomStringUtils.randomAlphanumeric(10);
			String enpassword = pwdEncoder.encode(newPwd); //발급된 임시 비밀번호 암호화시켜 db저장
			vo.setUser_pw(enpassword );
			service.pwUpdate(vo);
			model.addAttribute("newPwd", newPwd);


		} catch (Exception e) {
			e.printStackTrace();
		}
		return "account/findPwResult";
	}
	
	@RequestMapping(value = "/login/oauth2/code/kakao", method = RequestMethod.GET)
	public String kakaoLogin(@RequestParam(value = "code", required = false) String code,HttpSession session, Model model) throws Throwable {

		String access_Token = kakaoservice.getAccessToken(code);
		//kakaoservice.getKakaoUserInfo(access_Token);
		UserVO userInfo = kakaoservice.getKakaoUserInfo(access_Token);
		 
		// 1번
		System.out.println("code:" + code);
		
		// 2번
		
		System.out.println("###access_Token#### : " + access_Token);
		// 위의 access_Token 받는 걸 확인한 후에 밑에 진행
		
		/*
		 * // 3번 KakaoUserVO userInfo = kakaoservice.getKakaoUserInfo(access_Token);
		 * System.out.println("###nickname#### : " + userInfo.get("nickname"));
		 * System.out.println("###email#### : " + userInfo.get("email"));
		 */
		System.out.println("aaaaaaaaaaaaaaaaa : " + userInfo);
		UserVO login = kakaoservice.getKakaoUserInfo(access_Token);
		
		/*
		 * if (userInfo.getEmail() != null){ session.setAttribute("id",
		 * userInfo.getId()); session.setAttribute("email", userInfo.getEmail());
		 * session.setAttribute("nickName", userInfo.getNickname());
		 * session.setAttribute("access_Token", access_Token); }
		 */
				   
		 if(login != null) {
				session.setAttribute("user", login);
				model.addAttribute("msg", "로그인 성공");
				model.addAttribute("url", "/");
				return "alert";
				
		 }
		else {
			session.setAttribute("user", null);
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다");
			model.addAttribute("url", "login");
			return "alert";
		}

	}
	@RequestMapping(value = "/login/oauth2/code/naver", method = RequestMethod.GET)
	public String naverLogin(@RequestParam(value = "code", required = false) String code,HttpSession session, Model model) throws Throwable {

		String access_Token = naverService.getAccessToken(code);
		//kakaoservice.getKakaoUserInfo(access_Token);
		UserVO userInfo = naverService.getNaverUserInfo(access_Token);
		 
		// 1번
		System.out.println("code:" + code);
		
		// 2번
		
		System.out.println("###access_Token#### : " + access_Token);
		// 위의 access_Token 받는 걸 확인한 후에 밑에 진행
		
		
		System.out.println("aaaaaaaaaaaaaaaaa : " + userInfo);
		UserVO login = naverService.getNaverUserInfo(access_Token);
		
				   
		 if(login != null) {
				session.setAttribute("user", login);
				model.addAttribute("msg", "로그인 성공");
				model.addAttribute("url", "/");
				return "alert";
				
			}
			else {
				session.setAttribute("user", null);
				model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다");
				model.addAttribute("url", "login");
				return "alert";
			}

	}
}

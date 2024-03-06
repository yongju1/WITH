package com.with.controller;

import com.with.vo.GbookVO;
import com.with.vo.UserVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.with.service.GbookService;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/gbook")
public class GbookController {

	@Inject
	GbookService service;

	// 방명록 추가 기능
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addGbook(GbookVO gbookVO, HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("user");
		if (user == null) {
			return "redirect:/login"; // 로그인 페이지로 이동
		}

		// 로그인한 사용자의 번호를 설정
		gbookVO.setUser_no(user.getUser_no());

		// 방명록을 추가합니다.
		service.addGbook(gbookVO);
		service.updateGbookCnt(gbookVO.getPlace_no());

		// 방명록을 추가한 후에는 해당 장소의 상세 페이지로 이동합니다.
		return "redirect:/place/?place_no=" + gbookVO.getPlace_no();
	}
}
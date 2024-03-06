package com.with.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.with.dao.PlaceDAO;
import com.with.dao.ScheduleDAO;
import com.with.data.DateData;
import com.with.vo.PlaceVO;
import com.with.vo.ScheduleVO;
import com.with.vo.UserVO;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class ScheduleController {

   @Autowired
   public ScheduleDAO scheduleDao;

   @Autowired
   public PlaceDAO placeDao;

   private static final Logger logger = LoggerFactory.getLogger(ScheduleController.class);

   //일정표시
   @GetMapping("/schedule")
   public String getSchedule(HttpSession session, Model model) {
      // 세션에서 사용자 정보 가져오기
      UserVO user = (UserVO) session.getAttribute("user");
      System.out.println(user.getUser_no());

      // 여기서부터는 사용자 정보를 활용한 코드 작성 가능

      // 사용자 정보를 모델에 추가
      model.addAttribute("user", user);
      return null;
   }

   //일정달력
   @RequestMapping(value = "/calendar", method = RequestMethod.GET)
   public String calendar(Model model, HttpServletRequest request, DateData dateData,ScheduleVO scheduleVO) throws Exception {
      // 사용자 정보 가져오는 코드 추가
      HttpSession session = request.getSession();
      List<PlaceVO> place = placeDao.getList();
      UserVO user = (UserVO) session.getAttribute("user");
      
      scheduleDao.get(scheduleVO.getSchedule_no());
      
      System.out.println(scheduleDao.get(scheduleVO.getSchedule_no()));

      
      model.addAttribute("schedule", scheduleDao.get(scheduleVO.getSchedule_no()));
      
      // 이후 코드는 사용자 정보를 활용하여 스케줄 관련 기능을 처리하는 부분
      
      // 사용자 정보가 없는 경우 처리
      if (user == null) {
         // 세션이 없으면 로그인 페이지로 리다이렉트 또는 다른 처리
         return "redirect:/account/login";
      }

      Calendar cal = Calendar.getInstance();
      DateData calendarData;
      // 검색 날짜
      if (dateData.getDate().equals("") && dateData.getMonth().equals("")) {
         dateData = new DateData(String.valueOf(cal.get(Calendar.YEAR)), String.valueOf(cal.get(Calendar.MONTH)),
               String.valueOf(cal.get(Calendar.DATE)), null, null);
      }
      
      dateData.setUser_no(user.getUser_no());

      Map<String, Integer> today_info = dateData.today_info(dateData);
      List<DateData> dateList = new ArrayList<DateData>();
      
      

      // 검색 날짜 end
      // ScheduleDAO scheduleDao = sqlSession.getMapper(ScheduleDAO.class);
      List<ScheduleVO> Schedule_list = scheduleDao.schedule_list(dateData);

      System.out.println(Schedule_list);
      
      // 달력데이터에 넣기 위한 배열 추가
      ScheduleVO[][] schedule_data_arr = new ScheduleVO[32][4];

      if (Schedule_list.isEmpty() != true) {
         int j = 0;
         for (int i = 0; i < Schedule_list.size(); i++) {
            int date = Integer.parseInt(String.valueOf(Schedule_list.get(i).getSchedule_date()).substring(
                  String.valueOf(Schedule_list.get(i).getSchedule_date()).length() - 2,
                  String.valueOf(Schedule_list.get(i).getSchedule_date()).length()));
            if (i > 0) {
               int date_before = Integer.parseInt(String.valueOf(Schedule_list.get(i - 1).getSchedule_date())
                     .substring(String.valueOf(Schedule_list.get(i - 1).getSchedule_date()).length() - 2,
                           String.valueOf(Schedule_list.get(i - 1).getSchedule_date()).length()));
               if (date_before == date) {
                  j = j + 1;
                  schedule_data_arr[date][j] = Schedule_list.get(i);
               } else {
                  j = 0;
                  schedule_data_arr[date][j] = Schedule_list.get(i);
               }
            } else {
               schedule_data_arr[date][j] = Schedule_list.get(i);
            }
         }
      }

      // 실질적인 달력 데이터 리스트에 데이터 삽입 시작.
      // 일단 시작 인덱스까지 아무것도 없는 데이터 삽입
      for (int i = 1; i < today_info.get("start"); i++) {
         calendarData = new DateData(null, null, null, null, null);
         dateList.add(calendarData);
      }

      // 날짜 삽입
      for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
         ScheduleVO[] schedule_data_arr3 = new ScheduleVO[4];
         schedule_data_arr3 = schedule_data_arr[i];

         if (i == today_info.get("today")) {
            calendarData = new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()),
                  String.valueOf(i), "today", schedule_data_arr3);
         } else {
            calendarData = new DateData(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()),
                  String.valueOf(i), "normal_date", schedule_data_arr3);
         }
         dateList.add(calendarData);

      }

      // 달력 빈 곳 빈 데이터로 삽입
      int index = 7 - dateList.size() % 7;

      if (dateList.size() % 7 != 0) {

         for (int i = 0; i < index; i++) {
            calendarData = new DateData(null, null, null, null, null);
            dateList.add(calendarData);
         }
      }
      

      // 배열에 담음
      model.addAttribute("place", place);
      model.addAttribute("dateList", dateList); // 날짜 데이터 배열
      model.addAttribute("today_info", today_info);
      return "calendar";
   }

   //일정추가
   @RequestMapping(value = "/schedule_add", method = RequestMethod.GET)
   public String schedule_add(HttpServletRequest request, ScheduleVO scheduleVO, RedirectAttributes rttr,
         HttpSession session) throws Exception {
      // ScheduleDAO scheduleDao = sqlSession.getMapper(ScheduleDAO.class);
      UserVO user = (UserVO) session.getAttribute("user");
      // System.out.println(user.getUser_no());
      scheduleVO.setUser_no(user.getUser_no());

      int count = scheduleDao.before_schedule_add_search(scheduleVO);
      String message = "";
      String url = "redirect:calendar";

      if (count >= 4) {
         message = "일정은 최대 4개만 등록 가능합니다.";
      } else {
         scheduleDao.schedule_add(scheduleVO);
         message = "일정이 등록되었습니다";
      }

      rttr.addFlashAttribute("message", message);
      return url;
   }

   //일정 수정, 삭제팝업창
   @RequestMapping(value = "/schedule_show", method = RequestMethod.GET)
   public String schedule_show(Model model, HttpServletRequest request, @RequestParam("schedule_no") int no,
         RedirectAttributes rttr) throws Exception {
      // ScheduleDAO scheduleDao = sqlSession.getMapper(ScheduleDAO.class);
      String url = "redirect:calendar";
      List<PlaceVO> place = placeDao.getList();
      scheduleDao.get(no);

      model.addAttribute("place", place);
      model.addAttribute("schedule_show", scheduleDao.get(no));
      return null;
   }

   //수정 알림창
   @RequestMapping(value = "modify", method = RequestMethod.POST)
   public String schedule_modify(Model model, HttpServletRequest request, ScheduleVO scheduleVO,
         RedirectAttributes rttr) throws Exception {
      // ScheduleDAO scheduleDao = sqlSession.getMapper(ScheduleDAO.class);
      scheduleDao.update(scheduleVO);
      model.addAttribute("schedule_modify", scheduleDao.update(scheduleVO));
      return "modify_confirm";
   }
   
   //삭제알림창
   @RequestMapping(value = "/delete", method = RequestMethod.GET)
   public String schedule_delete(Model model, HttpServletRequest request, @RequestParam("schedule_no") int scheduleNo,
         RedirectAttributes rttr) throws Exception {
      // ScheduleDAO scheduleDao = sqlSession.getMapper(ScheduleDAO.class);
      scheduleDao.delete(scheduleNo);
      model.addAttribute("schedule_delete", scheduleNo);
      return "delete_confirm";
   }
}
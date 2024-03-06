package com.with.service;

import java.util.List;

import com.with.data.DateData;
import com.with.vo.ScheduleVO;

public interface ScheduleService {
	
	// 일정추가
	int addSchedule(ScheduleVO scheduleVO) throws Exception;

	//같은 날 일정 개수
	int checkDuplicateSchedule(ScheduleVO scheduleVO) throws Exception;

	//일정 가져오기
	List<ScheduleVO> getScheduleList(DateData dateData) throws Exception;

	//일정 내용 가져오기
	ScheduleVO getSchedule(int schedule_no) throws Exception;

	// 일정 수정
	int updateSchedule(ScheduleVO scheduleVO) throws Exception;

	// 일정 삭제
	int deleteSchedule(int schedule_no) throws Exception;
}
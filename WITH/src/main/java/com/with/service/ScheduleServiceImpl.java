package com.with.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.with.dao.ScheduleDAO;
import com.with.data.DateData;
import com.with.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    
    private final ScheduleDAO scheduleDAO;
    
    @Autowired
    public ScheduleServiceImpl(ScheduleDAO scheduleDAO) {
        this.scheduleDAO = scheduleDAO;
    }
    
    //일정 추가
    @Override
    public int addSchedule(ScheduleVO scheduleVO) throws Exception {
        return scheduleDAO.schedule_add(scheduleVO);
    }
    
    //같은 날 일정 개수
    @Override
    public int checkDuplicateSchedule(ScheduleVO scheduleVO) throws Exception {
        return scheduleDAO.before_schedule_add_search(scheduleVO);
    }
    
    //일정 목록 가져오기
    @Override
    public List<ScheduleVO> getScheduleList(DateData dateData) throws Exception {
        return scheduleDAO.schedule_list(dateData);
    }
    
    //일정 내용 가져오기
    @Override
    public ScheduleVO getSchedule(int idx) throws Exception {
        return scheduleDAO.get(idx);
    }
    
    //일정 수정
    @Override
    public int updateSchedule(ScheduleVO scheduleVO) throws Exception {
        return scheduleDAO.update(scheduleVO);
    }
    
    // 일정 삭제
    @Override
    public int deleteSchedule(int schedule_no) throws Exception {
        return scheduleDAO.delete(schedule_no);
    }
}

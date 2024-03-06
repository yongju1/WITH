package com.with.dao;

import java.util.List;

import com.with.data.DateData;
import com.with.vo.ScheduleVO;

public interface ScheduleDAO {
    public int schedule_add(ScheduleVO scheduleVO) throws Exception;
    public int before_schedule_add_search(ScheduleVO scheduleVO) throws Exception;
    public List<ScheduleVO> schedule_list(DateData dateData) throws Exception;
    
    /* 수정, 삭제를 위한 리스트 불러오기 */
    // 조회하기 
    public ScheduleVO get(int idx) throws Exception;
    
    // 수정하기 
    public int update(ScheduleVO scheduleVO) throws Exception;
    
    // 삭제하기 
    public int delete(int schedule_no) throws Exception;
}

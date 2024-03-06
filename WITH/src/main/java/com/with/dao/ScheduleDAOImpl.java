package com.with.dao;

import java.util.List;
import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.with.data.DateData;
import com.with.vo.ScheduleVO;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ScheduleDAOImpl implements ScheduleDAO {
    
    @Inject
    private final SqlSession sqlSession;

    @Override
    public int schedule_add(ScheduleVO scheduleVO) throws Exception {
        return sqlSession.insert("scheduleMapper.schedule_add", scheduleVO);
    }

    @Override
    public int before_schedule_add_search(ScheduleVO scheduleVO) throws Exception {
        return sqlSession.selectOne("scheduleMapper.before_schedule_add_search", scheduleVO);
    }

    @Override
    public List<ScheduleVO> schedule_list(DateData dateData) throws Exception {
        return sqlSession.selectList("scheduleMapper.schedule_list", dateData);
    }

    @Override
    public ScheduleVO get(int idx) throws Exception {
        return sqlSession.selectOne("scheduleMapper.get", idx);
    }

    @Override
    public int update(ScheduleVO scheduleVO) throws Exception {
        return sqlSession.update("scheduleMapper.update", scheduleVO);
    }

    @Override
    public int delete(int schedule_no) throws Exception {
        return sqlSession.delete("scheduleMapper.delete", schedule_no);
    }
}

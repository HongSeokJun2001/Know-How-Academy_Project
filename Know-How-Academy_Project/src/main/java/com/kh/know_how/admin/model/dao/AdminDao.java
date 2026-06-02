package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;

@Repository
public class AdminDao {

	public int selectAlarmCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.selectAlarmCount");
	}

	public ArrayList<AdminCounselWaitingDto> selectWaitingList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectWaitingList");
	}

	public int selectCounselWaitingCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.selectCounselWaitingCount");
	}

	public ArrayList<TodayReservationDto> selectTodayReservationList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectTodayReservationList");
	}

	public int todayReservationCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.todayReservationCount");
	}

	public AdminDashboardStatsDto selectdashboardStats(SqlSessionTemplate sqlSession) {
		
		return (AdminDashboardStatsDto)sqlSession.selectList("adminMapper.selectdashboardStats");
	}

	
	
	
	
	
	
	
	
}//클래스 끝

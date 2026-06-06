package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.common.PageResponseDto;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.ClassListDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
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

	public ArrayList<AdminDashboardStatsDto>  selectDashboardStats(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectdashboardStats");
	}

	public int selectlistCount(SqlSessionTemplate sqlSession, CounselorSearchRequestDto counselorSearchRequestDto) {

		return sqlSession.selectOne("adminMapper.selectlistCount",counselorSearchRequestDto);
	}

	public ArrayList<CounselorListResponseDto> selectcounselorList(SqlSessionTemplate sqlSession,
			CounselorSearchRequestDto counselorSearchRequestDto) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectcounselorList",counselorSearchRequestDto);
	}

	public ArrayList<ClassListDto> selectClassList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectClassList");
	}

	public int updateCounselorClass(SqlSessionTemplate sqlSession, Map<String, Integer> param) {
		
		return sqlSession.update("adminMapper.updateCounselorClass", param);
	}

	public ArrayList<CounselCategoryDto> selectCounselCategory(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectCounselCategory");
	}





	
	
	
	
	
	
	
	
}//클래스 끝

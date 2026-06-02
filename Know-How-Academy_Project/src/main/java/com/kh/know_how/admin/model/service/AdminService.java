package com.kh.know_how.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.model.dao.AdminDao;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;

@Service
public class AdminService {
	
	//필드부
	@Autowired
	AdminDao ad;
	@Autowired
	SqlSessionTemplate sqlSession;
	
	//메소드부
	@Transactional(readOnly = true)
	public int selectAlarmCount() {
		
		return ad.selectAlarmCount(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public ArrayList<AdminCounselWaitingDto> selectWaitingList() {
		
		return ad.selectWaitingList(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public int selectCounselWaitingCount() {
		
		return ad.selectCounselWaitingCount(sqlSession);
	}

	@Transactional(readOnly = true)
	public ArrayList<TodayReservationDto> selectTodayReservationList() {
		
		return ad.selectTodayReservationList(sqlSession);
	}

	public int todayReservationCount() {
		
		return ad.todayReservationCount(sqlSession);
	}

	public AdminDashboardStatsDto selectdashboardStats() {
		
		//int 타입 currHiredCount, prevHiredCount, currEnrollCount, prevEnrollCount
		AdminDashboardStatsDto adbs = ad.selectdashboardStats(sqlSession);
		
		// double 타입, % 계산 CheckList : 
		// 1. 분모가 0일 경우 어떻게 처리합니까?  
		// 2. 분모와 분자를 제대로 지정했습니까? (헷갈릴 경우 따로 변수를 선언한 뒤 사용하세요)
		// 3. NULL이 존재할 가능성은 없습니까? 
		// 4. 반올림이 필요합니까?
		// 5. 계산 결과가 원하는 자료형으로 나왔습니까? (정수끼리 나눌경우 소수점이 나오지 않습니다)
		// 6. 계산 결과가 생각한 결과와 일치합니까?
		// 7. 0% 미만(음수)이거나 100% 이상의 초과 값이 나와도 정상입니까?
		
		// + 하드코딩 같으면 DB에서 가져온다
		
		int currHiredCount = adbs.getCurrHiredCount();   // 진학상담건수
		int currEnrollCount = adbs.getCurrEnrollCount();  // 입학상담건수
		
		int currTotalCount = adbs.getCurrHiredCount() + adbs.getCurrEnrollCount();  // 이번달 전체 상담신청 건수
		
		
		
		int enrollRate;
		int hiredRate;
		
		
		/*
		AdminDashboardStatsDto dto = dao.selectMonthlyStats();

		int total = dto.getCurrEnrollCount()
		          + dto.getCurrHiredCount();
		
		dto.setEnrollRate(
		    total == 0 ? 0 :
		    dto.getCurrEnrollCount() * 100.0 / total
		);
		
		dto.setHiredRate(
		    total == 0 ? 0 :
		    dto.getCurrHiredCount() * 100.0 / total
		); 
		 */
		
		return ad.selectdashboardStats(sqlSession);
	}

	
	
	
	
	
	
	
	
	
}//클래스 끝

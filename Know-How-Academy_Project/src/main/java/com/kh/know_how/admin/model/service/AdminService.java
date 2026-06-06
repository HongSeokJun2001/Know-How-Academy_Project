package com.kh.know_how.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.model.dao.AdminDao;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
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

	public int todayReservatioCount() {
		
		return ad.todayReservatioCount(sqlSession);
	}

	
	
	
	
	
	
	
	
	
}//클래스 끝

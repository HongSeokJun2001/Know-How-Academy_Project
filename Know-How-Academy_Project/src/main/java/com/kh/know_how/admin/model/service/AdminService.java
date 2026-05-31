package com.kh.know_how.admin.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.model.dao.AdminDao;

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

	
	
	
	
	
	
	
	
	
}//클래스 끝

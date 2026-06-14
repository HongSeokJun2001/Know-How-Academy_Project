package com.kh.know_how.counselor.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.common.model.vo.ClassPageInfo;
import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.counselor.model.dao.CounselorDao;
import com.kh.know_how.counselor.model.vo.Class;

@Service
public class CounselorService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CounselorDao counselorDao;

	public ArrayList<Class> selectClassDetailList() {
		
		return counselorDao.selectClassDetailList(sqlSession);
	}
	
	

	
	
}

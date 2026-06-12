package com.kh.know_how.counselor.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.common.model.vo.ClassPageInfo;
import com.kh.know_how.counselor.model.dao.CounselorDao;

@Service
public class CounselorService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private CounselorDao counselorDao;
	
	public int selectListCount() {
		
		return counselorDao.selectListCount(sqlSession);
	}

	public ArrayList<Class> selectClassList(ClassPageInfo pi) {
		
		return counselorDao.selectClassList(sqlSession , pi);
	}

	public int selectSearchCount(HashMap<String, String> map) {
		
	    return counselorDao.selectSearchCount(sqlSession, map);
	}

	public ArrayList<Class> searchClassList(HashMap<String, String> map, 
			                                ClassPageInfo pi) {
		
		return counselorDao.searchClassList(sqlSession, map, pi);
	}
	
}

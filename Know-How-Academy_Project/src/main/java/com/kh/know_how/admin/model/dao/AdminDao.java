package com.kh.know_how.admin.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDao {

	public int selectAlarmCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.selectAlarmCount");
	}

	
	
	
	
	
	
	
	
}//클래스 끝

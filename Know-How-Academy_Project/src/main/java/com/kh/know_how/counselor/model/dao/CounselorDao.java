package com.kh.know_how.counselor.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.common.model.vo.ClassPageInfo;

@Repository
public class CounselorDao {

	public ArrayList<Class> selectClassDetailList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("counselorMapper.selectClassDetailList");
	}

	

}

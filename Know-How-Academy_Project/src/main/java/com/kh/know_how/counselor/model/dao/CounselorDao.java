package com.kh.know_how.counselor.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.common.model.vo.ClassPageInfo;

@Repository
public class CounselorDao {

	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("counselorMapper.selectListCount");
	}
	
	public ArrayList<Class> selectClassList(SqlSessionTemplate sqlSession, ClassPageInfo pi) {
		
		int limit = pi.getClassLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		
		return (ArrayList)sqlSession.selectList("counselorMapper.selectClassList", null, rowBounds);
	}

	public int selectSearchCount(SqlSessionTemplate sqlSession, 
			                     HashMap<String, String> map) {
		
		return sqlSession.selectOne("counselorMapper.selectSearchCount", map);
	}

	public ArrayList<Class> searchClassList(SqlSessionTemplate sqlSession, 
			                                HashMap<String, String> map,
			                                ClassPageInfo pi) {
		
		int limit = pi.getClassLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("counselorMapper.searchClassList", map, rowBounds);
	}

}

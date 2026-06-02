package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.common.model.vo.PageInfo;

@Repository
public class AdminDao2 {

	public int selectStudentListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper2.selectStudentListCount");
	}

	public ArrayList<StudentDto> selectStudentList(SqlSessionTemplate sqlSession, PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectStudentList", null, rowBounds);
	}

	public int selectStudentSearchCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("adminMapper2.selectStudentSearchCount", map);
	}

	public ArrayList<StudentDto> selectStudentList(SqlSessionTemplate sqlSession, HashMap<String, String> map,
			PageInfo pi) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMapper2.searchStudentList", map, rowBounds);
	}

	public StudentDto selectStudent(SqlSessionTemplate sqlSession, int studentNo) {
		
		return sqlSession.selectOne("adminMapper2.selectStudent", studentNo);
	}

	
	
	
	
	
}//클래스 끝

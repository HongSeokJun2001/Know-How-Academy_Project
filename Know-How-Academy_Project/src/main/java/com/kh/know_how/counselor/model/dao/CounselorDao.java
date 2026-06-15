package com.kh.know_how.counselor.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.common.model.vo.ClassPageInfo;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.counselor.model.vo.Class;

@Repository
public class CounselorDao {

	public ArrayList<Class> selectClassDetailList(SqlSessionTemplate sqlSession, Member m) {
		
		return (ArrayList)sqlSession.selectList("counselorMapper.selectClassDetailList", m);
	}

	

}

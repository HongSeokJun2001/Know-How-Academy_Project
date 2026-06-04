package com.kh.know_how.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.model.dao.AdminDao2;
import com.kh.know_how.admin.model.dto.MemoDto;
import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.common.model.vo.PageInfo;

@Service
public class AdminService2 {
	
	//필드부
	@Autowired
	AdminDao2 ad2;
	
	@Autowired
	SqlSessionTemplate sqlSession;
	
	//메소드부
	public int selectStudentListCount() {
		
		return ad2.selectStudentListCount(sqlSession);
	}

	public ArrayList<StudentDto> selectStudentList(PageInfo pi) {
	
		return ad2.selectStudentList(sqlSession, pi);
	}

	public int selectStudentSearchCount(HashMap<String, String> map) {
		
		return ad2.selectStudentSearchCount(sqlSession, map);
	}

	public ArrayList<StudentDto> selectStudentList(HashMap<String, String> map, PageInfo pi) {
		
		return ad2.selectStudentList(sqlSession, map, pi);
	}

	public StudentDto selectStudentList(int studentNo) {
		
		return ad2.selectStudent(sqlSession, studentNo);
	}
	
	@Transactional
	public int insertStudentMemo(MemoDto m) {
		
		return ad2.insertStudentMemo(sqlSession, m);
	}

	public ArrayList<MemoDto> selectStudentMemo(int userNo) {
		
		return ad2.selectStudentMemo(sqlSession, userNo);
	}

	@Transactional
	public int deleteStudentMemo(int memoNo) {
		
		return ad2.deleteStudentNo(sqlSession, memoNo);
	}

	@Transactional
	public int updateStudentStatus(StudentDto s) {
	
		return ad2.updateStudentStatus(sqlSession, s);
	}
	
	
	
	
	
}//클래스 끝

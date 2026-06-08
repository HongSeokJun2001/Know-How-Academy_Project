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
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
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

	public ArrayList<MemoDto> selectStudentMemoList(int userNo) {
		
		return ad2.selectStudentMemoList(sqlSession, userNo);
	}

	@Transactional
	public int deleteStudentMemo(int memoNo) {
		
		return ad2.deleteStudentNo(sqlSession, memoNo);
	}

	@Transactional
	public int updateStudentStatus(StudentDto s) {
	
		return ad2.updateStudentStatus(sqlSession, s);
	}

	public ArrayList<StudentDto> selectPendingStudentList() {
		
		return ad2.selectPendingStudentList(sqlSession);
	}

	@Transactional
	public int updateStudentApprove(HashMap<String, Integer> map) {

		int result1 = ad2.updateStudentApprove(sqlSession, map);
		int result2 = ad2.insertStudent(sqlSession, map);
		
		return result1*result2;
	}
	
	@Transactional
	public int updateStudentReject(int userNo) {
		
		return ad2.updateStudentReject(sqlSession, userNo);
	}
	
	public int adminSelectNoticeCount() {
		
		return ad2.adminSelectNoticeCount(sqlSession);
	}
	
	public ArrayList<Board> adminSelectNoticeList(PageInfo pi) {
		
		return ad2.adminSelectNoticeList(sqlSession, pi);
	}

	public int adminSearchNoticeCount(String keyword) {
		
		return ad2.adminSearchNoticeCount(sqlSession, keyword);
	}

	public ArrayList<Board> adminSearchNoticeList(PageInfo pi, String keyword) {
		
		return ad2.adminSearchNoticeList(sqlSession, pi, keyword);
	}

	@Transactional
	public int updateNoticeStatus(Board b) {
		
		return ad2.updateNoticeStatus(sqlSession, b);
	}

	@Transactional
	public int deleteNoticeStatus(int postNo) {
		
		return ad2.deleteNotice(sqlSession, postNo);
	}

	@Transactional
	public int insertNotice(Board b, FileAttachment at) {
		
		int result1 = ad2.insertNotice(sqlSession, b);
		
		int result2 = 1;
		
		if(at != null) {
			
			result2 = ad2.insertNoticeFileAttachment(sqlSession, at);
			
		}
		
		return result1 * result2;
	}
}//클래스 끝

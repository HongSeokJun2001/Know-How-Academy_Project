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
import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;

@Service
public class AdminService2 {
	
	//필드부
	@Autowired
	AdminDao2 ad2;
	
	@Autowired
	BoardDao bd;
	
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

	public StudentDto selectStudent(int studentNo) {
		
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
	public int adminUpdateStatus(Board b) {
		
		return ad2.adminUpdateStatus(sqlSession, b);
	}

	public int adminSelectNewsListCount() {
		
		return ad2.adminSelectNewsCount(sqlSession);
	}

	public ArrayList<Board> adminSelectNewsList(PageInfo pi) {
		
		return ad2.adminSelectNewsList(sqlSession, pi);
	}

	public int adminSearchNewsCount(String keyword) {
		
		return ad2.adminSearchNewsCount(sqlSession, keyword);
	}

	public ArrayList<Board> adminSearchNewsList(PageInfo pi, String keyword) {
		
		return ad2.adminSearchNewsList(sqlSession, pi, keyword);
	}

	@Transactional
	public int insertNews(Board n, ArrayList<FileAttachment> list) {
		
		int result1 = bd.insertBoard(sqlSession, n);
		
		int result2 = ad2.insertAttachmentList(sqlSession, list);
		
		return result1 * result2;
	}

	@Transactional
	public int updateNews(Board n, ArrayList<FileAttachment> list, String[] deleteFileNo) {
		
		int result = bd.updateBoard(sqlSession, n);
		if (result <= 0) {
			return 0;
		}
		
		for(FileAttachment fa : list) {
			
			if(fa != null) {	
				int fileResult = 0;
				
				if(fa.getFileNo() != 0) {
					
					fileResult = bd.updateFileAttachment(sqlSession, fa);
				
				} else {
					
					fileResult = ad2.insertNewsFileAttachment(sqlSession, fa);
				}
				
				if(fileResult <= 0) {
	                return  0;
	            }
			}
		}
		
		if (deleteFileNo != null) {
	        for (String fileNoStr : deleteFileNo) {
	            int fileNo = Integer.parseInt(fileNoStr);
	            
	            int delResult = ad2.deleteNewsFileAttachment(sqlSession, fileNo); 
	            
	            if (delResult <= 0) {
	                return 0;
	            }
	        }
	    }
		
		return result;
	}

}//클래스 끝

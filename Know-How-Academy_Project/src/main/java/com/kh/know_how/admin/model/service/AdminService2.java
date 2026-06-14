package com.kh.know_how.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.model.dao.AdminDao2;
import com.kh.know_how.admin.model.dto.MemoInsertDto;
import com.kh.know_how.admin.model.dto.MemoListDto;
import com.kh.know_how.admin.model.dto.StudentApproveDto;
import com.kh.know_how.admin.model.dto.StudentDetailDto;
import com.kh.know_how.admin.model.dto.StudentListDto;
import com.kh.know_how.admin.model.dto.StudentPendingListDto;
import com.kh.know_how.admin.model.dto.StudentSearchListDto;
import com.kh.know_how.admin.model.dto.StudentSearchRequestDto;
import com.kh.know_how.admin.model.dto.StudentStatusDto;
import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.member.model.vo.MemberLock;

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
	public int selectStudentListCount() { // 재학, 휴학 중인 학원생의 수를 불러오는 메소드 
		
		return ad2.selectStudentListCount(sqlSession);
	}

	public ArrayList<StudentListDto> selectStudentList(PageInfo pi) { // 재학, 휴학중인 학원생의 리스트를 불러오는 메소드
	
		return ad2.selectStudentList(sqlSession, pi);
	}

	public int searchStudentCount(StudentSearchRequestDto studentSearchRequest) { // 학원생 검색 시 학원생의 수를 불러오는 메소드
		
		return ad2.searchStudentCount(sqlSession, studentSearchRequest);
	}

	public ArrayList<StudentSearchListDto> searchStudentList(StudentSearchRequestDto studentSearchRequest, PageInfo pi) { // 학원생 검색 시 리스트를 불러오는 메소드
		
		return ad2.searchStudentList(sqlSession, studentSearchRequest, pi);
	}

	public StudentDetailDto selectStudent(int studentNo) { // 학원생의 정보를 불러오는 메소드
		
		return ad2.selectStudent(sqlSession, studentNo);
	}
	
	@Transactional
	public int insertStudentMemo(MemoInsertDto memoInsert) { // 학원생의 메모를 추가하는 메소드
		
		return ad2.insertStudentMemo(sqlSession, memoInsert);
	}

	public ArrayList<MemoListDto> selectStudentMemoList(int userNo) { // 학원생의 메모 리스트를 불러오는 메소드
		
		return ad2.selectStudentMemoList(sqlSession, userNo);
	}

	@Transactional
	public int deleteStudentMemo(int memoNo) { // 학원생의 메모를 제거하는 메소드
		
		return ad2.deleteStudentMemo(sqlSession, memoNo);
	}

	@Transactional
	public int updateStudentStatus(StudentStatusDto studentStatus) { // 학원생의 휴학/재학 처리해주는 메소드
	
		return ad2.updateStudentStatus(sqlSession, studentStatus);
	}
	
	@Transactional
	public int deleteStudent(int userNo) { // 학원생의 가입을 삭제하는 메소드
		
		return ad2.deleteStudent(sqlSession, userNo);
	}

	public ArrayList<StudentPendingListDto> selectPendingStudentList() { // 학원생의 가입 대기 리스트를 불러오는 메소드
		
		return ad2.selectPendingStudentList(sqlSession);
	}

	@Transactional
	public int updateStudentApprove(StudentApproveDto studentApprove) { // 학원생의 가입을 승인하는 메소드

		return ad2.updateStudentApprove(sqlSession, studentApprove) * ad2.insertStudent(sqlSession, studentApprove);
	}
	
	@Transactional
	public int updateStudentReject(int userNo) { // 학원생의 가입을 거절하는 메소드
		
		return ad2.updateStudentReject(sqlSession, userNo);
	}
	
	public int adminSelectBoardCount(String postType) { // 공지사항, 학원소식의 개수를 불러오는 메소드
		
		return ad2.adminSelectBoardCount(sqlSession, postType);
	}
	
	public ArrayList<Board> adminSelectBoardList(PageInfo pi, String postType) { // 공지사항, 학원소식 리스트를 불러오는 메소드
		
		return ad2.adminSelectBoardList(sqlSession, pi, postType);
	}

	public int adminSearchBoardCount(HashMap<String, String> map) { // 공지사항, 학원소식 검색 시 개수를 불러오는 메소드
		
		return ad2.adminSearchBoardCount(sqlSession, map);
	}

	public ArrayList<Board> adminSearchBoardList(PageInfo pi, HashMap<String, String> map) { // 공지사항, 학원소식 검색 시 리스트를 불러오는 메소드
		
		return ad2.adminSearchBoardList(sqlSession, pi, map);
	}
	
	@Transactional
	public int adminDeleteBoard(int postNo) { // 공지사항, 학원소식을 삭제하는 메소드
		
		return ad2.adminDeleteBoard(sqlSession, postNo);
	}

	@Transactional
	public int adminDeleteFileAttachment(int postNo) { // 공지사항, 학원소식 삭제 시 파일의 정보를 삭제하는 메소드
		
		return ad2.adminDeleteFileAttachment(sqlSession, postNo);
	}
	
	@Transactional
	public int adminUpdateBoardStatus(Board b) { // 공지사항, 학원소식의 노출/숨김 처리해주는 메소드
		
		return ad2.adminUpdateBoardStatus(sqlSession, b);
	}

	@Transactional
	public int insertNews(Board n, ArrayList<FileAttachment> list) { // 학원소식을 추가하는 메소드
		
		return bd.insertBoard(sqlSession, n) * ad2.insertAttachmentList(sqlSession, list);
	}

	@Transactional
	public int updateNews(Board n, ArrayList<FileAttachment> list, String[] deleteFileNo) { // 학원소식의 정보를 수정하는 메소드
		
		int result = bd.updateBoard(sqlSession, n);
		if (result <= 0) {
			return 0;
		}
		
		for(FileAttachment fa : list) {
			
			if(fa != null) {	
				int fileResult = 0;
				
				if(fa.getFileNo() != 0) {
					
//					fileResult = bd.updateFileAttachment(sqlSession, fa);
				
				} else {
					
					fileResult = ad2.insertNewsFileAttachment(sqlSession, fa);
				}
				
				if(fileResult <= 0) {
	                return  0;
	            }
			}
		}
		
		if (deleteFileNo != null) {
	        for (String dfno : deleteFileNo) {
	            int fileNo = Integer.parseInt(dfno);
	            
	            int delResult = ad2.deleteNewsFileAttachment(sqlSession, fileNo); 
	            
	            if (delResult <= 0) {
	                return 0;
	            }
	        }
	    }
		
		return result;
	}

	public ArrayList<MemberLock> selectLockingMemberList() { // 계정이 잠긴 유저 리스트를 불러오는 메소드
		
		return ad2.selectLockingMemberList(sqlSession);
	}

	public int updateMemberUnlock(int userNo) {
		
		return ad2.updateMemberUnlock(sqlSession, userNo);
	}

}//클래스 끝

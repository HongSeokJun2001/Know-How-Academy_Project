package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.model.dto.MemoInsertDto;
import com.kh.know_how.admin.model.dto.MemoListDto;
import com.kh.know_how.admin.model.dto.StudentApproveDto;
import com.kh.know_how.admin.model.dto.StudentDetailDto;
import com.kh.know_how.admin.model.dto.StudentListDto;
import com.kh.know_how.admin.model.dto.StudentPendingListDto;
import com.kh.know_how.admin.model.dto.StudentSearchListDto;
import com.kh.know_how.admin.model.dto.StudentSearchRequestDto;
import com.kh.know_how.admin.model.dto.StudentStatusDto;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.member.model.vo.MemberLock;

@Repository
public class AdminDao2 {

	public int selectStudentListCount(SqlSessionTemplate sqlSession) { // 재학, 휴학중인 학원생의 수를 불러오는 메소드
		
		return sqlSession.selectOne("adminMapper2.selectStudentListCount");
	}

	public ArrayList<StudentListDto> selectStudentList(SqlSessionTemplate sqlSession, PageInfo pi) { // 재학, 휴학중인 학원생 리스트를 불러오는 메소드
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectStudentList", null, rowBounds);
	}

	public int searchStudentCount(SqlSessionTemplate sqlSession, StudentSearchRequestDto studentSearchRequest) { // 학원생 검색 시 학원생의 수를 불러오는 메소드
		
		return sqlSession.selectOne("adminMapper2.searchStudentCount", studentSearchRequest);
	}

	public ArrayList<StudentSearchListDto> searchStudentList(SqlSessionTemplate sqlSession, StudentSearchRequestDto studentSearchRequest, PageInfo pi) { // 학원생 검색 시 학원생 리스트를 불러오는 메소드
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("adminMapper2.searchStudentList", studentSearchRequest, rowBounds);
	}

	public StudentDetailDto selectStudent(SqlSessionTemplate sqlSession, int studentNo) { // 학원생 정보를 불러오는 메소드
		
		return sqlSession.selectOne("adminMapper2.selectStudent", studentNo);
	}

	public int insertStudentMemo(SqlSessionTemplate sqlSession, MemoInsertDto memoInsert) { // 학원생의 메모를 추가하는 메소드
		
		return sqlSession.insert("adminMapper2.insertStudentMemo", memoInsert);
	}

	public ArrayList<MemoListDto> selectStudentMemoList(SqlSessionTemplate sqlSession, int userNo) { // 학원생의 메모 리스트를 불러오는 메소드
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectStudentMemoList", userNo);
	}

	public int deleteStudentMemo(SqlSessionTemplate sqlSession, int memoNo) { // 학원생의 메모를 지우는 메소드
		
		return sqlSession.delete("adminMapper2.deleteStudentMemo", memoNo);
	}

	public int updateStudentStatus(SqlSessionTemplate sqlSession, StudentStatusDto studentStatus) { // 학원생의 재학/휴학 처리 해주는 메소드
		
		return sqlSession.update("adminMapper2.updateStudentStatus", studentStatus);
	}
	
	public int updateStudentMemberStatus(SqlSessionTemplate sqlSession, StudentStatusDto studentStatus) {// 학원생의 재학/휴학 처리 할 때 Member 테이블도 수정하는 메소드
		
		return sqlSession.update("adminMapper2.updateStudentMemberStatus", studentStatus);
	}

	public ArrayList<StudentPendingListDto> selectPendingStudentList(SqlSessionTemplate sqlSession) { // 학원생의 가입 대기 리스트를 불러오는 메소드
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectPendingStudentList");
	}

	public int updateStudentApprove(SqlSessionTemplate sqlSession, StudentApproveDto studentApprove) { // 학원생의 가입을 승인하는 메소드
		
		return sqlSession.update("adminMapper2.updateStudentApprove", studentApprove);
	}

	public int insertStudent(SqlSessionTemplate sqlSession, StudentApproveDto studentApprove) { // 학원생의 가입 승인 시 학생의 데이터를 추가하는 메소드
		
		return sqlSession.insert("adminMapper2.insertStudent", studentApprove);
	}

	public int updateStudentReject(SqlSessionTemplate sqlSession, int userNo) { // 학원생의 가입을 거절하는 메소드
		
		return sqlSession.update("adminMapper2.updateStudentReject", userNo);
	}
	
	public int deleteStudent(SqlSessionTemplate sqlSession, int userNo) { // 학원생의 가입을 삭제하는 메소드
		
		return sqlSession.delete("adminMapper2.deleteStudent", userNo);
	}
	
	
	public int adminSelectBoardCount(SqlSessionTemplate sqlSession, String postType) { // 공지사항, 학원소식의 리스트의 개수를 불러오는 메소드
		
		return sqlSession.selectOne("boardMapper.adminSelectBoardCount", postType);
	}
	
	public ArrayList<Board> adminSelectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, String postType) { // 공지사항, 학원소식의 리스트를 불러오는 메소드
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSelectBoardList", postType, rowBounds);
	}

	public int adminSearchBoardCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) { // 공지사항, 학원소식 검색 시 리스트의 개수를 불러오는 메소드
		
		return sqlSession.selectOne("boardMapper.adminSearchBoardCount", map);
	}

	public ArrayList<Board> adminSearchBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) { // 공지사항, 학원소식 검색 시 리스트를 불러오는 메소드 
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSearchBoardList", map, rowBounds);
	}

	public int adminDeleteBoard(SqlSessionTemplate sqlSession, int postNo) { // 공지사항, 학원소식 삭제해주는 메소드
		
		return sqlSession.delete("adminMapper2.adminDeleteBoard", postNo);
	}
	
	public int adminDeleteFileAttachment(SqlSessionTemplate sqlSession, int postNo) { // 공지사항, 학원소식 삭제 시 파일 정보도 같이 삭제해주는 메소드
		
		return sqlSession.delete("adminMapper2.adminDeleteFileAttachment", postNo);
	}
	
	public int adminUpdateBoardStatus(SqlSessionTemplate sqlSession, Board n) { // 공지사항, 학원소식 노출/숨김 처리 해주는 메소드
		
		return sqlSession.update("adminMapper2.adminUpdateBoardStatus", n);
	}

	public Board adminSelectBoard(SqlSessionTemplate sqlSession, int postNo) { // 관리자 페이지에서 공지사항, 학원소식을 상세조회 할 수 있는 메소드
		
		return sqlSession.selectOne("boardMapper.adminSelectBoard", postNo);
	}
	
	public int insertAttachmentList(SqlSessionTemplate sqlSession, ArrayList<FileAttachment> list) { // 학원소식 추가 시 이미지를 추가할 때 쓰는 메소드
		
		int result = 1;
		
		for(FileAttachment fa : list) {
			result *= sqlSession.insert("adminMapper2.insertFileAttachmentList", fa);
		}
		
		return result;
	}

	public int updateFileAttachment(SqlSessionTemplate sqlSession, FileAttachment at) { // 학원소식 수정 시 이미지를 교체할 때 쓰는 메소드

		return sqlSession.update("adminMapper2.updateFileAttachment", at);
	}
	
	public int insertNewsFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) { // 학원소식 수정 시 이미지를 추가할 때 쓰는 메소드
		
		return sqlSession.insert("adminMapper2.insertNewsFileAttachment", fa);
	}

	public ArrayList<MemberLock> selectLockingMemberList(SqlSessionTemplate sqlSession) { // 계정이 잠긴 유저 리스트를 불러오는 메소드
		
		return (ArrayList)sqlSession.selectList("memberMapper.selectLockingMemberList");
	}

	public int updateMemberUnlock(SqlSessionTemplate sqlSession, int userNo) { // 계정을 잠금해제할 수 있는 메소드
		
		return sqlSession.update("adminMapper2.updateMemberUnlock", userNo);
	}

} // 클래스 끝

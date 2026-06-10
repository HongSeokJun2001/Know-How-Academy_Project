package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.model.dto.MemoDto;
import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
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

	public int insertStudentMemo(SqlSessionTemplate sqlSession, MemoDto m) {
		
		return sqlSession.insert("adminMapper2.insertStudentMemo", m);
	}

	public ArrayList<MemoDto> selectStudentMemoList(SqlSessionTemplate sqlSession, int userNo) {
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectStudentMemoList", userNo);
	}

	public int deleteStudentNo(SqlSessionTemplate sqlSession, int memoNo) {
		
		return sqlSession.delete("adminMapper2.deleteStudentMemo", memoNo);
	}

	public int updateStudentStatus(SqlSessionTemplate sqlSession, StudentDto s) {
		
		return sqlSession.update("adminMapper2.updateStudentStatus", s);
	}

	public ArrayList<StudentDto> selectPendingStudentList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper2.selectPendingStudentList");
	}

	public int updateStudentApprove(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		
		return sqlSession.update("adminMapper2.updateStudentApprove", map);
	}

	public int insertStudent(SqlSessionTemplate sqlSession, HashMap<String, Integer> map) {
		
		return sqlSession.insert("adminMapper2.insertStudent", map);
	}

	public int updateStudentReject(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.update("adminMapper2.updateStudentReject", userNo);
	}
	
	public int adminSelectBoardCount(SqlSessionTemplate sqlSession, String postType) {
		
		return sqlSession.selectOne("boardMapper.adminSelectBoardCount", postType);
	}
	
	public ArrayList<Board> adminSelectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, String postType) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSelectBoardList", postType, rowBounds);
	}

	public int adminSearchBoardCount(SqlSessionTemplate sqlSession, HashMap<String, String> map) {
		
		return sqlSession.selectOne("boardMapper.adminSearchBoardCount", map);
	}

	public ArrayList<Board> adminSearchBoardList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, String> map) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSearchBoardList", map, rowBounds);
	}

	public int adminDeleteBoard(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.delete("boardMapper.adminDeleteBoard", postNo);
	}
	
	public int adminDeleteFileAttachment(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.delete("boardMapper.adminDeleteFileAttachment", postNo);
	}
	
	public int adminUpdateBoardStatus(SqlSessionTemplate sqlSession, Board n) {
		
		return sqlSession.update("boardMapper.adminUpdateBoardStatus", n);
	}

	public int insertAttachmentList(SqlSessionTemplate sqlSession, ArrayList<FileAttachment> list) {
		
		int result = 1;
		
		for(FileAttachment fa : list) {
			result *= sqlSession.insert("boardMapper.insertFileAttachmentList", fa);
		}
		
		return result;
	}

	public int insertNewsFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {
		
		return sqlSession.insert("boardMapper.insertNewsFileAttachment", fa);
	}

	public int deleteNewsFileAttachment(SqlSessionTemplate sqlSession, int fileNo) {
		
		return sqlSession.delete("boardMapper.deleteNewsFileAttachment", fileNo);
	}

}
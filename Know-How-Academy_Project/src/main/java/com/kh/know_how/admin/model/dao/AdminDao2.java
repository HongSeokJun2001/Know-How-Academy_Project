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
	
	public int adminSelectNoticeCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("boardMapper.adminSelectNoticeCount");
	}
	
	public ArrayList<Board> adminSelectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSelectNoticeList", null, rowBounds);
	}

	public int adminSearchNoticeCount(SqlSessionTemplate sqlSession, String keyword) {
		
		return sqlSession.selectOne("boardMapper.adminSearchNoticeCount", keyword);
	}

	public ArrayList<Board> adminSearchNoticeList(SqlSessionTemplate sqlSession, PageInfo pi, String keyword) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSearchNoticeList", keyword, rowBounds);
	}

	public int adminUpdateStatus(SqlSessionTemplate sqlSession, Board n) {
		
		return sqlSession.update("boardMapper.adminUpdateStatus", n);
	}

	public int adminSelectNewsCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("boardMapper.adminSelectNewsCount");
	}

	public ArrayList<Board> adminSelectNewsList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSelectNewsList", null, rowBounds);
	}

	public int adminSearchNewsCount(SqlSessionTemplate sqlSession, String keyword) {
		
		return sqlSession.selectOne("boardMapper.adminSearchNewsCount", keyword);
	}

	public ArrayList<Board> adminSearchNewsList(SqlSessionTemplate sqlSession, PageInfo pi, String keyword) {
		
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.adminSearchNewsList", keyword, rowBounds);
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

}//클래스 끝

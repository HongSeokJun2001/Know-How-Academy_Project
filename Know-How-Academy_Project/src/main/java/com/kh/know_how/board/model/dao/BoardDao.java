package com.kh.know_how.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;

@Repository
public class BoardDao {
	public ArrayList<Board> mainPageNoticeList(SqlSessionTemplate sqlSessison) { // 메인페이지에 나오는 공지사항 리스트를 불러오는 메소드
		
		return (ArrayList)sqlSessison.selectList("boardMapper.mainPageNoticeList");
	}

	public int selectNewsListCount(SqlSessionTemplate sqlSession) { // 학원소식의 갯수를 불러오는 리스트

		return sqlSession.selectOne("boardMapper.selectNewsListCount");
	}

	public ArrayList<Board> selectNewsList(SqlSessionTemplate sqlSession, PageInfo pi) { // 메인페이지에 나오는 학원소식 리스트를 불러오는 메소드
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectNewsList", null, rowBounds);
	}

	public Board selectBoard(SqlSessionTemplate sqlSession, int postNo) { // 학원소식의 상세정보를 불러오는 메소드
		
		return sqlSession.selectOne("boardMapper.selectBoard", postNo);
	}
	
	public ArrayList<FileAttachment> selectFileAttachmentList(SqlSessionTemplate sqlSession, int postNo) {
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectFileAttachment", postNo);
	}

	public FileAttachment selectFileAttachment(SqlSessionTemplate sqlSession, int postNo) {
	
		return sqlSession.selectOne("boardMapper.selectFileAttachment", postNo);
	}
	
	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		
		return sqlSession.insert("boardMapper.insertBoard", b);
	}
	
	public int insertFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {
		
		return sqlSession.insert("boardMapper.insertFileAttachment", fa);
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	public int updateFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {
		
		return sqlSession.update("boardMapper.updateFileAttachment", fa);
	}

	public int insertNewFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {
		
		return sqlSession.insert("boardMapper.insertNewFileAttachment", fa);
	}

}

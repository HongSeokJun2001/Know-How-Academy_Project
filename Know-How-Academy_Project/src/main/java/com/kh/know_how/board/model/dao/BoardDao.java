package com.kh.know_how.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale.Category;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi, String postType) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("boardMapper.selectBoardList", postType, rowBounds);
	}

	public int selectListCount(SqlSessionTemplate sqlSession, String postType) {
		return sqlSession.selectOne("boardMapper.selectListCount");
	}

	public int selectSearchCount(HashMap<String, String> map, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectSearchCount", map);
	}


	public int insertBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int insertFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {

		return sqlSession.insert("boardMapper.insertFileAttachment", fa);
	}

	
	public ArrayList<Category> selectCategoryList(SqlSessionTemplate sqlSession){
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCategoryList");
	}
	
	public int updateBoard(SqlSessionTemplate sqlSession, Board b) {
		
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	public int updateFileAttachment(SqlSessionTemplate sqlSession,
									FileAttachment fa) {
		
		return sqlSession.update("boardMapper.updateFileAttachment", fa);
	}
	
	public int insertNewFileAttachment(SqlSessionTemplate sqlSession, FileAttachment fa) {
		
		return sqlSession.insert("boardMapper.insertNewFileAttachment",fa);
	}
	
	public int deleteBoard(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.update("boardMapper.deleteBoard", postNo);
	}
	
	//=========================================================================
	public ArrayList<Board> mainPageNoticeList(SqlSessionTemplate sqlSessison) {

		return null; //(ArrayList) sqlSessison.selectList("boardMapper.mainPageNoticeList");
	}

	public int selectNewsListCount(SqlSessionTemplate sqlSession) {

		return 0; //sqlSession.selectOne("boardMapper.selectNewsListCount");
	}

	public ArrayList<Board> selectNewsList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return null; //(ArrayList) sqlSession.selectList("boardMapper.selectNewsList", null, rowBounds);
	}

	public Board selectNews(SqlSessionTemplate sqlSession, int postNo) {
		
		return null; // sqlSession.selectOne("boardMapper.selectNews", postNo);
	}

	public ArrayList<FileAttachment> selectFileAttachmentList(SqlSessionTemplate sqlSession, int postNo) {

		return (ArrayList) sqlSession.selectList("boardMapper.selectFileAttachmentList", postNo);
	}

	public int admindeleteFileAttachment(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.delete("boardMapper.admindeleteFileAttachment", postNo);
	}

	public FileAttachment selectFileAttachment(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.selectOne("boardMapper.selectFileAttachment", postNo);
	}

	public Board selectBoardWithFile(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.selectOne("boardMapper.selectBoardWithFile", postNo);
	}

	public int increaseCount(SqlSessionTemplate sqlSession, int postNo) {
		
		return sqlSession.update("boardMapper.increaseCount", postNo);
	}
}

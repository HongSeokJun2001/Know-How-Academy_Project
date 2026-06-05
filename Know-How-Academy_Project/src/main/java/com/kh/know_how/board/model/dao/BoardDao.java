package com.kh.know_how.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.board.model.vo.FileAttachment;

@Repository
public class BoardDao {

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi) {

		int limit = pi.getBoardLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;

		RowBounds rowBounds = new RowBounds(offset, limit);

		return (ArrayList) sqlSession.selectList("boardMapper.selectBoardList", null, rowBounds);
	}

	public int selectListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectListCount");
	}

	public int selectSearchCount(HashMap<String, String> map, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectSearchCount", map);
	}

	public int increaseCount(int boardNo, SqlSessionTemplate sqlSession) {
		return sqlSession.update("boardMapper.increaseCount", boardNo);
	}

	public Board selectBoard(int boardNo, SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
	}

	public int insertBoard(Board b, SqlSessionTemplate sqlSession) {
		return sqlSession.insert("boardMapper.insertBoard", b);
	}

	public int insertFileAttachment(SqlSessionTemplate sqlSession, FileAttachment at) {

		return sqlSession.insert("boardMapper.insertFileAttachment", at);
	}
public FileAttachment selectAttachment(SqlSessionTemplate sqlSession, int boardNo) {
		
		return sqlSession.selectOne("boardMapper.selectAttachment", boardNo);
	}
}
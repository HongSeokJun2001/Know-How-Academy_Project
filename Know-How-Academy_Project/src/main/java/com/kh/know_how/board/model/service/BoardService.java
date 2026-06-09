package com.kh.know_how.board.model.service;

import java.util.ArrayList; // 필요에 따라 추가
import java.util.HashMap;
import java.util.Locale.Category;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo; // 페이징 처리용

@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private BoardDao boardDao;

	// 만약 sqlSession을 직접 넘기는 방식이 아니라면 아래 매개변수에서 sqlSession을 제거해야 합니다.
	// 보통 Dao에서 SqlSessionTemplate을 주입받아 사용하므로,
	// 아래와 같이 sqlSession 파라미터를 제거하고 호출하는 것이 일반적입니다.

	public int selectListCount() {
		return boardDao.selectListCount(sqlSession);
	}

	public ArrayList<Board> selectBoardList(PageInfo pi) {
		return boardDao.selectBoardList(sqlSession, pi);
	}

	public int selectSearchCount(HashMap<String, String> map) {
		return boardDao.selectSearchCount(map, sqlSession);
	}

	@Transactional
	public int increaseCount(int postNo) {
		return boardDao.increaseCount(postNo, sqlSession);
	}

	public Board selectBoard(int postNo) {
		return boardDao.selectBoard(postNo, sqlSession);
	}

	@Transactional
	public int insertBoard(Board b, FileAttachment at) {

		int result1 = boardDao.insertBoard(b, sqlSession);

		int result2 = 1;

		if (at != null) {

			result2 = boardDao.insertFileAttachment(sqlSession, at);
		}

		return result1 * result2;
	}

	public ArrayList<Category> selectCategoryList() {

		return boardDao.selectCategoryList(sqlSession);
	}

	public FileAttachment selectAttachment(int postNo) {

		return boardDao.selectAttachment(sqlSession, postNo);
	}

	public ArrayList<FileAttachment> selectFileAttachmentList(int postNo) {

		return boardDao.selectFileAttachmentList(sqlSession, postNo);
	}

	@Transactional
	public int updateBoard(Board b, FileAttachment at) {

		int result1 = boardDao.updateBoard(sqlSession, b);
		int result2 = 1;

		if (at != null) {

			if (at.getFileNo() != 0) {

				result2 = boardDao.updateFileAttachment(sqlSession, at);

			} else {

				result2 = boardDao.insertNewFileAttachment(sqlSession, at);
			}
		}

		return result1 * result2;
	}
	
	@Transactional
	public int deleteBoard(int postNo) {
		
		return boardDao.deleteBoard(sqlSession,postNo);
	}

//====================================================
	public ArrayList<Board> mainPageNoticeList() {

		return boardDao.mainPageNoticeList(sqlSession);
	}

	public int selectNewsListCount() {
		return boardDao.selectNewsListCount(sqlSession);
	}

	public ArrayList<Board> selectNewsList(PageInfo pi) {

		return boardDao.selectNewsList(sqlSession, pi);
	}

	public Board selectNews(int postNo) {

		return boardDao.selectNews(sqlSession, postNo);
	}

}

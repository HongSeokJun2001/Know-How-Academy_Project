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
import com.kh.know_how.board.model.vo.PostComment;
import com.kh.know_how.common.model.vo.PageInfo; // 페이징 처리용

@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Autowired
	private BoardDao boardDao;

	public int selectListCount(String postType) {
		return boardDao.selectListCount(sqlSession, postType);
	}

	public ArrayList<Board> selectBoardList(PageInfo pi, String postType) {
		return boardDao.selectBoardList(sqlSession, pi, postType);
	}

	public Board selectBoard(int postNo) {

		return boardDao.selectBoard(sqlSession, postNo);
	}

	public int selectSearchCount(HashMap<String, String> map) {
		return boardDao.selectSearchCount(map, sqlSession);
	}

	@Transactional
	public int insertBoard(Board b, FileAttachment fa) {

		// 1. 게시글 등록
		int result1 = boardDao.insertBoard(sqlSession, b);

		int result2 = 1;
		if (fa != null) {

			fa.setTargetNo(b.getPostNo());

			result2 = boardDao.insertFileAttachment(sqlSession, fa);
		}

		return result1 * result2;
	}

	public ArrayList<Category> selectCategoryList() {

		return boardDao.selectCategoryList(sqlSession);
	}

	public ArrayList<FileAttachment> selectFileAttachmentList(int postNo) {

		return boardDao.selectFileAttachmentList(sqlSession, postNo);
	}

	@Transactional
	public int updateBoard(Board b, FileAttachment fa) {

		int result1 = boardDao.updateBoard(sqlSession, b);
		int result2 = 1;

		if (fa != null) {

			if (fa.getFileNo() != 0) {

				result2 = boardDao.updateFileAttachment(sqlSession, fa);

			} else {

				result2 = boardDao.insertNewFileAttachment(sqlSession, fa);
			}
		}

		return result1 * result2;
	}

	@Transactional
	public int deleteBoard(int postNo) {

		return boardDao.deleteBoard(sqlSession, postNo);
	}

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

	@Transactional
	public int admindeleteFileAttachment(int postNo) {
		return boardDao.admindeleteFileAttachment(sqlSession, postNo);

	}

	public FileAttachment selectFileAttachment(int postNo) {

		return boardDao.selectFileAttachment(sqlSession, postNo);
	}

	public int increaseCount(int postNo) {

		return boardDao.increaseCount(sqlSession, postNo);
	}

	public ArrayList<PostComment> selectCommentList(int postNo) {
				
		return boardDao.selectCommentList(sqlSession, postNo);
	}

}

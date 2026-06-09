package com.kh.know_how.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;

@Service
public class BoardService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private BoardDao boardDao;
	
	public ArrayList<Board> mainPageNoticeList() {
		
		return boardDao.mainPageNoticeList(sqlSession);
	}

	public int selectNewsListCount() {
		return boardDao.selectNewsListCount(sqlSession);
	}

	public ArrayList<Board> selectNewsList(PageInfo pi) {
		
		return boardDao.selectNewsList(sqlSession, pi);
	}

	public Board selectBoard(int postNo) {
		
		return boardDao.selectBoard(sqlSession, postNo);
	}

	public ArrayList<FileAttachment> selectFileAttachmentList(int postNo) {
		
		return boardDao.selectFileAttachmentList(sqlSession, postNo);
	}

	public FileAttachment selectFileAttachment(int postNo) {
		
		return boardDao.selectFileAttachment(sqlSession, postNo);
	}
	
	@Transactional
	public int deleteBoard(int postNo) {
		
		return boardDao.deleteBoard(sqlSession, postNo);
	}

	@Transactional
	public int deleteFileAttachment(int postNo) {
		return boardDao.deleteFileAttachment(sqlSession, postNo);
		
	}
	
	@Transactional
	public int updateBoard(Board b, FileAttachment fa) {
		
		int result1 = boardDao.updateBoard(sqlSession, b);
		
		int result2 = 1;
		
		if(fa != null) {
			
			if(fa.getFileNo() != 0) {
				
				result2 = boardDao.updateFileAttachment(sqlSession, fa);
			
			} else {
				
				result2 = boardDao.insertNewFileAttachment(sqlSession, fa);
			}
			
		}
		
		return result1 * result2;
	}

	@Transactional
	public int insertBoard(Board b, FileAttachment fa) {
		
		int result1 = boardDao.insertBoard(sqlSession, b);
		
		int result2 = 1;
		
		if(fa != null) {
			
			result2 = boardDao.insertFileAttachment(sqlSession, fa);
			
		}
		
		return result1 * result2;
	}

}

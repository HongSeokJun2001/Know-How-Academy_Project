package com.kh.know_how.board.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.admin.model.dto.StudentDto;
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

	public Board selectNews(int postNo) {
		
		return boardDao.selectNews(sqlSession, postNo);
	}

	public ArrayList<FileAttachment> selectFileAttachmentList(int postNo) {
		
		return boardDao.selectFileAttachmentList(sqlSession, postNo);
	}

}

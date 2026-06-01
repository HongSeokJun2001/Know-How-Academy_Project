package com.kh.know_how.board.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo;

@Service
public class BoardService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private BoardDao boardDao;
	//Spring에게 sql과 dao 객체관리
	
	/**
	 * 일반 게시글 목록 조회 
	 * @param pi 페이징 처리
	 * @return ArrayList반환
	 */
	public ArrayList<Board> selectBoardList(PageInfo pi){
						
		//sql은 상단에서 작성햇으니 바로 리턴작성
		//dao로 보내줄 sql과 pi 발사
		return boardDao.selectBoardList(sqlSession, pi);
	}
	/**
	 * 게시글 전체 갯수
	 * @return
	 */
	public int selectListCount() {
		
		return boardDao.selectListCount(sqlSession);
	}
	/**
	 * 검색된 게시글 총 갯수
	 * @param map
	 * @return
	 */
	public int selectSearchCount(HashMap<String, String> map) {
		
		return boardDao.selectSearchCount(sqlSession, map);
	}
}

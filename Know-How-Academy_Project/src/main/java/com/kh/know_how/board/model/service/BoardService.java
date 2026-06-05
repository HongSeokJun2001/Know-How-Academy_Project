package com.kh.know_how.board.model.service;

import java.util.HashMap;
import java.util.ArrayList; // 필요에 따라 추가

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.board.model.dao.BoardDao;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo; // 페이징 처리용

@Service
public class BoardService {

    @Autowired
    private BoardDao boardDao;

    // 만약 sqlSession을 직접 넘기는 방식이 아니라면 아래 매개변수에서 sqlSession을 제거해야 합니다.
    // 보통 Dao에서 SqlSessionTemplate을 주입받아 사용하므로, 
    // 아래와 같이 sqlSession 파라미터를 제거하고 호출하는 것이 일반적입니다.

    public int selectListCount() {
        return boardDao.selectListCount();
    }

    public ArrayList<Board> selectBoardList(PageInfo pi) {
        return boardDao.selectBoardList(pi);
    }

    public int selectSearchCount(HashMap<String, String> map) {
        return boardDao.selectSearchCount(map);
    }

    @Transactional
    public int increaseCount(int boardNo) {
        return boardDao.increaseCount(boardNo);
    }

    public Board selectBoard(int boardNo) {
        return boardDao.selectBoard(boardNo);
    }
    
    public int inserBoard(Board b) {
        return boardDao.inserBoard(b);
    }
}
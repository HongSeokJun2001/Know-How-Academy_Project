package com.kh.know_how.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo;

@Repository
public class BoardDao {
    
    // SqlSessionTemplate을 멤버 변수로 선언하고 자동 주입받습니다.
    @Autowired
    private SqlSessionTemplate sqlSession;

    public ArrayList<Board> selectBoardList(PageInfo pi) {
        int limit = pi.getBoardLimit();
        int offset = (pi.getCurrentPage() - 1) * limit;
        
        RowBounds rowBounds = new RowBounds(offset, limit);
        
        return (ArrayList) sqlSession.selectList("boardMapper.selectBoardList", null, rowBounds);
    }

    public int selectListCount() {
        return sqlSession.selectOne("boardMapper.selectListCount");
    }

    public int selectSearchCount(HashMap<String, String> map) {
        return sqlSession.selectOne("boardMapper.selectSearchCount", map);
    }

    public int increaseCount(int boardNo) {
        return sqlSession.update("boardMapper.increaseCount", boardNo);
    }

    public Board selectBoard(int boardNo) {
        return sqlSession.selectOne("boardMapper.selectBoard", boardNo);
    }
    
    public int inserBoard(Board b) {
        return sqlSession.insert("boardMapper.insertBoard", b);
    }
}
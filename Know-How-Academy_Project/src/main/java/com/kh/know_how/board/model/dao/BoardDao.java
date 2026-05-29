package com.kh.know_how.board.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;

@Repository
public class BoardDao {
	public ArrayList<Board> mainPageNoticeList(SqlSessionTemplate sqlSessison) {
		
		return (ArrayList)sqlSessison.selectList("boardMapper.mainPageNoticeList");
	}
}

package com.kh.know_how.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo;

@Repository
public class BoardDao {

	public ArrayList<Board> selectBoardList(SqlSessionTemplate sqlSession, PageInfo pi){
		
		//페이징처리 준비
		int limit = pi.getBoardLimit();
		//boardLimit에 pi 정보를 입힌후 limit로 재가공하여
		
		int offset = (pi.getCurrentPage()-1) * limit;
		//현재 페이지에 알맞은 게시글 목록을 보이기위해 
		//((요청페이지=3)-1) * 한페이지에 게시글 노출수
		//2*10 = 20 개의 게시글목록을 건너뛴다
		//이후 3번 페이징바에 노출되는 게시글은 앞선 게시글20개를 제외한 21번게시글부터 30번게시글까지 출력
		
		RowBounds rowBounds = new RowBounds(offset,  limit);
		//다른 방식으 코드작성은 길고 복잡해지기에 
		//RowBounds를 사용해야 코드가 간결
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectBoardList",null,rowBounds);
		//복습
		//sqlSession == db와의 통로
		//selectList == sql이 제공하는 메서드 중하나 조회결과 1개 가 아닌 다수 일때 사용
		//...select(mapper.xml파일 내 selectBoardList의 ID를 가지고 있는 쿼리문 실행,
				//	파라매터값,
				//	페이징 정보 == 몇번 페이지 요청시 해당 페이지에만 들어오는 게시글의 정보가 담긴 RowBounds)
		//(ArrayList) == sql의 selectList메서드를 메서드에서 정해진 반환타입에 변환해준다.		
	}
	
	public int selectListCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("boardMapper.selectListCount");
	}
}

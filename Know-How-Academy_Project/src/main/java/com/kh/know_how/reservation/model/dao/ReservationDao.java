package com.kh.know_how.reservation.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.reservation.model.vo.CounselCategory;
import com.kh.know_how.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {
	public int selectListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("reservationMapper.selectListCount", userNo);
	}
	/*
	public ArrayList<Reservation> selectReservationList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservationList", pi, rowBounds);
	}
	
	public ArrayList<CounselCategory> selectCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCategoryList");
	}
    */
}

package com.kh.know_how.reservation.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {
	public ArrayList<Reservation> selectReservationList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservationList");
	}

}

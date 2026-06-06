package com.kh.know_how.reservation.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.reservation.model.dao.ReservationDao;
import com.kh.know_how.reservation.model.vo.CounselCategory;
import com.kh.know_how.reservation.model.vo.Reservation;

@Service
public class ReservationService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private ReservationDao reservationDao;

    public int selectListCount(int userNo) {

        return reservationDao.selectListCount(sqlSession, userNo);

    }
    
    public ArrayList<Reservation> selectReservationList(ReservationPageInfo pi) {
    	return reservationDao.selectReservationList(sqlSession, pi);
    }
    
    public ArrayList<CounselCategory> selectCategoryList() {
    	return reservationDao.selectCategoryList(sqlSession);
    }
}
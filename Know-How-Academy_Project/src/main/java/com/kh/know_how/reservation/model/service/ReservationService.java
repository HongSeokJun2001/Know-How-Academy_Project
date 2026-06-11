package com.kh.know_how.reservation.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.reservation.model.dao.ReservationDao;
import com.kh.know_how.reservation.model.vo.CounselCategory;
import com.kh.know_how.reservation.model.vo.CounselLog;
import com.kh.know_how.reservation.model.vo.Reservation;

@Service
public class ReservationService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private ReservationDao reservationDao;

    /**
     * [학생] 학생 본인의 상담 신청 내역 총 개수 조회
     * @param userNo userNo 로그인한 회원번호
     * @return 신청 내역 총 개수
     */
    public int selectListCount(int userNo) {

        return reservationDao.selectListCount(sqlSession, userNo);

    }
    
    /**
     * [학생] 학생 본인의 상담 신청 내역 목록 조회 (페이징 적용)
     * @param pi 페이징 및 회원번호 정보를 담은 객체
     * @return 상담 신청 내역 리스트
     */
    public ArrayList<Reservation> selectReservationList(ReservationPageInfo pi) {
    	return reservationDao.selectReservationList(sqlSession, pi);
    }
    
    /**
     * [학생] 상담사 라인업 전체 세부 정보 목록 조회
     * @return 활성화된 상담사 상세 리스트
     */
    public ArrayList<Reservation> selectCounselorDetailList() {
    	return reservationDao.selectCounselorDetailList(sqlSession);
    }
    
    /**
     * [학생] 상담 신청을 위한 특정 상담사 1명 상세 정보 조회
     * @param counselNo 선택한 상담사의 고유 번호
     * @return 상담사 정보 객체
     */
    public Reservation selectOneCounselor(int counselNo) {
    	return reservationDao.selectOneCounselor(sqlSession, counselNo);
    }
    
    /**
     * [학생] 상담 카테고리 목록 조회
     * @return 상담 카테고리 리스트
     */
    public ArrayList<CounselCategory> selectCategoryList() {
    	return reservationDao.selectCategoryList(sqlSession);
    }
    
    /**
     * [학생] 간단 상담사 기본 리스트 조회
     * @return 상담사 목록
     */
    public ArrayList<Reservation> selectCounselorList() {
    	return reservationDao.selectCounselorList(sqlSession);
    }
    /**
     * [학생] 상담 신청서 등록 (INSERT)
     * @param r 등록할 상담 신청 정보
     * @return 성공 시 1, 실패시 0
     */
    @Transactional
    public int insertReservation(Reservation r) {
		return reservationDao.insertReservation(sqlSession, r);
	}
    
    /**
     * [공통] 상담 예약/신청 상세 정보 조회
     * @param rno 상담 예약 번호
     * @return 상담 상세 정보 객체
     */
    public Reservation selectReservationDetail(int rno) {
    	return reservationDao.selectReservationDetail(sqlSession, rno);
    }
    
    /**
     * [학생] 상담 예약 취소 (DELETE)
     * @param reservationNo 취소항 상담 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int deleteReservation(int reservationNo) {
    	return reservationDao.deleteReservation(sqlSession, reservationNo);
    }
    
    /**
     * [학생] 상담 신청서 내역 수정 (UPDATE)
     * @param r 수정할 상담 내용 객체
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int updateReservation(Reservation r) {
    	return reservationDao.updateReservation(sqlSession, r);
    }
    
    /**
     * [상담사] 특정 상담사에게 들어온 상담 예약/접수 총 개수 조회
     * @param userNo 상담사의 회원번호
     * @return 배정된 상담 건수
     */
    public int selectCounselorListCount(int userNo) {
    	return reservationDao.selectCounselorListCount(sqlSession, userNo);
    }
    
    /**
     * [상담사] 특정 상담사에게 들어온 상담 예약 접수 목록 조회 (패이징 적용)
     * @param pi 페이징 및 상담사 회원번호 정보를 담은 객체
     * @return 상담 접수 리스트
     */
    public ArrayList<Reservation> selectCounselorReservationList(ReservationPageInfo pi) {
    	return reservationDao.selectCounselorReservationList(sqlSession, pi);
    }
    
    /**
     * [상담사] 상담 신청 승인 처리 ('APPLIED' -> 'RESERVED')
     * @param reservationNo 승인할 상담 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int approveReservation(int reservationNo) {
    	return reservationDao.approveReservation(sqlSession, reservationNo);
    }
    
    /**
     * [상담사] 상담 신청 반려/거절 처리 ('APPLIED' -> 'REJECTED')
     * @param reservationNo 반려할 상담 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int rejectReservation(int reservationNo) {
    	return reservationDao.rejectReservation(sqlSession, reservationNo);
    }
    
    /**
     * [상담사] 상담 진행 완료 처리 ('RESERVED' -> 'COMPLETED')
     * @param reservationNo 완료할 상담 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int completeReservation(int reservationNo) {
    	return reservationDao.completeReservation(sqlSession, reservationNo);
    }
    
    /**
     * [공통] 특정 상담 예약에 등록된 상담일자 조회
     * @param reservationNo 상담 예약 번호
     * @return 상담일지 데이터 객체
     */
    public CounselLog selectCounselorLog(int reservationNo) {
    	return reservationDao.selectCounselorLog(sqlSession, reservationNo);
    }
    
    /**
     * [상담사] 상담일지 신규 등록 (INSERT)
     * @param log 등록할 상담일지 객체
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int insertCounselorLog(CounselLog log) {
    	return reservationDao.insertCounselorLog(sqlSession, log);
    }
    
    /**
     * [상담사] 상담일지 내용 수정 (UPDATE)
     * @param log 수정할 상담일지 객체
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int updateCounselorLog(CounselLog log) {
    	return reservationDao.updateCounselorLog(sqlSession, log);
    }
    
    /**
     * [상담사] 상담일지 삭제 (DELETE)
     * @param reservationNo 삭제할 상담일지의 예약 번호
     * @return 성공 시 1, 실패 시 0
     */
    @Transactional
    public int deleteCounselorLog(int reservationNo) {
    	return reservationDao.deleteCounselorLog(sqlSession, reservationNo);
    }
    
    /**
     * [상담사] 상담사가 진행 완료한 상담 목록 총 개수 조회
     * @param userNo 상담사 회원번호
     * @return 완료한 상담 총 개수
     */
    public int selectCounselorCompletedListCount(int userNo) {
    	return reservationDao.selectCounselorCompletedListCount(sqlSession, userNo);
    }
    
    /**
     * [상담사] 상담사가 진행 와뇰한 상담 목록 조회 (페이징 적용)
     * @param pi 페이징 및 상담사 회원번호를 담은 객체
     * @return 완료된 상담 리스트
     */
    public ArrayList<Reservation> selectCounselorCompletedList(ReservationPageInfo pi) {
    	return reservationDao.selectCounselorCompletedList(sqlSession, pi);
    }
    
    /**
     * [학생] 학생이 진행 완료한 상담 목록 총 개수 조회
     * @param userNo 학생 회원 번호
     * @return 완료된 상담 총 개수
     */
    public int selectStudentCompletedListCount(int userNo) {
    	return reservationDao.selectStudentCompletedListCount(sqlSession, userNo);
    }
    
    /**
     * [학생] 학생이 진행 완료한 상담 목록 조회 (페이징 적용)
     * @param pi 페이징 및 학생 회원번호를 담은 객체
     * @return 완료된 상담 리스트
     */
    public ArrayList<Reservation> selectStudentCompletedList(ReservationPageInfo pi) {
    	return reservationDao.selectStudentCompletedList(sqlSession, pi);
    }
    
    /**
     * [강사] 담당 반 학생들의 상담 예약 총 개수 조회
     * @param classNo 강사의 담당 반 고유 번호
     * @return 반 학생들의 상담 신청 총 건수
     */
    public int selectInstructorListCount(int classNo) {
    	return reservationDao.selectInstructorListCount(sqlSession, classNo);
    }
    
    /**
     * [강사] 담당 반 학생들의 상담 예약 목록 조회 (페이징 적용)
     * @param pi 페이징 및 반 번호 정보를 담은 객체
     * @return 반 학생들의 상담 접수 리스트
     */
    public ArrayList<Reservation> selectInstructorReservationList(ReservationPageInfo pi, int classNo) {
    	return reservationDao.selectInstructorReservationList(sqlSession, pi, classNo);
    }
    
    /**
     * [관리자] 전체 학생들의 상담 예약 총 개수 조회
     * @return 전체 상담 신청 총 건수
     */
    public int selectAdminListCount() {
    	return reservationDao.selectAdminListCount(sqlSession);
    }
    
    /**
     * [관리자] 전체 학생들의 상담 예약 목록 조회 (페이징 적용)
     * @param pi 페이징 정보를 담은 객체
     * @return 전체 상담 접수 리스트
     */
    public ArrayList<Reservation> selectAdminReservationList(ReservationPageInfo pi) {
    	return reservationDao.selectAdminReservationList(sqlSession, pi);
    }
    
    /**
     * [강사] 담당 반 학생들이 완료한 상담 목록 총 계수 조회
     * @param classNo 강사의 담당 반 고유 번호
     * @return 반 학생들이 상담 완료 총 건수
     */
    public int selectInstructorCompletedListCount(int classNo) {
    	return reservationDao.selectInstructorCompletedListCount(sqlSession, classNo);
    }
    
    /**
     * [강사] 담당 반 학생들이 완료한 상담 히스토리 목록 조회 (페이징 적용)
     * @param pi 페이징 및 반 번호 정보를 담은 객체
     * @return 반 학생들의 상담 완료 리스트
     */
    public ArrayList<Reservation> selectInstructorCompletedList(ReservationPageInfo pi, int classNo) {
    	return reservationDao.selectInstructorCompletedList(sqlSession, pi, classNo);
    }
    
    /**
     * [관리자] 시스템 전체의 상담 완료 목록 총 개수 조회
     * @return 전체 상담 완료 총 건수
     */
    public int selectAdminCompletedListCount() {
    	return reservationDao.selectAdminCompletedListCount(sqlSession);
    }
    /**
     * [관리자] 시스템 전체의 상담 완료 히스토리 목록 조회 (페이징 적용)
     * @param pi 페이징 정보를 담은 객체
     * @return 전체 상담 완료 리스트
     */
    public ArrayList<Reservation> selectAdminCompletedList(ReservationPageInfo pi) {
    	return reservationDao.selectAdminCompletedList(sqlSession, pi);
    }
}
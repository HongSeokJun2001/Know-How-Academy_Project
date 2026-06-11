package com.kh.know_how.reservation.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.reservation.model.vo.CounselCategory;
import com.kh.know_how.reservation.model.vo.CounselLog;
import com.kh.know_how.reservation.model.vo.Reservation;

@Repository
public class ReservationDao {
	/**
	 * [학생] 학생 본인의 상담 신청 내역 총 개수 조회
	 * @param sqlSession
	 * @param userNo 학생 회원번호
	 * @return
	 */
	public int selectListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("reservationMapper.selectListCount", userNo);
	}
	
	/**
	 * [학생] 학생 본인의 상담 신청 내역 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 회원번호를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectReservationList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectReservationList", pi, rowBounds);
	}
	
	/**
	 * [학생] 상담 카테고리 전체 목록 조회
	 * @param sqlSession
	 * @return
	 */
	public ArrayList<CounselCategory> selectCategoryList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCategoryList");
	}

	/**
	 * [학생] 간단 상담사 기본 리스트 조회
	 * @param sqlSession
	 * @return
	 */
	public ArrayList<Reservation> selectCounselorList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCounselorList");
	}
	
	/**
	 * [학생]신규 상담 신청서 데이터 삽입
	 * @param sqlSession
	 * @param r 등록할 상담 신청 정보 객체
	 * @return
	 */
	public int insertReservation(SqlSessionTemplate sqlSession, Reservation r) {
		return sqlSession.insert("reservationMapper.insertReservation", r);
	}

	/**
	 * [학생]활성화된 상담사 상세 프로필 정보 목록 조회
	 * @param sqlSession
	 * @return
	 */
	public ArrayList<Reservation> selectCounselorDetailList(SqlSessionTemplate sqlSession) {
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCounselorDetailList");
	}
	
	/**
	 * [학생] 신청 폼 조회를 위한 특정 상담사 정보 상세 조회
	 * @param sqlSession
	 * @param counselNo 상담사 고유 번호
	 * @return
	 */
	public Reservation selectOneCounselor(SqlSessionTemplate sqlSession, int counselNo) {
		return sqlSession.selectOne("reservationMapper.selectOneCounselor", counselNo);
	}
	
	/**
	 * [공통] 특정 상담 예약 신청서 내역 상세 조회
	 * @param sqlSession
	 * @param rno 상담 예약 번호
	 * @return
	 */
	public Reservation selectReservationDetail(SqlSessionTemplate sqlSession, int rno) {
		return sqlSession.selectOne("reservationMapper.selectReservationDetail", rno);
	}
	
	/**
	 * [학생] 상담 예약 취소 처리 (상태값 변경)
	 * @param sqlSession
	 * @param reservationNo 취소할 상담 예약 번호
	 * @return
	 */
	public int deleteReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.update("reservationMapper.deleteReservation", reservationNo);
	}
	/**
	 * [학생] 상담 신청서 내용 수정
	 * @param sqlSession
	 * @param r 수정할 상담 신청 정보 객체
	 * @return
	 */
	public int updateReservation(SqlSessionTemplate sqlSession, Reservation r) {
		return sqlSession.update("reservationMapper.updateReservation", r);
	}
	
	/**
	 * [상담사] 특정 상담사에게 접수된 상담 내역 총 개수 조회
	 * @param sqlSession
	 * @param userNo 상담사 회원 번호
	 * @return
	 */
	public int selectCounselorListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("reservationMapper.selectCounselorListCount", userNo);
	}
	
	/**
	 * [상담사] 툭종 상담사에게 접수된 상담 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 상담사 회원번호를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectCounselorReservationList(SqlSessionTemplate sqlSession, ReservationPageInfo pi)  {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCounselorReservationList", pi, rowBounds);
	}
	
	/**
	 * [상담사]접수된 상담 신청 예약 승인 처리
	 * @param sqlSession
	 * @param reservationNo 승인할 상담 예약 번호
	 * @return
	 */
	public int approveReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.update("reservationMapper.approveReservation", reservationNo);
	}
	

	/**
	 * [상담사]접수된 상담 신청 예약 반려/거절 처리
	 * @param sqlSession
	 * @param reservationNo
	 * @return
	 */
	public int rejectReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.update("reservationMapper.rejectReservation", reservationNo);
	}
	
	/**
	 * [상담사] 예약된 상담 진행 완료 처리
	 * @param sqlSession
	 * @param reservationNo 완료할 상담 예약 번호
	 * @return
	 */
	public int completeReservation(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.update("reservationMapper.completeReservation", reservationNo);
	}
	
	/**
	 * [공통] 특정 상담 예약에 속한 상담일지 조회
	 * @param sqlSession
	 * @param reservationNo 상담 예약 번호
	 * @return
	 */
	public CounselLog selectCounselorLog(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.selectOne("reservationMapper.selectCounselorLog", reservationNo);
	}
	
	/**
	 * [상담사] 신규 상담일지 데이터 삽입
	 * @param sqlSession
	 * @param log 등록할 상담일지 정보 객체
	 * @return
	 */
	public int insertCounselorLog(SqlSessionTemplate sqlSession, CounselLog log) {
		return sqlSession.insert("reservationMapper.insertCounselorLog", log);
	}
	
	/**
	 * [상담사] 기존 상담일지 내용 수정
	 * @param sqlSession
	 * @param log 수정할 상담일지 정보 객체
	 * @return
	 */
	public int updateCounselorLog(SqlSessionTemplate sqlSession, CounselLog log) {
		return sqlSession.update("reservationMapper.updateCounselorLog", log);
	}
	
	/**
	 * [상담사] 상담일지 데이터 삭제
	 * @param sqlSession
	 * @param reservationNo 삭제할 일자의 상담 예약 번호
	 * @return
	 */
	public int deleteCounselorLog(SqlSessionTemplate sqlSession, int reservationNo) {
		return sqlSession.update("reservationMapper.deleteCounselorLog", reservationNo);
	}
	
	/**
	 * [상담사] 상담사가 완료한 상담 목록 총 개수 조회
	 * @param sqlSession
	 * @param userNo 상담사 회원반호
	 * @return
	 */
	public int selectCounselorCompletedListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("reservationMapper.selectCounselorCompletedListCount", userNo);
	}
	
	/**
	 * [상담사] 상담사가 완료한 상담 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 상담사 회원번호를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectCounselorCompletedList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectCounselorCompletedList", pi, rowBounds);
	}
	
	/**
	 * [학생] 학생 본인이 완료한 상담 목록 총 개수 조회
	 * @param sqlSession
	 * @param userNo 학생 회원 번호
	 * @return
	 */
	public int selectStudentCompletedListCount(SqlSessionTemplate sqlSession, int userNo) {
		return sqlSession.selectOne("reservationMapper.selectStudentCompletedListCount", userNo);
	}
	
	/**
	 * [학생] 학생 본인이 완료한 상담 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 학생 회원번호를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectStudentCompletedList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectStudentCompletedList", pi, rowBounds);
	}
	

	/**
	 * [강사] 해당 강사의 담당 반 학생들의 상담 신청 총 개수 조회
	 * @param sqlSession
	 * @param classNo 강사의 담당 반 번호
	 * @return
	 */
	public int selectInstructorListCount(SqlSessionTemplate sqlSession, int classNo) {
		return sqlSession.selectOne("reservationMapper.selectInstructorListCount", classNo);
	}
	

	/**
	 * [강사] 해당 강사의 담당 반 학생들의 상담 신청 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 반 번호 정보를 포함한 객체
	 * @return
	 */
	public ArrayList<Reservation> selectInstructorReservationList(SqlSessionTemplate sqlSession, ReservationPageInfo pi, int classNo) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectInstructorReservationList", classNo, rowBounds);
	}
	

	/**
	 * [관리자] 전체 학생들의 상담 신청 총 개수 조회
	 * @param sqlSession
	 * @return
	 */
	public int selectAdminListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reservationMapper.selectAdminListCount");
	}
	

	/**
	 * [관리자] 전체 학생들의 상담 신청 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectAdminReservationList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectAdminReservationList", pi, rowBounds);
	}
	

	/**
	 * [강사] 해당 강사의 담당 반 학생들이 완료한 상담 록록 총 개수 조회
	 * @param sqlSession
	 * @param classNo 강사의 담당 반 번호
	 * @return
	 */
	public int selectInstructorCompletedListCount(SqlSessionTemplate sqlSession, int classNo) {
		return sqlSession.selectOne("reservationMapper.selectInstructorCompletedListCount", classNo);
	}
	
	
	/**
	 * [강사] 해당 강사의 담당 반 학생들이 완료한 상담 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보 및 반 번호 정보를 포함한 객체
	 * @return
	 */
	public ArrayList<Reservation> selectInstructorCompletedList(SqlSessionTemplate sqlSession, ReservationPageInfo pi, int classNo) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectInstructorCompletedList", classNo, rowBounds);
	}
	

	/**
	 * [관리자] 전체 학생들의 상담 완료 목록 총 개수 조회
	 * @param sqlSession
	 * @return
	 */
	public int selectAdminCompletedListCount(SqlSessionTemplate sqlSession) {
		return sqlSession.selectOne("reservationMapper.selectAdminCompletedListCount");
	}
	

	/**
	 * [관리자] 전체 학생들의 상담 완료 목록 조회 (페이징 처리)
	 * @param sqlSession
	 * @param pi 페이징 정보를 담은 객체
	 * @return
	 */
	public ArrayList<Reservation> selectAdminCompletedList(SqlSessionTemplate sqlSession, ReservationPageInfo pi) {
		int limit = pi.getReservationLimit();
		int offset = (pi.getCurrentPage() - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return (ArrayList)sqlSession.selectList("reservationMapper.selectAdminCompletedList", pi, rowBounds);
	}
	
}
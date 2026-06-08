package com.kh.know_how.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.common.AdminPagination;
import com.kh.know_how.admin.common.PageResponseDto;
import com.kh.know_how.admin.model.dao.AdminDao;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.ClassListDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorProfileDTO;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;

@Service
public class AdminService {
	
	//필드부
	@Autowired
	AdminDao ad;
	@Autowired
	SqlSessionTemplate sqlSession;
	
	//메소드부
	@Transactional(readOnly = true)
	public int selectAlarmCount() {
		
		return ad.selectAlarmCount(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public ArrayList<AdminCounselWaitingDto> selectWaitingList() {
		
		return ad.selectWaitingList(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public int selectCounselWaitingCount() {
		
		return ad.selectCounselWaitingCount(sqlSession);
	}

	@Transactional(readOnly = true)
	public ArrayList<TodayReservationDto> selectTodayReservationList() {
		
		return ad.selectTodayReservationList(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public int todayReservationCount() {
		
		return ad.todayReservationCount(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public ArrayList<AdminDashboardStatsDto> selectDashboardStats() {
	
		// double 타입, % 계산 CheckList : 
		// 1. 분모가 0일 경우 어떻게 처리합니까?  
		// 2. 분모와 분자를 제대로 지정했습니까? (헷갈릴 경우 따로 변수를 선언한 뒤 사용하세요)
		// 3. NULL이 존재할 가능성은 없습니까? 
		// 4. 반올림이 필요합니까?
		// 5. 계산 결과가 원하는 자료형으로 나왔습니까? (정수끼리 나눌경우 소수점이 나오지 않습니다)
		// 6. 계산 결과가 생각한 결과와 일치합니까?
		// 7. 0% 미만(음수)이거나 100% 이상의 초과 값이 나와도 정상입니까?
		
		// + 하드코딩 같으면 DB에서 가져온다
		
		return ad.selectDashboardStats(sqlSession);
	}

	@Transactional(readOnly = true)
	public CounselorListPageDto selectcounselorList(
			CounselorSearchRequestDto counselorSearchRequestDto) {
		
		//전체페이지조회
		int listCount = ad.selectlistCount(sqlSession,counselorSearchRequestDto);
		//페이징처리용 자료
		PageResponseDto pageInfo = AdminPagination.createPageInfo(counselorSearchRequestDto.getPageRequest(),listCount);
		//리스트 목록 조회
		ArrayList<CounselorListResponseDto> counselorList = ad.selectcounselorList(sqlSession,counselorSearchRequestDto);
		//클래스 목록 조회
		ArrayList<ClassListDto> classList = ad.selectClassList(sqlSession);
		
		
		CounselorListPageDto counselorListPage = new CounselorListPageDto(counselorList, pageInfo,classList);
		return counselorListPage;
	}
	
	@Transactional
	public int updateCounselorClass(int userNo, Integer classNo) {
		
		Map<String, Integer> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("classNo", classNo);
		
		return ad.updateCounselorClass(sqlSession, param);
	}

	@Transactional(readOnly = true)
	public ArrayList<CounselCategoryDto> selectCounselCategory() {
		
		return ad.selectCounselCategory(sqlSession);
	}
	
	@Transactional(readOnly = true)
	public CounselorProfileDTO selectCounselorProfile(int userNo) {
		
		
		return ad.selectCounselorProfile(sqlSession, userNo);
	}
	
	@Transactional
	public int updateCounselorStatus(int userNo, String status) {
		
		Map<String, Object> param = new HashMap<>();

		param.put("userNo", userNo);
		param.put("status", status);
		
		return ad.updateCounselorStatus(sqlSession, param);
	}
	
	@Transactional
	public int updateCounselorInvite(int inviteNo) {
		
		return ad.updateCounselorInvite(sqlSession, inviteNo);
	}

	




	
	
	
	
	
	
	
	
	
}//클래스 끝

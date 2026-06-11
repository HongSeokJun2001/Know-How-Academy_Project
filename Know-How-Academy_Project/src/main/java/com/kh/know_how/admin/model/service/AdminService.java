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
import com.kh.know_how.admin.mail.MailService;
import com.kh.know_how.admin.model.dao.AdminDao;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.ClassListDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorInviteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteListDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorProfileDTO;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.common.template.XssDefencePolicy;

@Service
public class AdminService {
	
	//필드부
	@Autowired
	AdminDao ad;
	@Autowired
	SqlSessionTemplate sqlSession;
	@Autowired
	private MailService mailService;
	
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
		
		//검색어 XSS
		String keyword = counselorSearchRequestDto.getKeyword();
		if(null != keyword && !keyword.isBlank()) {
			counselorSearchRequestDto.setKeyword(XssDefencePolicy.defence(keyword));
		}
		
		//전체페이지조회
		int listCount = ad.selectlistCount(sqlSession,counselorSearchRequestDto);
		//페이징처리용 자료
		PageResponseDto pageInfo = AdminPagination.createPageInfo(counselorSearchRequestDto.getPageRequest(),listCount);
		//리스트 목록 조회
		ArrayList<CounselorListResponseDto> counselorList = ad.selectcounselorList(sqlSession,counselorSearchRequestDto);
		//지정 상담사가 없는 클래스 목록 조회
		ArrayList<ClassListDto> classList = ad.selectClassList(sqlSession);
		
		
		CounselorListPageDto counselorListPage = new CounselorListPageDto(counselorList, pageInfo,classList);
		return counselorListPage;
	}
	
	@Transactional
	public int updateCounselorClass(int userNo, Integer classNo) {
		
		//1.상담사 클래스
		Map<String, Integer> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("classNo", classNo);
		int counselorClass = ad.updateCounselorClass(sqlSession, param);
		
		//2.학생테이블 상담사번호 변경
		//2-1 classNo NOT NULL - classNo가 같은 학생의 상담사번호 NULL로 UPDATE
		int clearNo = 1;
		if(classNo != null) {
			clearNo = ad.clearStudentCounselorNo(sqlSession, userNo);
		}
		
		//2-2 classNo가 같은 학생의 상담사번호 userNo로 UPDATE
		int updateStudent = ad.updateStudentCounselorNoByClassNo(sqlSession, param);
		
		
		//결과가 모두 참인지 확인 후 리턴
		return counselorClass * clearNo * updateStudent;
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
		// 상담사 상태 변경
		Map<String, Object> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("status", status);
		int changeStatus = ad.updateCounselorStatus(sqlSession, param);
		
		//상담사의 변경 전 class에 지정된 학생의 상담사번호를 NULL로 UPDATE
		int	clearNo = 1;
		if("ACTIVE".equals(status)) {
			clearNo = ad.clearStudentCounselorNo(sqlSession, userNo);
		} // 0행이어도 정상. 담당 학생이 없을 뿐.
          // SQL 에러면 예외 터지고 트랜잭션 롤백.
		
		
		return changeStatus;// 업무상 휴직 처리 성공
	}
	
	@Transactional
	public int updateCounselorInvite(int inviteNo) {
		
		return ad.updateCounselorInvite(sqlSession, inviteNo);
	}

	@Transactional
	public String inviteCounselor(CounselorInviteDto counselorInvite) {
		
		// 메일 형식검사, XSS 처리
		String keyword = counselorInvite.getEmail();
		
		String resultValidate = validateEmail(keyword);
		if("INVALID_EMAIL".equals(resultValidate)) {
			System.out.println(">>> INVALID_EMAIL");
			return resultValidate;
		}
		
		counselorInvite.setEmail(XssDefencePolicy.defence(keyword));
		
		
		//이메일중복검사
		int resultEmail = ad.existsByEmail(sqlSession, keyword);
		if(resultEmail > 0) {
			System.out.println(">>> DUPLICATE_EMAIL");
			return "DUPLICATE_EMAIL";
		}
		
		if(resultEmail == 0) {
			
			//토큰생성 + 초대DB저장
			counselorInvite.setInviteToken((int)(Math.random() * 900000 + 100000));
			int resultInfo = ad.insertCounselorInvite(sqlSession, counselorInvite);
			if(resultInfo == 0) {
				System.out.println(">>> INSERT_FAIL");
				return "INSERT_FAIL";
			}
			
			//메일발송
			String resultMail = mailService.sendCounselorInviteMail(counselorInvite);
			if ("MAIL_FAIL".equals(resultMail)) {
				
		        throw new RuntimeException("MAIL_FAIL");
		        //java.lang.RuntimeException: MAIL_FAIL
		    }
		}
		
		return "SUCCESS";
	}



	/** 이메일 형식 검사 메소드
	 * @param email
	 * @return
	 */
	public String validateEmail(String email) {
		
		if(email == null || email.isBlank()) {
			return "INVALID_EMAIL";
		}
		
		
        email = email.trim();
        
		if(!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
		    return "INVALID_EMAIL";
		}
		
		return "SUCCESS";
	}

	public ArrayList<CounselorInviteListDto> selectInviteList() {
		
		return ad.selectInviteList(sqlSession);
	} 
	




	
	
	
	
	
	
	
	
	
}//클래스 끝
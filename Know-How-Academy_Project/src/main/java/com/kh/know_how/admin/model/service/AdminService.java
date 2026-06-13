package com.kh.know_how.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.know_how.admin.common.AdminPagination;
import com.kh.know_how.admin.common.AdminXssDefencePolicy;
import com.kh.know_how.admin.common.PageResponseDto;
import com.kh.know_how.admin.model.dao.AdminDao;
import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.ClassListDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorInviteCompleteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteListDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorProfileDTO;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.counselor.model.vo.CounselorProfilImg;
import com.kh.know_how.counselor.model.vo.CounselorProfile;
import com.kh.know_how.member.model.vo.Member;

@Service
public class AdminService {
	
	//필드부
	@Autowired
	private AdminDao ad;
	@Autowired
	private SqlSessionTemplate sqlSession;
	@Autowired
	private MailService mailService;
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
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
		if((keyword != null) && !keyword.isBlank()) {
			counselorSearchRequestDto.setKeyword(AdminXssDefencePolicy.defence(keyword));
		}
		//전체페이지조회
		int listCount = ad.selectlistCount(sqlSession,counselorSearchRequestDto);
		//페이징처리용 자료
		PageResponseDto pageInfo = AdminPagination.createPageInfo(counselorSearchRequestDto.getPageRequest(),listCount);
		//리스트 목록 조회
		ArrayList<CounselorListResponseDto> counselorList = ad.selectcounselorList(sqlSession,counselorSearchRequestDto);
		//지정 상담사가 없는 클래스 목록 조회
		ArrayList<ClassListDto> classList = ad.selectClassList(sqlSession);
		//카테고리 목록 조회
		ArrayList<CounselCategoryDto> categoryList = ad.selectCounselCategory(sqlSession);
		
		CounselorListPageDto counselorListPage = new CounselorListPageDto(counselorList, pageInfo,classList, categoryList);
		return counselorListPage;
	}
	
	@Transactional
	public int updateCounselorClass(int userNo, String changeType, Integer changeNo) {
		
		Map<String, Integer> param = new HashMap<>();
		param.put("userNo", userNo);
		param.put("changeNo", changeNo);
		
		int result;
		
	    if ("CATEGORY".equals(changeType)) {

	    	result = ad.updateCounselorCategoryNo(sqlSession, param);

	    } else if ("CLASS".equals(changeType)) {
	    	
	    	Integer currClassNo = ad.selectUserClassNo(sqlSession, userNo);
	    	
	    	if(currClassNo == null) {
	    		ad.clearStudentCounselorNo(sqlSession, userNo);
	    	}
	        
	        result = ad.updateCounselorClass(sqlSession, param);

	        if (changeNo != null) {
	            ad.updateStudentCounselorNoByClassNo(sqlSession, param);
	        }

	    } else {
	    	
	        throw new IllegalArgumentException("유효하지 않은 요청입니다.");
	    }	
	    return result;
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
		if("ACTIVE".equals(status)) {
			ad.clearStudentCounselorNo(sqlSession, userNo);
		} // 담당 학생이 없으면 0
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
		
		counselorInvite.setCounselorName(AdminXssDefencePolicy.defence(counselorInvite.getCounselorName()));
		counselorInvite.setEmail(AdminXssDefencePolicy.defence(keyword));
		
		//이메일중복검사
		int resultEmail = ad.existsByEmail(sqlSession, keyword);
		if(resultEmail > 0) {
			System.out.println(">>> DUPLICATE_EMAIL");
			return "DUPLICATE_EMAIL";
		}
		
		if(resultEmail == 0) {
			
			//토큰생성 + 초대DB저장
			counselorInvite.setInviteToken(UUID.randomUUID().toString());
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
	
	@Transactional(readOnly = true)
	public ArrayList<CounselorInviteListDto> selectInviteList() {
		
		return ad.selectInviteList(sqlSession);
	}

	@Transactional(readOnly = true)
	public CounselorInviteCompleteDto getCounselorInfo(String token) {
		
		return ad.getCounselorInfo(sqlSession,token);
	}

	@Transactional
	public int signupCounselor(Member member, CounselorInviteCompleteDto inviteInfoDto, CounselorProfile profile, CounselorProfilImg cp) {
		
		//XSS 
		member.setUserId(AdminXssDefencePolicy.defence(member.getUserId()));
		if(member.getPhone() != null && !member.getPhone().isBlank()) {
			member.setPhone(AdminXssDefencePolicy.defence(member.getPhone()));
		}
		if(member.getAddress() != null && !member.getPhone().isBlank()) {
			member.setAddress(AdminXssDefencePolicy.defence(member.getAddress()));
		}
		if(profile.getBio() != null && !profile.getBio().isBlank()) {
			profile.setBio(AdminXssDefencePolicy.defence(profile.getBio()));
		}
		
		//암호화
		member.setUserPwd(bCryptPasswordEncoder.encode(member.getUserPwd()));
		
		//정보주입후 회원가입처리
		member.setUserName(inviteInfoDto.getInviteName());   
		member.setEmail(inviteInfoDto.getInviteEmail());  
		int memberResult = ad.insertCounselorMember(sqlSession, member);
		
		//생성된 useNo 주입 후 회원가입처리
		profile.setUserNo(member.getUserNo());
		inviteInfoDto.setUserNo(member.getUserNo());
		int profileResult = ad.insertCounselorProfile(sqlSession, profile);
		int inviteResult = ad.updateCounselorInviteInfo(sqlSession, inviteInfoDto);
		int imgResult = 1;
		
//		System.out.println(">>> [cp1] " + cp);
		
		if(cp != null) {
			cp.setUserNo(member.getUserNo());
//			System.out.println(">>> [cp2] " + cp);
			// 사용자의 화면에 노출 될 원본파일명만 xss 후 insert
			cp.setOriginName(AdminXssDefencePolicy.defence(cp.getOriginName()));
			imgResult = ad.insertCounselorProfileImg(sqlSession, cp);
		}
		
		if(imgResult == 0) {
			throw new RuntimeException("상담사 프로필 사진 정보 저장 실패");
		}
		
		return memberResult*profileResult*inviteResult*imgResult;
	} 
	




	
	
	
	
	
	
	
	
	
}//클래스 끝

package com.kh.know_how.admin.model.dao;

import java.util.ArrayList;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.ClassListDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorInviteCompleteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteListDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorProfileDTO;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.counselor.model.vo.CounselorProfilImg;
import com.kh.know_how.counselor.model.vo.CounselorProfile;
import com.kh.know_how.member.model.vo.Member;

@Repository
public class AdminDao {

	public int selectAlarmCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.selectAlarmCount");
	}

	public ArrayList<AdminCounselWaitingDto> selectWaitingList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectWaitingList");
	}

	public int selectCounselWaitingCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.selectCounselWaitingCount");
	}

	public ArrayList<TodayReservationDto> selectTodayReservationList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectTodayReservationList");
	}

	public int todayReservationCount(SqlSessionTemplate sqlSession) {
		
		return sqlSession.selectOne("adminMapper.todayReservationCount");
	}

	public ArrayList<AdminDashboardStatsDto>  selectDashboardStats(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectdashboardStats");
	}

	public int selectlistCount(SqlSessionTemplate sqlSession, CounselorSearchRequestDto counselorSearchRequestDto) {

		return sqlSession.selectOne("adminMapper.selectlistCount",counselorSearchRequestDto);
	}

	public ArrayList<CounselorListResponseDto> selectcounselorList(SqlSessionTemplate sqlSession,
			CounselorSearchRequestDto counselorSearchRequestDto) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectcounselorList",counselorSearchRequestDto);
	}

	public ArrayList<ClassListDto> selectClassList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectClassList");
	}

	public int updateCounselorClass(SqlSessionTemplate sqlSession, Map<String, Integer> param) {
		
		return sqlSession.update("adminMapper.updateCounselorClass", param);
	}

	public ArrayList<CounselCategoryDto> selectCounselCategory(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectCounselCategory");
	}

	public CounselorProfileDTO selectCounselorProfile(SqlSessionTemplate sqlSession, int userNo) {

		return sqlSession.selectOne("adminMapper.selectCounselorProfile",userNo);
	}

	public int updateCounselorStatus(SqlSessionTemplate sqlSession, Map<String, Object> param) {
		
		return sqlSession.update("adminMapper.updateCounselorStatus",param);
	}

	public int updateCounselorInvite(SqlSessionTemplate sqlSession, int inviteNo) {
		
		return sqlSession.update("adminMapper.deleteCounselorInvite",inviteNo);
	}

	public int clearStudentCounselorNo(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.update("adminMapper.clearStudentCounselorNo",userNo);
	}

	public int updateStudentCounselorNoByClassNo(SqlSessionTemplate sqlSession, Map<String, Integer> param) {
		
		return sqlSession.update("adminMapper.updateStudentCounselorNoByClassNo", param);
	}

	public int existsByEmail(SqlSessionTemplate sqlSession, String email) {
		
		return sqlSession.selectOne("adminMapper.existsByEmail", email);
	}

	public int insertCounselorInvite(SqlSessionTemplate sqlSession, CounselorInviteDto counselorInvite) {
		
		return sqlSession.insert("adminMapper.insertCounselorInvite",counselorInvite);
	}

	public ArrayList<CounselorInviteListDto> selectInviteList(SqlSessionTemplate sqlSession) {
		
		return (ArrayList)sqlSession.selectList("adminMapper.selectInviteList");
	}

	public CounselorInviteCompleteDto getCounselorInfo(SqlSessionTemplate sqlSession, String token) {
		
		return sqlSession.selectOne("adminMapper.getCounselorInfo",token);
	}

	public int insertCounselorMember(SqlSessionTemplate sqlSession, Member member) {
		
		return sqlSession.insert("adminMapper.insertCounselorMember", member);
	}

	public int insertCounselorProfile(SqlSessionTemplate sqlSession, CounselorProfile profile) {
		
		return sqlSession.insert("adminMapper.insertCounselorProfile", profile);
	}

	public int updateCounselorInviteInfo(SqlSessionTemplate sqlSession, CounselorInviteCompleteDto inviteInfoDto) {
		
		return sqlSession.update("adminMapper.updateCounselorInviteInfo", inviteInfoDto);
	}

	public int insertCounselorProfileImg(SqlSessionTemplate sqlSession, CounselorProfilImg cp) {
		
		return sqlSession.insert("adminMapper.insertCounselorProfileImg", cp);
	}

	public int updateCounselorCategoryNo(SqlSessionTemplate sqlSession, Map<String, Integer> param) {
		
		return sqlSession.update("adminMapper.updateCounselorCategoryNo", param);
	}

	public Integer selectUserClassNo(SqlSessionTemplate sqlSession, int userNo) {
		
		return sqlSession.selectOne("adminMapper.selectUserClassNo", userNo);
	}









	
	
	
	
	
	
	
	
}//클래스 끝

package com.kh.know_how.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.CounselorListResponseDto;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.admin.model.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	//필드부
	@Autowired
	AdminService as;
	
	
	//메소드부
	
	//-------------------메인페이지-------------------------
	
    @GetMapping("")
    public String adminRoot() {
    	
        return "redirect:/admin/index"; 
    }
    
    @GetMapping("/index")
    public String adminIndex(Model model) {
	    	
	    	//상담신청 대기목록 조회
	    	ArrayList<AdminCounselWaitingDto> waitingList = as.selectWaitingList();
	    	//상담신청 대기목록 개수 조회
	    	int CounselWaitingCount = as.selectCounselWaitingCount();
	    	//금일 상담일정 목록 조회
	    	ArrayList<TodayReservationDto> reservationList = as.selectTodayReservationList();
	    	//금일 상담일정 목록 개수 조회
	    	int todayReservatioCount = as.todayReservationCount();
	    	//통계 조회 - 월간 상담 현황 (당월/전월, 카테고리별)
	    	//조회건수가 0일 경우 정상 출력 확인(-), %를 합친 값이 101%일 경우 처리(-)
	    	ArrayList<AdminDashboardStatsDto> dashboard = as.selectDashboardStats();
	    	//상담카테고리 조회
	    	ArrayList<CounselCategoryDto> counselCategory = as.selectCounselCategory();
	    	
	    	
	    	model.addAttribute("waitingList",waitingList);
	    	model.addAttribute("CounselWaitingCount",CounselWaitingCount);
	    	model.addAttribute("reservationList",reservationList);
	    	model.addAttribute("todayReservatioCount",todayReservatioCount);
	    	model.addAttribute("dashboard",dashboard);
	    	model.addAttribute("counselCategory",counselCategory);
	    model.addAttribute("page", "adminIndex");
	    
	    
	    return "admin/adminLayout";
    }
    
    
    
    //----------- 상담사목록페이지조회메소드
    @GetMapping("/counselorList")
    public String counselorList(@RequestParam(value="cpage", defaultValue="1") int currentPage
    						  , CounselorSearchRequestDto counselorSearchRequestDto
    						  , Model model) {
    		
    		counselorSearchRequestDto.getPageRequest().setCurrentPage(currentPage);
    		
	    //상담사 목록 조회
	    	CounselorListPageDto counselorList = as.selectcounselorList(counselorSearchRequestDto);
	    	ArrayList<CounselorListResponseDto> a = counselorList.getCounselorList();
	    	
	    	model.addAttribute("status", counselorSearchRequestDto.getStatus());
	    	model.addAttribute("keyword", counselorSearchRequestDto.getKeyword());
	    	model.addAttribute("pageInfo", counselorList.getPageInfo());
	    	model.addAttribute("classList", counselorList.getClassList());
	    	model.addAttribute("counselorList", counselorList.getCounselorList());
	    	model.addAttribute("page", "counselorList");
    	
    	return "admin/adminLayout";
    } 
    
    
  //----------- 초대링크 비활성화 메소드
    @PostMapping("/invite/delete")
    public String deleteCounselorInvite(Model model) {
    	
        // 가입대기중인 상담사 초대링크 삭제
    		
    		
        model.addAttribute("page", "counselorList");
        
        
        return "admin/adminLayout";
    }

    //----------- 상담사 직무(클래스) 변경 메소드
    @ResponseBody
    @PostMapping("/class/update")
    public String updateCounselorClass(int userNo, Integer classNo) {

        // 상담사 담당 클래스 변경
    		int result = as.updateCounselorClass(userNo, classNo);

        return (result > 0) ? "success" : "fail";
    }

    //----------- 상담사 상세조회용 메소드
    @GetMapping("/counselorProfile")
    public String counselorProfile(Model model) {

        model.addAttribute("page", "counselorProfile");

        return "admin/adminLayout";
    }

    //----------- 상담사 등록 메소드
    @GetMapping("/counselorInvite")
    public String counselorInvite(Model model) {
    	
        model.addAttribute("page", "counselorInvite");

        return "admin/adminLayout";
    }
    
}//컨트롤러 끝

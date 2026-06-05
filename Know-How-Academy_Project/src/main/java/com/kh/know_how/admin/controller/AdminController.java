package com.kh.know_how.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.admin.model.service.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	//필드부
	@Autowired
	AdminService as;
	
	
	//메소드부
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
    	ArrayList<AdminDashboardStatsDto> dashboard = as.selectdashboardStats();
    	
    	
    	model.addAttribute("waitingList",waitingList);
    	model.addAttribute("CounselWaitingCount",CounselWaitingCount);
    	model.addAttribute("reservationList",reservationList);
    	model.addAttribute("todayReservatioCount",todayReservatioCount);
    	model.addAttribute("dashboard",dashboard);
        model.addAttribute("page", "adminIndex");
        return "admin/adminLayout";
    }
    
    
    @GetMapping("/counselorList")
    public String counselorList(@RequestParam(value="cpage", defaultValue="1") int currentPage
    						  , @RequestParam(value="status", defaultValue="AcTIVE") String status
    						  , Model model) {
    	
    	//상담사리스트 조회 + 페이징처리
    	CounselorListPageDto clp = as.counselorList(currentPage, status);
    	
    	
    	
    	model.addAttribute("page", "counselorList");
    	return "admin/adminLayout";
    } 

    
    @GetMapping("/counselorProfile")
    public String counselorProfile(Model model) {
    	
    	
    	
    	model.addAttribute("page", "counselorProfile");
    	return "admin/adminLayout";
    } 
    
     
    @GetMapping("/counselorInvite")
    public String counselorInvite(Model model) {
    	
    	model.addAttribute("page", "counselorInvite");
    	return "admin/adminLayout";
    } 
    
    
    
    
    
}//컨트롤러 끝

package com.kh.know_how.admin.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
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
    	int todayReservatioCount = as.todayReservatioCount();
    	//통계 조회 (-)
    	
    	model.addAttribute("waitingList",waitingList);
    	model.addAttribute("CounselWaitingCount",CounselWaitingCount);
    	model.addAttribute("reservationList",reservationList);
    	model.addAttribute("todayReservatioCount",todayReservatioCount);
        model.addAttribute("page", "adminIndex");
        return "admin/adminLayout";
    }
    
    
    @GetMapping("/counselor")
    public String counselorList(Model model) {
    	
    	
    	return "admin/counselorList";
    } 

    
    @GetMapping("/counselorProfile")
    public String counselorProfile(Model model) {
    	
    	
    	return "admin/counselorProfile";
    } 
 
    
}//컨트롤러 끝

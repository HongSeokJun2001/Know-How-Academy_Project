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
    	
    	//상담신청대기목록조회
    	ArrayList<AdminCounselWaitingDto> waitingList = as.selectWaitingList();
    	//상담신청대기목록갯수조회
    	int count = as.selectCounselWaitingCount();
    	//금일 상담일정 목록 조회
    	ArrayList<TodayReservationDto> reservationList = as.selectTodayReservationList();
    	
    	model.addAttribute("waitingList",waitingList);
    	model.addAttribute("count",count);
    	model.addAttribute("reservationList",reservationList);
        model.addAttribute("page", "adminIndex");
        return "admin/adminLayout";
    }
    
    
    
    
    
}//컨트롤러 끝

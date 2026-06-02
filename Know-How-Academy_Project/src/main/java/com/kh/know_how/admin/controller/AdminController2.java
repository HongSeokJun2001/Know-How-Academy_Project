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
public class AdminController2 {
	
	//필드부
	@Autowired
	AdminService as;
	
	
	//메소드부
        
    @GetMapping("/studentList")
    public String studentList() {
    	return "admin/studentList";
    }
    
    @GetMapping("/studentDetails")
    public String studentDetails() {
    	return "admin/studentDetails";
    }
    
    
}//컨트롤러 끝

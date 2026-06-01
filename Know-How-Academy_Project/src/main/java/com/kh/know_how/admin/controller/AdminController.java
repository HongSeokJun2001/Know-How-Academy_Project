package com.kh.know_how.admin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
    	
        model.addAttribute("page", "adminIndex");
        return "admin/adminLayout";
    }
    
    
    
    
}//컨트롤러 끝

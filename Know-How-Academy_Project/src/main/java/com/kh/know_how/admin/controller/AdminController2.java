package com.kh.know_how.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.admin.model.service.AdminService2;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.Pagination;
import com.kh.know_how.common.template.XssDefencePolicy;

@Controller
@RequestMapping("/admin")
public class AdminController2 {
	
	//필드부
	@Autowired
	AdminService2 as2;
	
	
	//메소드부
        
    @GetMapping("/studentList")
    public ModelAndView selectStudentList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
    	
    	int listCount = as2.selectStudentListCount();
    	int pageLimit = 4;
    	int boardLimit = 4;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<StudentDto> list = as2.selectStudentList(pi);
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "studentList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/studentList/search")
    public ModelAndView searchBoardList(String status, String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage) {
    	
    	ModelAndView mv = new ModelAndView();
    	keyword = XssDefencePolicy.defence(keyword);
    	HashMap<String, String> map = new HashMap<>();
    	map.put("status", status);
    	map.put("keyword", keyword);
    	
    	int searchCount = as2.selectStudentSearchCount(map);
    	int pageLimit = 4;
    	int boardLimit = 4;
    	
    	PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<StudentDto> list = as2.selectStudentList(map, pi);
    	
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("status", status)
    	  .addObject("keyword", keyword)
    	  .addObject("page", "studentList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/studentDetails/{studentNo}")
    public String studentDetails(@PathVariable int studentNo, Model model) {
    	StudentDto s = as2.selectStudentList(studentNo);
    	model.addAttribute("s", s);
    	model.addAttribute("page", "studentDetails");
    	return "admin/adminLayout";
    }
    
    
}//컨트롤러 끝

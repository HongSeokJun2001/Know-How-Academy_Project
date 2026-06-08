package com.kh.know_how.admin.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.dto.MemoDto;
import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.admin.model.service.AdminService2;
import com.kh.know_how.board.model.service.BoardService;
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
    public String searchBoardList(String status, String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
    	
    	keyword = XssDefencePolicy.defence(keyword);
    	HashMap<String, String> map = new HashMap<>();
    	map.put("status", status);
    	map.put("keyword", keyword);
    	
    	int searchCount = as2.selectStudentSearchCount(map);
    	int pageLimit = 4;
    	int boardLimit = 4;
    	
    	PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<StudentDto> list = as2.selectStudentList(map, pi);
    	
    	model .addAttribute("list", list)
    	  .addAttribute("pi", pi)
    	  .addAttribute("status", status)
    	  .addAttribute("keyword", keyword)
    	  .addAttribute("page", "studentList");
    	  
    	
    	return "admin/adminLayout";
    }
    
    @GetMapping("/studentDetails/{studentNo}")
    public String studentDetails(@PathVariable int studentNo, Model model) {
    	StudentDto s = as2.selectStudentList(studentNo);
    	model.addAttribute("s", s);
    	model.addAttribute("page", "studentDetails");
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/student/minsert")
    public String InsertStudentMemo(MemoDto m) {
    	
    	m.setUserMemo(XssDefencePolicy.defence(m.getUserMemo()));
    	int result = as2.insertStudentMemo(m);
    	
    	return (result > 0) ? "success" : "fail"; 
    }
    
    @ResponseBody
    @GetMapping("/student/mlist")
    public ArrayList<MemoDto> selectStudentMemo(int userNo) {
    	
    	return as2.selectStudentMemoList(userNo); 
    }
    
    @ResponseBody
    @PostMapping("/student/mdelete")
    public String DeleteStudentMemo(int memoNo) {
    	
    	int result = as2.deleteStudentMemo(memoNo);
    	
    	return (result > 0) ? "success" : "fail"; 
    }
    
    @ResponseBody
    @PostMapping("/student/rest")
    public String updateStudentStatus(StudentDto s) {
    	
    	int result = as2.updateStudentStatus(s);

    	return (result > 0) ? "success" : "fail"; 
    }
    
    @GetMapping("/student/enroll")
    public String selectPendingStudentList(Model model) {
    	
    	ArrayList<StudentDto> list = as2.selectPendingStudentList();
    	model.addAttribute("list", list)
    		 .addAttribute("page", "studentEnroll");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/student/approve")
    public String updateStudentApprove(int userNo, int classNo) {
    	
    	HashMap<String, Integer> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("classNo", classNo);
		
    	int result = as2.updateStudentApprove(map);
    	
    	return (result > 0) ? "success" : "fail"; 
    }

    @ResponseBody
    @PostMapping("/student/reject")
    public String updateStudentReject(int userNo) {
		
    	int result = as2.updateStudentReject(userNo);
    	
    	return (result > 0) ? "success" : "fail"; 
    }
    
    @GetMapping("/notice")
    public ModelAndView selectNoticeList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
    	
    	int listCount = as2.adminSelectNoticeCount();
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSelectNoticeList(pi);
    	
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "adminNoticeList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/notice/search")
    public String searchNoticeList(String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
    	
    	keyword = XssDefencePolicy.defence(keyword);
    	int listCount = as2.adminSearchNoticeCount(keyword);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSearchNoticeList(pi, keyword);
    	
    	model.addAttribute("list", list)
    	     .addAttribute("pi", pi)
    	     .addAttribute("keyword", keyword)
       	     .addAttribute("page", "adminNoticeList");
    	
    	return "admin/adminLayout";
    }
    
}//컨트롤러 끝

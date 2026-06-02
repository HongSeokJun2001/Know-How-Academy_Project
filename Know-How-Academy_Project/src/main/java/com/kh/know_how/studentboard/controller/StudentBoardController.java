package com.kh.know_how.studentboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.know_how.studentboard.model.service.StudentService;

@Controller
@RequestMapping("/student")
public class StudentBoardController {

	//@Autowired
	//private StudentService studentService;
	
	/**
	 * 수강생 게시글 리스트
	 * @return
	 */
	@GetMapping("/list")
	public String selectStudentList() {
		
		return "student/studentListView";
	}
}

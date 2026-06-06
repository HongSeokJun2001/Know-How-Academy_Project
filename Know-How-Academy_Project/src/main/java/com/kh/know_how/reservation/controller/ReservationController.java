package com.kh.know_how.reservation.controller;


import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.common.template.ReservationPagination;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.reservation.model.service.ReservationService;
import com.kh.know_how.reservation.model.vo.CounselCategory;
import com.kh.know_how.reservation.model.vo.Reservation;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;

    @GetMapping("/list")
    public ModelAndView selectReservationList(@RequestParam(value="cpage", defaultValue="1")int currentPage, ModelAndView mv, HttpSession session) {

    	Member loginUser = (Member)session.getAttribute("loginUser");
    	
    	int userNo = 0;
    	if(loginUser != null) {
    		userNo = loginUser.getUserNo();
    	} else {
    		mv.setViewName("common/errorPage");
    		return mv;
    	}
    	int listCount;
    	int pageLimit;
    	int reservationLimit;
    	int maxPage;
    	int startPage;
    	int endPage;
    	
    	listCount = reservationService.selectListCount(userNo);
    	
    	pageLimit = 10;
    	reservationLimit = 10;
    	
    	ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    	
    	ArrayList<Reservation> list = reservationService.selectReservationList(pi);
    	
    	
    	mv.addObject("list", list);
    	mv.addObject("pi", pi);
    	
        mv.setViewName("reservation/reservationListview");

        return mv;
    }
    
    @GetMapping("reservationEnrollForm")
    public String reservationEnrollForm(Model model) {
    	
    	ArrayList<CounselCategory> list = reservationService.selectCategoryList();
    	
    	model.addAttribute("list", list);
    	
    	
    	return "reservation/reservationEnrollForm";
    	
    }
}
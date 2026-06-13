package com.kh.know_how.admin.controller;

import java.time.Year;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.know_how.admin.model.dto.AdminCounselWaitingDto;
import com.kh.know_how.admin.model.dto.AdminDashboardStatsDto;
import com.kh.know_how.admin.model.dto.CounselCategoryDto;
import com.kh.know_how.admin.model.dto.CounselorInviteDto;
import com.kh.know_how.admin.model.dto.CounselorInviteListDto;
import com.kh.know_how.admin.model.dto.CounselorListPageDto;
import com.kh.know_how.admin.model.dto.CounselorProfileDTO;
import com.kh.know_how.admin.model.dto.CounselorSearchRequestDto;
import com.kh.know_how.admin.model.dto.TodayReservationDto;
import com.kh.know_how.admin.model.service.AdminService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/admin")
public class AdminController {
	
	//필드부
	@Autowired
	private AdminService as;
	
	
	//메소드부
	
	//-------------------메인페이지-------------------------
	
    @GetMapping("")
    public String adminRoot() {
    	
        return "redirect:/admin/index"; 
    }
    
    @GetMapping("/index")
    public String adminIndex(Model model) {
    	
    	
	    	
    	//상담신청 대기목록 및 개수 조회
    	ArrayList<AdminCounselWaitingDto> waitingList = as.selectWaitingList();
    	int counselWaitingCount = as.selectCounselWaitingCount();
    	
    	//금일 상담일정 목록 및 개수  조회
    	ArrayList<TodayReservationDto> reservationList = as.selectTodayReservationList();
    	int todayReservationCount = as.todayReservationCount();
    	
    	// 통계 및 상담 카테고리 조회	: %를 합친 값이 101%일 경우 처리(-)
    	ArrayList<AdminDashboardStatsDto> dashboard = as.selectDashboardStats();
    	ArrayList<CounselCategoryDto> counselCategory = as.selectCounselCategory();
    	
    	
    	model.addAttribute("waitingList",waitingList);
    	model.addAttribute("CounselWaitingCount",counselWaitingCount);
    	model.addAttribute("reservationList",reservationList);
    	model.addAttribute("todayReservatioCount",todayReservationCount);
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
    	
    	model.addAttribute("status", counselorSearchRequestDto.getStatus());
    	model.addAttribute("keyword", counselorSearchRequestDto.getKeyword());
    	model.addAttribute("pageInfo", counselorList.getPageInfo());
    	model.addAttribute("classList", counselorList.getClassList());
    	model.addAttribute("counselorList", counselorList.getCounselorList());
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
    @GetMapping("/counselorProfile/{userNo}")
    public String selectCounselorProfile(@PathVariable int userNo, Model model) {
    		
    	
		CounselorProfileDTO counselor = as.selectCounselorProfile(userNo);
		
		model.addAttribute("counselor",counselor);
        model.addAttribute("page", "counselorProfile");
        
        return "admin/adminLayout";
    }
    
    //----------- 상담사 (휴직/재직) 변경용 메소드
    @PostMapping("/counselor/updateStatus")
    public String updateCounselorStatus(int userNo, String status, Model model) {
    		
    	System.out.println(">>> [updateCounselorStatus] " +userNo+status );
		int result = as.updateCounselorStatus(userNo, status);
		
		if(result > 0) {
			System.out.println(result);
			return "redirect:/admin/counselorProfile/" + userNo;
		}else {
			System.out.println(result);
			model.addAttribute("errorMsg", "변경 실패. 다시 시도해주세요.");
			model.addAttribute("redirectUrl", "/admin/counselorProfile/"+userNo);
			model.addAttribute("page", "adminAlert");

			return "admin/adminLayout";
		}
    }
    
    
    //----------- 초대링크 비활성화 메소드
    @ResponseBody
    @PostMapping("/invite/delete")
    public String updateCounselorInvite(int inviteNo) {
    	
    	int result = as.updateCounselorInvite(inviteNo);
    	
    	return result > 0 ? "success" : "fail";
    }
    
    //----------- 상담사 등록 페이지 연결 메소드
    @GetMapping("/counselorInvite")
    public String counselorInvite(Model model) {
    	
        model.addAttribute("page", "counselorInvite");

        return "admin/adminLayout";
    }
    
    //----------- 상담사 초대메일 속 url을 작성하는 메소드
    public String counselorInviteMailContent(HttpServletRequest request) {
    	
    	String baseUrl =
    	        request.getScheme() + "://" +
    	        request.getServerName() +
    	        ":" +
    	        request.getServerPort() +
    	        request.getContextPath();

    	String inviteUrl = baseUrl + "/myPageCounselor/counselor/signup?token=";
    	
    	return inviteUrl;
    }
    
    //----------- 상담사 초대메일 전송 메소드
    @ResponseBody
    @PostMapping("/invite/mail")
    public Map inviteCounselor(HttpServletRequest request, CounselorInviteDto counselorInvite) {
    	
    	counselorInvite.setInviteUrl(counselorInviteMailContent(request));
    	
    	Map<String,String> message = new HashMap<>();
    	
    	try {
    		
        	String result = as.inviteCounselor(counselorInvite);
        	
    		switch(result) {
        	case "INVALID_EMAIL" 	: message.put("message", "이메일 입력형식이 올바르지 않습니다.");
        							  message.put("status", result);
        							  break;
        	case "DUPLICATE_EMAIL" 	: message.put("message", "사용 중인 이메일입니다. 이메일 주소를 확인해주세요.");
			  						  message.put("status", result);
        							  break;
        	case "INSERT_FAIL" 		: message.put("message", "서버가 혼잡합니다. 잠시후 다시 시도해주세요.");
        							  message.put("status", result);
        							  break;
        	case "SUCCESS" 			: message.put("message", "초대 메일이 발송되었습니다.");
        							  message.put("status", result);
									  break;
        	default					: System.out.println(">>> [inviteCounselor : 지정하지않은결과값출력] " + result);
						        	  message.put("message", "초대 처리 중 문제가 발생했습니다.");
						        	  message.put("status", result);
    		}
    		
		} catch (IllegalArgumentException e) {
			// 컨트롤러에서 에러처리를 담당하므로 Ajax success 함수로 전달됨
			
			System.out.println(">>> [메일 발송 오류] " + e.getMessage());
			message.put("message", e.getMessage());
			message.put("status", "MAIL_FAIL");
			
		} catch (RuntimeException e) {
			
			System.out.println(">>> [메일 발송 오류] " + e.getMessage());
			message.put("message", "메일 발송에 실패했습니다. 잠시 후 다시 시도해주세요.");
			message.put("status", "MAIL_FAIL");
		}
    	
    	
    	return message;
    }
    
    @GetMapping("/invite/list")
    public String selectInviteList(Model model) {
    	
    	ArrayList<CounselorInviteListDto> inviteList = as.selectInviteList();
    	model.addAttribute("inviteList",inviteList);
    	
    	
//    	for(CounselorInviteListDto a : inviteList) {
//    		System.out.println(a);
//    	}
    	
    	return "admin/counselorInviteList";
    }

    
    
}//컨트롤러 끝

package com.kh.know_how.reservation.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.common.model.vo.ReservationPageInfo;
import com.kh.know_how.common.template.ReservationPagination;
import com.kh.know_how.common.template.XssDefencePolicy;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.reservation.model.service.ReservationService;
import com.kh.know_how.reservation.model.vo.CounselLog;
import com.kh.know_how.reservation.model.vo.Reservation;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("reservation")
public class ReservationController {

    @Autowired
    private ReservationService reservationService;
    
    /**
     * 권한별 상담 예약/접수 현황 목록 조회 (페이징 처리)
     * @param currentPage
     * @param mv
     * @param session
     * @return
     */
    @GetMapping("/list")
    public ModelAndView selectReservationList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, HttpSession session) {
    	
    	Member loginUser = (Member)session.getAttribute("loginUser");
    	
    	int userNo = 0;
    	if(loginUser != null) {
    		userNo = loginUser.getUserNo();
    	} else {
    		mv.setViewName("common/errorPage");
    		return mv;
    	}
    	int listCount;
    	int pageLimit = 10;
    	int reservationLimit = 10;
    	
    	
    	// 상담사 권한일 때 
    	if("COUNSELOR".equals(loginUser.getRoleCode())) {
    		
    		listCount = reservationService.selectCounselorListCount(userNo);
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectCounselorReservationList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorReservationListview");
    		
    	// 학생 권한일 때
    	} else if("STUDENT".equals(loginUser.getRoleCode())) {
    		
    		listCount = reservationService.selectListCount(userNo);
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectReservationList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/reservationListview");
    	
    	// 강사 권한일 떄 (담당 반 번호 기준 조회)
    	} else if("INSTRUCTOR".equals(loginUser.getRoleCode())) {
    		int classNo = loginUser.getClassNo();
    		listCount = reservationService.selectInstructorListCount(classNo);
    		
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(classNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectInstructorReservationList(pi, classNo);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorReservationListview");
    	
    	// 최고 관리자 권한일 떄 (전체 조회)
    	} else if("ADMIN".equals(loginUser.getRoleCode())) {
    		listCount = reservationService.selectAdminListCount();
    		
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(0, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectAdminReservationList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorReservationListview");
    		
    	} else {
    		mv.addObject("errorMsg", "예약 내역 조회가 불가능한 권한입니다.").setViewName("common/errorPage");
    	}
    
        return mv;
    }
    
    /**
     * [학생] 상담사 전체 목록 조회
     * - 학생이 상담 신청 전, 활성화 된 상담사 리스트를 확인하는 화면
     * @param mv
     * @return
     */
    @GetMapping("/counselorList")
    public ModelAndView counselorListView(ModelAndView mv) {
    	ArrayList<Reservation> counselorList = reservationService.selectCounselorDetailList();
    	
    	mv.addObject("counselorList", counselorList);
    	mv.setViewName("reservation/counselorListView");
    	return mv;
    }
    
    /**
     * [학생] 상담 신청서 작성 폼 이동
     * @param counselNo
     * @param model
     * @return
     */
    @GetMapping("reservationEnrollForm")
    public String reservationEnrollForm(@RequestParam("counselNo") int counselNo, Model model) {
    	Reservation selectedCounselor = reservationService.selectOneCounselor(counselNo);
    	
    	model.addAttribute("selectedCounselor", selectedCounselor);
    	return "reservation/reservationEnrollForm";   	
    }

    /**
     * [학생] 상담 신청서 등록 실행 (INSERT)
     * @param r
     * @param session
     * @param model
     * @return
     */
    @PostMapping("insert")
    public String insertReservation(Reservation r, HttpSession session, Model model) {
    	Member loginUser = (Member)session.getAttribute("loginUser");
    	
    	//XSS 공격 방지
    	if(r.getInquiryContent() != null) {
    		String replaceContent = XssDefencePolicy.defence(r.getInquiryContent());
    		r.setInquiryContent(replaceContent);
    	}
    	
    	r.setUserNo(loginUser.getUserNo());
    	int result = reservationService.insertReservation(r);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담 신청이 완료되었습니다.");
    		return "redirect:/reservation/list";
    	} else {
    		model.addAttribute("errorMsg", "상담 신청에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [학생] 상담 신청 세부 내역 상세 조회
     * 상담 완료 상태인 경우 등록된 상담 일지까지 함께 조회
     * @param rno
     * @param mv
     * @return
     */
    @GetMapping("detail/{rno}")
    public ModelAndView selectReservationDetail(@PathVariable("rno") int rno, ModelAndView mv) {
    	Reservation r = reservationService.selectReservationDetail(rno);
    	
    	if(r != null) {
    		mv.addObject("r", r);
    		
    		CounselLog log = reservationService.selectCounselorLog(rno);
    		mv.addObject("log", log);
    		
    		mv.setViewName("reservation/reservationDetailview");
    	} else {
    		mv.addObject("errorMsg", "삭제되었거나 존재하지 않는 상담 예약 내역입니다.");
    		mv.setViewName("common/errorPage");
    	}
    	return mv;
    }
    
    /**
     * [학생] 상담 예약 취소 실행 (DELETE)
     * @param reservationNo
     * @param model
     * @param session
     * @return
     */
    @PostMapping("delete")
    public String deleteReservation(@RequestParam("rno") int reservationNo, Model model, HttpSession session) {
    	int result = reservationService.deleteReservation(reservationNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "성공적으로 상담 예약이 취소되었습니다.");
    		return "redirect:/reservation/list";
    	} else {
    		model.addAttribute("errorMsg", "상담 예약 취소에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [학생] 상담 신청 수정 폼 이동
     * @param rno
     * @param model
     * @return
     */
    @PostMapping("updateForm")
    public String reservationUpdateForm(@RequestParam("rno") int rno, Model model) {
    	Reservation r = reservationService.selectReservationDetail(rno);
    	
    	model.addAttribute("r", r);
    	return "reservation/reservationUpdateForm";
    }
    
    /**
     * [학생] 상담 신청 수정 실행 (UPDATE)
     * @param r
     * @param session
     * @param model
     * @return
     */
    @PostMapping("update")
    public String updateReservation(Reservation r, HttpSession session, Model model) {
    	
    	//XSS 공격 방지
    	if(r.getInquiryContent() != null) {
    		String replaceContent = XssDefencePolicy.defence(r.getInquiryContent());
    		r.setInquiryContent(replaceContent);
    	}
    	
    	int result = reservationService.updateReservation(r);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담 신청 내역이 성공적으로 수정되었습니다.");
    		return "redirect:/reservation/list";
    	} else {
    		model.addAttribute("errorMsg", "상담 신청 내역 수정에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [상담사] 상담사 전용 상담 예약 접수 현황 목록 조회 
     * @param currentPage
     * @param mv
     * @param session
     * @return
     */
    @GetMapping("/counselorReservationList")
    public ModelAndView selectCounselorReservationList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, HttpSession session) {
    	Member loginUser = (Member)session.getAttribute("loginUser");
    	
    	int userNo = 0;
    	if(loginUser != null) {
    		userNo = loginUser.getUserNo();
    	} else {
    		mv.setViewName("common/errorPage");
    		return mv;
    	}
    	
    	int listCount;
    	int pageLimit = 10;
    	int reservationLimit = 10;
    	
    	listCount = reservationService.selectCounselorListCount(userNo);
    	ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    	ArrayList<Reservation> list = reservationService.selectCounselorReservationList(pi);
    	
    	mv.addObject("list", list);
    	mv.addObject("pi", pi);
    	mv.setViewName("reservation/counselorReservationListview");
    	
    	return mv;
    }
    
    /**
     * [상담사] 상담예약 접수 상세 내역 조회
     * @param rno
     * @param mv
     * @return
     */
    @GetMapping("counselorDetail/{rno}")
    public ModelAndView selectCounselorReservationDetail(@PathVariable("rno") int rno, ModelAndView mv) {
    	Reservation r = reservationService.selectReservationDetail(rno);
    	
    	if(r != null) {
    		mv.addObject("r", r);
    		
    		CounselLog log = reservationService.selectCounselorLog(rno);
    		mv.addObject("log", log);
    		mv.setViewName("reservation/counselorReservationDetailview");
    	} else {
    		mv.addObject("errorMsg", "존재하지 않는 상담 예약 내역입니다.");
    		mv.setViewName("common/errorPage");
    	}
    	return mv;
    }
    
    /**
     * [상담사] 상담 신청 상태 승인 처리 ('APPLIED' -> 'RESERVED')
     * @param reservationNo
     * @param session
     * @param model
     * @return
     */
    @PostMapping("approve")
    public String approveReservation(@RequestParam("rno") int reservationNo, HttpSession session, Model model) {
    	int result = reservationService.approveReservation(reservationNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담신청을 승인했습니다.");
    		return "redirect:/reservation/counselorReservationList";
    	} else {
    		model.addAttribute("errorMsg", "상담 승인 처리에 실패했습니다.");
    		return "common/errorPage";
    	}
    }

    /**
     * [상담사] 상담 신청 상태 반려/거절 처리 ('APPLIED' -> 'REJECTED')
     * @param reservationNo
     * @param session
     * @param model
     * @return
     */
    @PostMapping("reject")
    public String rejectReservation(@RequestParam("rno") int reservationNo, HttpSession session, Model model) {
    	int result = reservationService.rejectReservation(reservationNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담 신청을 거절(반려)하였습니다.");
    		return "redirect:/reservation/counselorReservationList";
    	} else {
    		model.addAttribute("errorMsg", "상담 거절 처리에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [상담사] 상담 완료 상태 변경 처리 ('RESERVED' -> 'COMPLETED')
     * @param reservationNo
     * @param session
     * @param model
     * @return
     */
    @PostMapping("complete")
    public String completeReservation(@RequestParam("rno") int reservationNo, HttpSession session, Model model) {
    	int result = reservationService.completeReservation(reservationNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담 완료 처리가 되었습니다.");
    		return "redirect:/reservation/counselorDetail/" + reservationNo;
    	} else {
    		model.addAttribute("errorMsg", "상담 완료 처리에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [상담사] 상담일지 작성/수정 폼 이동
     * @param rno
     * @param model
     * @return
     */
    @GetMapping("logForm")
    public String counselorLogEnrollForm(@RequestParam("rno") int rno, Model model) {
    	Reservation r = reservationService.selectReservationDetail(rno);
    	CounselLog log = reservationService.selectCounselorLog(rno);
    	
    	model.addAttribute("r", r);
    	model.addAttribute("log", log);
    	
    	return "reservation/counselorLogEnrollForm";
    }
    
    /**
     * [상담사] 상담일지 신규 작성 등록 실행 (INSERT)
     * @param log
     * @param session
     * @param model
     * @return
     */
    @PostMapping("insertLog")
    public String insertCounselorLog(CounselLog log, HttpSession session, Model model) {
    	
    	//XSS 공격 방지
    	if(log.getContent() != null) {
    		String replaceContent = XssDefencePolicy.defence(log.getContent());
    		log.setContent(replaceContent);
    	}
    	
    	int result = reservationService.insertCounselorLog(log);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담일지가 성공적으로 등록되었습니다.");
    		return "redirect:/reservation/counselorDetail/" + log.getReservationNo();
    	} else {
    		model.addAttribute("errorMsg", "상담일지 등록에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [상담사] 상담일지 수정 실행 (UPDATE)
     * @param log
     * @param session
     * @param model
     * @return
     */
    @PostMapping("updateLog")
    public String updateCounselorLog(CounselLog log, HttpSession session, Model model) {
    	
    	//XSS 공격 방지
    	if(log.getContent() != null) {
    		String replaceContent = XssDefencePolicy.defence(log.getContent());
    		log.setContent(replaceContent);
    	}
    	
    	int result = reservationService.updateCounselorLog(log);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담일지가 성공적으로 수정되었습니다.");
    		return "redirect:/reservation/counselorDetail/" + log.getReservationNo();
    	} else {
    		model.addAttribute("errorMsg", "상담일지 수정에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * [상담사] 상담일지 삭제 실행 (DELETE)
     * @param reservationNo
     * @param session
     * @param model
     * @return
     */
    @PostMapping("deleteLog")
    public String deleteCounselorLog(@RequestParam("rno") int reservationNo, HttpSession session, Model model) {
    	int result = reservationService.deleteCounselorLog(reservationNo);
    	
    	if(result > 0) {
    		session.setAttribute("alertMsg", "상담일지가 삭제되었습니다.");
    		return "redirect:/reservation/counselorDetail/" + reservationNo;
    	} else {
    		model.addAttribute("errorMsg", "상담일지 삭제에 실패했습니다.");
    		return "common/errorPage";
    	}
    }
    
    /**
     * 권한별 상담 완료 내역 목록 조회(페이징 처리)
     * @param currentPage
     * @param mv
     * @param session
     * @return
     */
    @GetMapping("/counselor/list")
    public ModelAndView selectCompletedReservationList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, HttpSession session) {
    	
    	Member loginUser = (Member)session.getAttribute("loginUser");
    	
    	if(loginUser == null) {
    		mv.setViewName("common/errorPage");
    		return mv;
    	}
    	int userNo = loginUser.getUserNo();
    	int pageLimit = 10;
    	int reservationLimit = 10;
    	int listCount;
    	
    	// 상담사 권한일 때 완료 내역 조회
    	if("COUNSELOR".equals(loginUser.getRoleCode())) {
    		listCount = reservationService.selectCounselorCompletedListCount(userNo);
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectCounselorCompletedList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorCounselListview");
    	// 학생 권한일 때 완료 내역 조회
    	} else if("STUDENT".equals(loginUser.getRoleCode())) {
    		listCount = reservationService.selectStudentCompletedListCount(userNo);
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(userNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectStudentCompletedList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselListview");
    	// 강사 권한일 떄 반별 완료 내역 조회
    	} else if("INSTRUCTOR".equals(loginUser.getRoleCode())) {
    		int classNo = loginUser.getClassNo();
    		listCount = reservationService.selectInstructorCompletedListCount(classNo);
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(classNo, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectInstructorCompletedList(pi, classNo);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorCounselListview");
    	// 최고 관리자 권한일 때 전체 완료 내역 조회
    	} else if("ADMIN".equals(loginUser.getRoleCode())) {
    		listCount = reservationService.selectAdminCompletedListCount();
    		ReservationPageInfo pi = ReservationPagination.getReservationPageInfo(0, listCount, currentPage, pageLimit, reservationLimit);
    		ArrayList<Reservation> list = reservationService.selectAdminCompletedList(pi);
    		
    		mv.addObject("list", list);
    		mv.addObject("pi", pi);
    		mv.setViewName("reservation/counselorCounselListview");
    	} else {
    		mv.addObject("errorMsg", "상담조회가 불가능한 권한입니다.").setViewName("common/errorPage");
    	}
    	
    	return mv;
    }
    
}
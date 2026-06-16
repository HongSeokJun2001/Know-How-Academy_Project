package com.kh.know_how.admin.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.dto.MemoInsertDto;
import com.kh.know_how.admin.model.dto.MemoListDto;
import com.kh.know_how.admin.model.dto.StudentApproveDto;
import com.kh.know_how.admin.model.dto.StudentDetailDto;
import com.kh.know_how.admin.model.dto.StudentListDto;
import com.kh.know_how.admin.model.dto.StudentPendingListDto;
import com.kh.know_how.admin.model.dto.StudentSearchListDto;
import com.kh.know_how.admin.model.dto.StudentSearchRequestDto;
import com.kh.know_how.admin.model.dto.StudentStatusDto;
import com.kh.know_how.admin.model.service.AdminService2;
import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.FileRenamePolicy;
import com.kh.know_how.common.template.Pagination;
import com.kh.know_how.common.template.XssDefencePolicy;
import com.kh.know_how.member.model.service.MemberService;
import com.kh.know_how.member.model.vo.Member;
import com.kh.know_how.member.model.vo.MemberLock;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController2 {
	
	//필드부
	@Autowired
	AdminService2 as2;
	
	@Autowired
	BoardService bs;
	
	@Autowired
	MemberService ms;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Autowired
	private JavaMailSender mailSender; 
	
	private Map<String, String> certNoList = Collections.synchronizedMap(new HashMap<>());
	
	//메소드부    
    @GetMapping("/studentList")
    public ModelAndView selectStudentList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) { // 재학, 휴학중인 학원생 리스트를 불러오는 메소드
    	
    	int listCount = as2.selectStudentListCount();
    	int pageLimit = 4;
    	int boardLimit = 4;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<StudentListDto> list = as2.selectStudentList(pi);
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "studentList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/studentList/search")
    public String searchBoardList(StudentSearchRequestDto studentSearchRequest, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) { // 학원생 검색 시 검색에 해당하는 학원생 리스트를 불러오는 메소드
    	
    	studentSearchRequest.setKeyword(XssDefencePolicy.defence(studentSearchRequest.getKeyword()));
    	
    	int searchCount = as2.searchStudentCount(studentSearchRequest);
    	int pageLimit = 4;
    	int boardLimit = 4;
    	
    	PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<StudentSearchListDto> list = as2.searchStudentList(studentSearchRequest, pi);
    	
    	model.addAttribute("list", list)
    	  .addAttribute("pi", pi)
    	  .addAttribute("studentSearchRequest", studentSearchRequest)
    	  .addAttribute("page", "studentList");
    	  
    	
    	return "admin/adminLayout";
    }
    
    @GetMapping("/studentDetails/{studentNo}")
    public String selectStudentDetails(@PathVariable int studentNo, Model model) { // 학원생의 상세정보를 불러오는 메소드
    	StudentDetailDto studentDetail = as2.selectStudent(studentNo);
    	model.addAttribute("studentDetail", studentDetail);
    	model.addAttribute("page", "studentDetails");
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/student/minsert")
    public String insertStudentMemo(MemoInsertDto memoInsert) { // 학원생의 메모를 추가하는 메소드
    	
    	memoInsert.setUserMemo(XssDefencePolicy.defence(memoInsert.getUserMemo()));

    	return (as2.insertStudentMemo(memoInsert) > 0) ? "success" : "fail"; 
    }
    
    @ResponseBody
    @GetMapping("/student/mlist")
    public ArrayList<MemoListDto> selectStudentMemo(int userNo) { // 학원생의 메모리스트를 불러오는 메소드
    	
    	return as2.selectStudentMemoList(userNo); 
    }
    
    @ResponseBody
    @PostMapping("/student/mdelete")
    public String deleteStudentMemo(int memoNo) { // 학원생의 메모를 제거하는 메소드
    	
    	return (as2.deleteStudentMemo(memoNo) > 0) ? "success" : "fail"; 
    }
    
    @ResponseBody
    @PostMapping("/student/rest")
    public String updateStudentStatus(StudentStatusDto studentStatus) { // 학원생의 휴학/재학 처리하는 메소드
    	
    	return (as2.updateStudentStatus(studentStatus) > 0) ? "success" : "fail"; 
    }
    
    @GetMapping("/student/enroll")
    public String selectPendingStudentList(Model model) { // 가입 대기중인 학원생 리스트를 불러오는 메소드
    	
    	ArrayList<StudentPendingListDto> list = as2.selectPendingStudentList();
    	model.addAttribute("list", list)
    		 .addAttribute("page", "studentEnroll");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/student/approve")
    public String updateStudentApprove(StudentApproveDto studentApprove) { // 학원생의 가입을 승인해주는 메소드
    
    	return (as2.updateStudentApprove(studentApprove) > 0) ? "success" : "fail"; 
    }

    @ResponseBody
    @PostMapping("/student/reject")
    public String updateStudentReject(int userNo) { // 학원생의 가입을 거절하는 메소드
		
    	return (as2.updateStudentReject(userNo) > 0) ? "success" : "fail"; 
    }
    
    @ResponseBody
    @PostMapping("/student/delete")
    public String deleteStudent(int userNo) { // 학원생의 가입을 삭제하는 메소드
		
    	return (as2.deleteStudent(userNo) > 0) ? "success" : "fail"; 
    }
    
    @GetMapping("/notice")
    public ModelAndView selectNoticeList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) { // 공지사항 리스트를 불러오는 메소드
    	
    	String postType = "NOTICE";
    	int listCount = as2.adminSelectBoardCount(postType);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSelectBoardList(pi, postType);
    	
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "adminNoticeList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/notice/search")
    public String searchNoticeList(String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) { // 검색된 공지사항 리스트를 불러오는 메소드
    	
    	String postType = "NOTICE";
    	keyword = XssDefencePolicy.defence(keyword);
    	
    	HashMap<String, String> map = new HashMap<>();
    	map.put("postType", postType);
    	map.put("keyword", keyword);
    	
    	int listCount = as2.adminSearchBoardCount(map);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSearchBoardList(pi, map);
    	
    	model.addAttribute("list", list)
    	     .addAttribute("pi", pi)
    	     .addAttribute("keyword", keyword)
       	     .addAttribute("page", "adminNoticeList");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/notice/delete")
    public String deleteNotice(int postNo, HttpSession session) { // 공지사항을 삭제하는 메소드

    	FileAttachment fa = bs.selectFileAttachment(postNo);
    	
    	int result2 = 1;
    	
    	if(fa != null) {
			
			String savePath = session.getServletContext().getRealPath("/resources/upload/notice/");
			
			new File(savePath + fa.getSaveName()).delete();
    		
    		result2 =  as2.adminDeleteFileAttachment(postNo);
			
		}
    	
    	return ((as2.adminDeleteBoard(postNo) * result2) > 0) ? "success" : "fail";
    }
    
    @GetMapping("/notice/enrollForm")
    public String noticeEnrollForm(Model model) { // 공지사항 작성 페이지를 호출하는 메소드
    	
    	model.addAttribute("page", "adminNoticeEnrollForm");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/notice/insert")
    public String insertNotice(Board n, MultipartFile upfile, HttpSession session) { // 공지사항을 추가하는 메소드
    	
    	FileAttachment fa = null;
    	
    	if(!upfile.getOriginalFilename().equals("")) {
    		
    		String saveName = FileRenamePolicy.saveFile(upfile, session, "/resources/upload/notice/");
    		
    		fa = new FileAttachment();
    		fa.setTargetType("NOTICE");
    		fa.setOriginName(upfile.getOriginalFilename());
    		fa.setSaveName(saveName);
    		fa.setFilePath("/resources/upload/notice/");
    	}
    	
    	n.setPostType("NOTICE");
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	
    	int result = bs.insertBoard(n, fa);
    	
    	if(result > 0) {
    		
    		return "success";
    	} else {
    		
    		if(fa != null) {
    			
    			String savePath = session.getServletContext()
    									 .getRealPath("/resources/upload/notice");
    			
    			new File(savePath + fa.getSaveName()).delete();
    		}
    		
    		return "fail";
    	}
    }
    
    @GetMapping("/notice/detail/{postNo}")
    public String selectNoticeDetail(@PathVariable int postNo, Model model) { // 공지사항의 상세정보를 불러오는 메소드
    	Board n = as2.adminSelectBoard(postNo);
    	
    	FileAttachment fa = bs.selectFileAttachment(postNo);
    	model.addAttribute("n", n)
    		 .addAttribute("fa", fa)
    	     .addAttribute("page", "adminNoticeDetail");
    	return "admin/adminLayout";
    }
    
    @PostMapping("/notice/updateForm")
    public String noticeUpdateForm(int postNo, Model model) { // 공지사항 수정 페이지를 호출하는 메소드
    	
    	Board n = as2.adminSelectBoard(postNo);
    	FileAttachment fa = bs.selectFileAttachment(postNo);
    	
    	model.addAttribute("n", n)
    	 	 .addAttribute("fa", fa)
    	 	 .addAttribute("page", "adminNoticeUpdateForm");
    	
		return "admin/adminLayout";
    	
    }
    
    @ResponseBody
    @PostMapping("/notice/update")
    public String updateNotice(Board n ,MultipartFile reUpfile,
    						   @RequestParam(defaultValue="0") int originalFileNo,
    						   String originalFileSaveName,
    						   HttpSession session,
    						   Model model) { // 공지사항 수정하는 메소드
    	
    	FileAttachment fa = null;
    	
    	if(!reUpfile.getOriginalFilename().equals("")) {
    		
    		String saveName = FileRenamePolicy.saveFile(reUpfile, session, "/resources/upload/notice/");	
    		
    		fa = new FileAttachment();
    		fa.setTargetType("NOTICE");
    		fa.setOriginName(reUpfile.getOriginalFilename());
    		fa.setSaveName(saveName);
    		fa.setTargetNo(n.getPostNo());
			fa.setFilePath("/resources/upload/notice/");
			
    		if(originalFileNo != 0 ) {
    			
    			fa.setFileNo(originalFileNo);
    			
    			String savePath = session.getServletContext()
    									 .getRealPath("/resources/upload/notice/");
    			new File(savePath + originalFileSaveName).delete();
    			
    		}
    		
    	}
    	
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	n.setPostType("NOTICE");
    	
    	return (as2.updateNotice(n, fa) > 0) ? "success" : "fail";
    	
    }
    
    @GetMapping("/academyNews")
    public ModelAndView selectNewsList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) { // 학원소식의 리스트를 불러오는 메소드
    	
    	String postType = "NEWS";
    	int listCount = as2.adminSelectBoardCount(postType);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSelectBoardList(pi, postType);
    	
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "academyNewsList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/academyNews/search")
    public String searchNewsList(String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) { // 검색된 학원소식의 리스트를 불러오는 메소드
    	
    	String postType = "NEWS";
    	keyword = XssDefencePolicy.defence(keyword);
    	
    	HashMap<String, String> map = new HashMap<>();
    	map.put("postType", postType);
    	map.put("keyword", keyword);
    	
    	int listCount = as2.adminSearchBoardCount(map);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSearchBoardList(pi, map);
    	
    	model.addAttribute("list", list)
    	     .addAttribute("pi", pi)
    	     .addAttribute("keyword", keyword)
       	     .addAttribute("page", "academyNewsList");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/academyNews/delete")
    public String deleteNews(int postNo, HttpSession session) { // 학원소식을 삭제하는 메소드

    	ArrayList<FileAttachment> list = bs.selectFileAttachmentList(postNo);
    	
    	int result2 = 1;
    	
    	if(list != null) {
    		
    		String savePath = session.getServletContext().getRealPath("/resources/upload/news/");
    		
    		for(FileAttachment fa : list) {

    			new File(savePath + fa.getSaveName()).delete();
            }
    		
			result2 =  as2.adminDeleteFileAttachment(postNo);
		}
    	
    	return ((as2.adminDeleteBoard(postNo) * result2) > 0) ? "success" : "fail";
    }
    
    @GetMapping("/academyNews/enrollForm")
    public String newsEnrollForm(Model model) { // 학원소식 작성 페이지를 불러오는 메소드
    	
    	model.addAttribute("page", "academyNewsEnrollForm");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/academyNews/insert")
    public String insertNews(Board n, MultipartFile[] files, HttpSession session) { // 학원소식 추가하는 메소드
    	
    	ArrayList<FileAttachment> list = new ArrayList<>();
    	
    	for(int i = 0; i < files.length; i++) {
    		
    		if(!files[i].getOriginalFilename().equals("")) {
        		
        		String saveName = FileRenamePolicy.saveFile(files[i], session, "/resources/upload/news/");
        		
        		FileAttachment fa = new FileAttachment();
        		fa.setTargetType("NEWS");
        		fa.setOriginName(files[i].getOriginalFilename());
        		fa.setSaveName(saveName);
        		fa.setFilePath("/resources/upload/news/");
        		
        		if(i == 0) {
        			
        			fa.setFileLevel(1);
        			
        		} else {
        			
        			fa.setFileLevel(2);
        		}
        		
        		list.add(fa);
        	}
    		
    	}
    	
    	n.setPostType("NEWS");
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	
    	int result = as2.insertNews(n, list);
    	
    	return (result > 0) ? "success" : "fail";
     }
    
    @GetMapping("academyNews/detail/{postNo}")
	public String selectNewsDetail(@PathVariable int postNo, Model model) { // 학원소식의 상세정보를 불러오는 메소드
		Board n = as2.adminSelectBoard(postNo);
		
		ArrayList<FileAttachment> list = bs.selectFileAttachmentList(postNo);

		model.addAttribute("n", n)
		     .addAttribute("list", list)
		     .addAttribute("page", "academyNewsDetail");
		
		return "admin/adminLayout";
	}
    
    @PostMapping("/academyNews/updateForm")
    public String NewsUpdateForm(int postNo, Model model) { // 학원소식 수정 페이지를 불러오는 메소드
    	
    	Board n = as2.adminSelectBoard(postNo);
    	ArrayList<FileAttachment> list = bs.selectFileAttachmentList(postNo);
    	
    	model.addAttribute("n", n)
    	 	 .addAttribute("list", list)
    	 	 .addAttribute("page", "academyNewsUpdateForm");
    	
		return "admin/adminLayout";
    	
    }
    
    @ResponseBody
    @PostMapping("/academyNews/update")
    public String updateNews(Board n ,MultipartFile[] reFiles,
    						 @RequestParam Map<String, String> paramMap,
    						 @RequestParam(value="deleteFileNo", required=false) String[] deleteFileNo,
                             @RequestParam(value="deleteSaveName", required=false) String[] deleteSaveName,
    						 HttpSession session,
    						 Model model) { // 학원소식 수정하는 메소드

    	ArrayList<FileAttachment> list = new ArrayList<>();
    	if (reFiles != null) {
	    	for(int i = 0; i < reFiles.length; i++) {
	    		
	    		if(reFiles[i] != null && !reFiles[i].getOriginalFilename().equals("")) {
	        		
	        		String saveName = FileRenamePolicy.saveFile(reFiles[i], session, "/resources/upload/news/");	
	        		
	        		FileAttachment fa = new FileAttachment();
	        		fa.setTargetType("NEWS");
	        		fa.setOriginName(reFiles[i].getOriginalFilename());
	        		fa.setSaveName(saveName);
	        		fa.setTargetNo(n.getPostNo());
        			fa.setFilePath("/resources/upload/news/");
        			
        			fa.setFileLevel(i == 0 ? 1 : 2);
        			
        			String originalFileNo = paramMap.get("originalFileNo" + (i + 1));
        			
	        		if(originalFileNo != null && !originalFileNo.equals("0") && !originalFileNo.isEmpty()) {
	        			
	        			int fileNo = Integer.parseInt(originalFileNo);
	        			fa.setFileNo(fileNo);
	        							
	        		}
	        		
	        		list.add(fa);
	        	}
	    	}
    	}
    	
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	n.setPostType("NEWS");
    	
    	int result = as2.updateNews(n, list, deleteFileNo);
    	
    	return (result > 0) ? "success" : "fail";
    	
    }
    
    @ResponseBody
    @PostMapping("/board/visible")
    public String updateNoticeStatus(Board b) { // 공지사항, 학원소식의 노출/숨김 처리하는 메소드
    	
    	return (as2.adminUpdateBoardStatus(b) > 0) ? "success" : "fail";
    }
    
    @GetMapping("/loginForm")
    public String adminLoginForm() { // 관리자 페이지 접속 시 관리자 로그인 페이지로 나오게 해주는 메소드
    	
    	return "admin/adminLogin";
    }
    
    @ResponseBody
    @PostMapping("/login")
    public String adminLogin(Member m, HttpSession session) { // 관리자만 로그인해주는 메소드
    	
    	m.setUserId(XssDefencePolicy.defence(m.getUserId()));
    	m.setUserPwd(XssDefencePolicy.defence(m.getUserPwd()));
    	
    	Member loginUser = ms.loginMember(m.getUserId());
    	
    	String encPwd = bCryptPasswordEncoder.encode(m.getUserPwd());
		System.out.println("암호문 : " + encPwd);
    	
    	if((loginUser != null) && (bCryptPasswordEncoder.matches(m.getUserPwd(), loginUser.getUserPwd()))) {
    		
    		session.setAttribute("loginUser", loginUser);
    		
    		if("ADMIN".equals(loginUser.getRoleCode())) {
    			
    			return "성공적으로 로그인이 되었습니다.";
    			
    		} else {
    			
    			return "관리자가 아니기 때문에 로그인할 수 없습니다.";
    		}
    	} else {
			
			return "아이디 또는 비밀번호를 잘못 입력했습니다.";
    	}
    }
    
    @GetMapping("/logout")
    public String adminLogout(HttpSession session) { // 관리자 페이지 로그아웃해주는 메소드
    	
    	session.removeAttribute("loginUser");
    	
    	return "admin/adminLogin";
    }
    
    @GetMapping("/findIdForm")
    public String adminFindIdForm() { // 관리자 전용 아디디 찾기 페이지를 불러오는 메소드
    	
    	return "admin/adminFindId";
    }
    
    @GetMapping("/extraPasswordForm")
    public String adminFindPasswordForm() { // 관리자 전용 임시 비밀번호 발급 페이지를 불러오는 메소드
    	
    	return "admin/adminExtraPassword";
    }
    
    @ResponseBody
    @PostMapping("/findId")
    public String adminFindId(Member m) { // 관리자 아이디 알려주는 메소드
    	
    	m.setUserName(XssDefencePolicy.defence(m.getUserName()));
    	m.setEmail(XssDefencePolicy.defence(m.getEmail()));
    	
    	Member findId = ms.searchId(m);
    	
    	if(findId != null) {
    		
    		if("ADMIN".equals(findId.getRoleCode())) {
    			
    			return m.getUserName() + "님의 아이디는 " + findId.getUserId() + "입니다.";
    			
    		} else {
    			
    			return "일반 회원의 정보입니다. 관리자의 정보를 입력해주세요.";
    		}
    	} else {
			
			return "등록 되지 않은 회원입니다.";
    	}
    }
   
    @ResponseBody
    @PostMapping("/extraPassword")
    public String adminFindPassword(Member m) { // 관리자 임시 비밀번호를 이메일로 발급해주는 기능 
    	
    	m.setUserId(XssDefencePolicy.defence(m.getUserId()));
    	m.setUserName(XssDefencePolicy.defence(m.getUserName()));
    	m.setEmail(XssDefencePolicy.defence(m.getEmail()));
    	
    	Member extra = ms.searchPassword(m);
    	
    	if(extra != null) {
    		
    		if("ADMIN".equals(extra.getRoleCode())) {
    			
    			int random = (int)(Math.random() * 90000000 + 10000000);
    			
    			String encPwd = bCryptPasswordEncoder.encode(String.valueOf(random));
    			extra.setUserPwd(encPwd);
    			int result = ms.updateMember(extra);
    			
    			if(result > 0) {
    				SimpleMailMessage message = new SimpleMailMessage();
        			
        			// 메세지 정보 담기 : 제목, 내용, 받는사람
        			message.setSubject("know-how academy 임시 비밀번호입니다.");
        			message.setText("임시 비밀번호 : " + random + "\n임시 비밀번호로 로그인 후 비밀번호 변경을 권장드립니다.");
        			message.setTo(m.getEmail());
        			
        			mailSender.send(message);
        			
        			return m.getUserName() + "님의 이메일에 임시 비밀번호를 보냈습니다.\n로그인 후 비밀번호 변경을 권장드립니다.";
    			} else {
    				return "임시 비밀번호를 보내지 못했습니다.";
    			}
    			
    		} else {
    			
    			return "일반 회원의 정보입니다. 관리자의 정보를 입력해주세요.";
    		}
    	} else {
			
			return "등록 되지 않은 회원입니다.";
    	}
    }
    
    @GetMapping("/memberLocked")
    public String selectLockingMemberList(Model model) { // 계정이 잠긴 유저 리스트를 불러오는 메소드
    	
    	ArrayList<MemberLock> list = as2.selectLockingMemberList();
    	model.addAttribute("list", list)
    		 .addAttribute("page", "memberUnlock");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/memberUnlock")
    public String updateMemberUnlock(int userNo) { // 계정을 잠금해제할 수 있는 메소드
    	 	
    	return (as2.updateMemberUnlock(userNo) > 0) ? "success" : "fail";
    }
   
}//컨트롤러 끝

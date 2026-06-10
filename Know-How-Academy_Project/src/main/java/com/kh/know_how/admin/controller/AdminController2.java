package com.kh.know_how.admin.controller;

import java.io.File;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.admin.model.dto.MemoDto;
import com.kh.know_how.admin.model.dto.StudentDto;
import com.kh.know_how.admin.model.service.AdminService2;
import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.FileRenamePolicy;
import com.kh.know_how.common.template.Pagination;
import com.kh.know_how.common.template.XssDefencePolicy;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController2 {
	
	//필드부
	@Autowired
	AdminService2 as2;
	
	@Autowired
	BoardService bs;
	
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
    public String selectStudentDetails(@PathVariable int studentNo, Model model) {
    	StudentDto s = as2.selectStudent(studentNo);
    	model.addAttribute("s", s);
    	model.addAttribute("page", "studentDetails");
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/student/minsert")
    public String insertStudentMemo(MemoDto m) {
    	
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
    public String deleteStudentMemo(int memoNo) {
    	
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
    
    @ResponseBody
    @PostMapping("/notice/visible")
    public String updateNoticeStatus(Board b) {
    	
    	int result = as2.adminUpdateStatus(b);
    	
    	return (result > 0) ? "success" : "fail";
    }
    
    @ResponseBody
    @PostMapping("/notice/delete")
    public String deleteNotice(int postNo, HttpSession session) {

    	FileAttachment fa = bs.selectFileAttachment(postNo);
    	
    	int result2 = 1;
    	
    	if(fa != null) {
			
			String savePath = session.getServletContext().getRealPath("/resources/upload/notice/");
			
			new File(savePath + fa.getSaveName()).delete();
    		
    		result2 =  bs.deleteFileAttachment(postNo);
			
		}
    	int result1 = bs.deleteBoard(postNo);
    	
    	return ((result1 * result2) > 0) ? "success" : "fail";
    }
    
    @GetMapping("/notice/enrollForm")
    public String noticeEnrollForm(Model model) {
    	
    	model.addAttribute("page", "adminNoticeEnrollForm");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/notice/insert")
    public String insertNotice(Board n, MultipartFile upfile, HttpSession session) {
    	
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
    	n.setCategory("NOTICE");
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
    public String selectNoticeDetail(@PathVariable int postNo, Model model) {
    	Board n = bs.selectBoard(postNo);
    	
    	FileAttachment fa = bs.selectFileAttachment(postNo);
    	model.addAttribute("n", n)
    		 .addAttribute("fa", fa)
    	     .addAttribute("page", "adminNoticeDetail");
    	return "admin/adminLayout";
    }
    
    @PostMapping("/notice/updateForm")
    public String noticeUpdateForm(int postNo, Model model) {
    	
    	Board n = bs.selectBoard(postNo);
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
    						   Model model) {
    	
    	FileAttachment fa = null;
    	
    	if(!reUpfile.getOriginalFilename().equals("")) {
    		
    		String saveName = FileRenamePolicy.saveFile(reUpfile, session, "/resources/upload/notice/");	
    		
    		fa = new FileAttachment();
    		fa.setTargetType("NOTICE");
    		fa.setOriginName(reUpfile.getOriginalFilename());
    		fa.setSaveName(saveName);
    		
    		if(originalFileNo != 0 ) {
    			
    			fa.setFileNo(originalFileNo);
    			
    			String savePath = session.getServletContext()
    									 .getRealPath("/resources/upload/notice/");
    			new File(savePath + originalFileSaveName).delete();
    			
    		} else {
    			
    			fa.setTargetNo(n.getPostNo());
    			fa.setFilePath("/resources/upload/notice/");
    			
    		}
    		
    	}
    	
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	
    	int result = bs.updateBoard(n, fa);
    	
    	return (result > 0) ? "success" : "fail";
    	
    }
    
    @GetMapping("/academyNews")
    public ModelAndView selectNewsList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
    	
    	int listCount = as2.adminSelectNewsListCount();
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSelectNewsList(pi);
    	
    	mv.addObject("list", list)
    	  .addObject("pi", pi)
    	  .addObject("page", "academyNewsList")
    	  .setViewName("admin/adminLayout");
    	
    	return mv;
    }
    
    @GetMapping("/academyNews/search")
    public String searchNewsList(String keyword, @RequestParam(value="cpage", defaultValue="1") int currentPage, Model model) {
    	
    	keyword = XssDefencePolicy.defence(keyword);
    	int listCount = as2.adminSearchNewsCount(keyword);
    	int pageLimit = 10;
    	int boardLimit = 10;
    	
    	PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
    	
    	ArrayList<Board> list = as2.adminSearchNewsList(pi, keyword);
    	
    	model.addAttribute("list", list)
    	     .addAttribute("pi", pi)
    	     .addAttribute("keyword", keyword)
       	     .addAttribute("page", "academyNewsList");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/academyNews/visible")
    public String updateNewsStatus(Board b) {
    	
    	int result = as2.adminUpdateStatus(b);
    	
    	return (result > 0) ? "success" : "fail";
    }
    
    @ResponseBody
    @PostMapping("/academyNews/delete")
    public String deleteNews(int postNo, HttpSession session) {

    	ArrayList<FileAttachment> list = bs.selectFileAttachmentList(postNo);
    	
    	int result2 = 1;
    	
    	if(list != null) {
    		
    		String savePath = session.getServletContext().getRealPath("/resources/upload/news/");
    		
    		for(FileAttachment fa : list) {

    			new File(savePath + fa.getSaveName()).delete();
            }
    		
			result2 =  bs.deleteFileAttachment(postNo);
		}
    	int result1 = bs.deleteBoard(postNo);
    	
    	return ((result1 * result2) > 0) ? "success" : "fail";
    }
    
    @GetMapping("/academyNews/enrollForm")
    public String newsEnrollForm(Model model) {
    	
    	model.addAttribute("page", "academyNewsEnrollForm");
    	
    	return "admin/adminLayout";
    }
    
    @ResponseBody
    @PostMapping("/academyNews/insert")
    public String insertNews(Board n, MultipartFile[] files, HttpSession session) {
    	
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
    	n.setCategory("NEWS");
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	
    	int result = as2.insertNews(n, list);
    	
    	return (result > 0) ? "success" : "fail";
     }
    
    @GetMapping("academyNews/detail/{postNo}")
	public String selectNewsDetail(@PathVariable int postNo, Model model) {
		Board n = bs.selectBoard(postNo);
		
		ArrayList<FileAttachment> list = bs.selectFileAttachmentList(postNo);

		model.addAttribute("n", n)
		     .addAttribute("list", list)
		     .addAttribute("page", "academyNewsDetail");
		
		return "admin/adminLayout";
	}
    
    @PostMapping("/academyNews/updateForm")
    public String NewsUpdateForm(int postNo, Model model) {
    	
    	Board n = bs.selectBoard(postNo);
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
    						 Model model) {
    	
    	if (deleteSaveName != null) {
            String savePath = session.getServletContext().getRealPath("/resources/upload/news/");
            for (String saveName : deleteSaveName) {
            	new File(savePath + saveName).delete();
            }
        }

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
        			String originalFileSaveName = paramMap.get("originalFileSaveName" + (i + 1));
        			
	        		if(originalFileNo != null && !originalFileNo.equals("0") && !originalFileNo.isEmpty()) {
	        			
	        			int fileNo = Integer.parseInt(originalFileNo);
	        			fa.setFileNo(fileNo);
	        			
	        			String savePath = session.getServletContext().getRealPath("/resources/upload/news/");
	        			if(originalFileSaveName != null && !originalFileSaveName.isEmpty()) {
	        				File deleteFile = new File(savePath + originalFileSaveName);
	        				if (deleteFile.exists()) {
	        					deleteFile.delete();
	        				}
	        			}
	        						
	        		}
	        		
	        		list.add(fa);
	        	}
	    	}
    	}
    	
    	n.setTitle(XssDefencePolicy.defence(n.getTitle()));
    	n.setContent(XssDefencePolicy.defence(n.getContent()));
    	
    	int result = as2.updateNews(n, list, deleteFileNo);
    	
    	return (result > 0) ? "success" : "fail";
    	
    }
    
}//컨트롤러 끝

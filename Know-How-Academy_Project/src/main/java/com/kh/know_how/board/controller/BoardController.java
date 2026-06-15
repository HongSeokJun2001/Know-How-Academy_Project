package com.kh.know_how.board.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale.Category;
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

import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.board.model.vo.FileAttachment;
import com.kh.know_how.board.model.vo.PostComment;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.FileRenamePolicy;
import com.kh.know_how.common.template.Pagination;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("community/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	/**
	 * 공지, 자유, 수강생 통합 메서드
	 * 
	 * @param type        게시판 유형을 담아줄 데이터
	 * @param currentPage
	 * @param mv
	 * @return
	 */
	@GetMapping("{type:notice|post|student}")
	public ModelAndView selectBoardList(@PathVariable String type,
										@RequestParam(value = "cpage", defaultValue = "1") int currentPage, 
										ModelAndView mv) {

		String postType;
		String viewName;

		// 요청으로 들어온 게시판타입과 링크 대조
		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeListView";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentListView";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postListView";
			break;
		}
		
		int listCount = boardService.selectListCount(postType);
		// 특정 게시글조회를 위한 매개변수 지정
		
		int pageLimit;
		int boardLimit;
		int maxPage;
		int startPage;
		int endPage;		
		

		pageLimit = 10;
		boardLimit = 10;
	
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<Board> list = boardService.selectBoardList(pi, postType);

		mv.addObject("list", list);
		mv.addObject("pi", pi);

		mv.setViewName(viewName);// 위 설정된 페이지

		return mv;
	}

	/**
	 * 2. 검색 기능
	 * 
	 * @param type
	 * @param condition1
	 * @param keyword
	 * @param currentPage
	 * @param mv
	 * @return
	 */
	@GetMapping("{type:notice|post|student}/search")
	public ModelAndView searchBoardList(@PathVariable String type, 
										@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
										String condition1, 
										String condition2,
										String keyword, 
										ModelAndView mv) {

		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeListView";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentListView";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postListView";
			break;
		}
		
		HashMap<String, String> map = new HashMap<>();
		map.put("condition1", condition1);
		map.put("condition2", condition2);
		map.put("keyword", keyword);
		map.put("postType", postType);

		// 검색 결과에 따른 페이징 처리가 필요하다면 여기서 로직을 추가하세요.
		// 현재는 서비스 호출 예시만 작성했습니다.
		int searchCount = boardService.selectSearchCount(map);
		
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, 
											pageLimit, boardLimit);
		
		ArrayList<Board> list = boardService.searchBoardList(map, pi, postType);
		
		mv.addObject("list", list)
		.addObject("pi", pi)
		.addObject("condition1", condition1)
		.addObject("condition2", condition2)
		.addObject("keyword", keyword)
		.addObject("postType", type)
		.setViewName(viewName);

		return mv;
	}

	/**
	 * 3. 게시글 상세 조회
	 * 
	 * @param type
	 * @param postNo
	 * @param model
	 * @param session
	 * @return
	 */
	@GetMapping("{type:notice|post|student}/detail/{postNo}")
	public String selectBoard(@PathVariable String type, @PathVariable int postNo, Model model, HttpSession session) {

		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeDetailView";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentDetailView";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postDetailView";
		}

		int result = boardService.increaseCount(postNo);

		if (result > 0) {

			Board b = boardService.selectBoard(postNo);

			FileAttachment fa = boardService.selectFileAttachment(postNo);

			model.addAttribute("b", b);
			model.addAttribute("type", type);
			model.addAttribute("fa", fa);
			return viewName;
		} else {
			return "common/errorPage";
		}
	}

	/**
	 * 4. 게시글 작성폼으로 이동
	 * 
	 * @param type
	 * @param model
	 * @return
	 */
	@GetMapping("{type:notice|post|student}/enrollForm")
	public String enrollForm(@PathVariable String type, Model model) {

		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeEnrollForm";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentEnrollForm";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postEnrollForm";
		}

		ArrayList<Category> list = boardService.selectCategoryList();

		model.addAttribute("list", list);
		model.addAttribute("postType", postType);
		model.addAttribute("type", type);

		return viewName;
	}

	/**
	 * 게시글 등록
	 * 
	 * @param b            Board VO
	 * @param session      로그인정보와 결과에 대한 메시지 정보
	 * @param model        브라우저에 데이터 전달을 도와줄 객체
	 * @param originalFile 첨부파일
	 * @return
	 */
	@PostMapping("/{type}/insert")
	public String insertBoard(@PathVariable String type, Board b, HttpSession session, Model model,
			MultipartFile originalFile) {

		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			break;
		case "student":
			postType = "STUDENT";
			break;
		case "post":
		default:
			postType = "POST";
			break;
		}

		FileAttachment fa = null;

		if (originalFile != null && !originalFile.isEmpty()) {

			String saveName = FileRenamePolicy.saveFile(originalFile, session, "/resources/board_upfiles/");

			fa = new FileAttachment();
			fa.setOriginName(originalFile.getOriginalFilename());
			fa.setSaveName(saveName);
			fa.setTargetType(postType);
			fa.setFilePath("resources/board_upfiles/");

		}

		b.setPostType(postType);

		int result = boardService.insertBoard(b, fa);

		if (result > 0) {
			session.setAttribute("alertMsg", "게시글 등록 성공");
			return "redirect:/community/board/" + type;
			// '/viewName' 말그대로의 주소가 되기때문직접 이번엔 설정
		} else {
			model.addAttribute("alertMsg", "게시글 등록 실패");
			return "common/errorPage";
		}
	}

	/**
	 * 수정하기 페이지
	 * 
	 * @param type   게시글
	 * @param postNo 번호
	 * @param mv
	 * @return
	 */

	@PostMapping("/{type}/updateForm")
	public ModelAndView updateForm(@PathVariable String type, @RequestParam("postNo") int postNo, 
									ModelAndView mv) {

		ArrayList<Category> list = boardService.selectCategoryList();

		Board b = boardService.selectBoard(postNo);

		FileAttachment fa = boardService.selectFileAttachment(postNo);
		
		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeUpdateForm";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentUpdateForm";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postUpdateForm";
		}

		mv.addObject("b", b)
		.addObject("fa", fa)
		.addObject("list", list)
		.addObject("type", type)
		.setViewName(viewName);

		return mv;
	}

	/**
	 * 게시글 및 첨푸파일 등록 요청
	 * 
	 * @param type
	 * @param originalFileNo
	 * @param b
	 * @param originalFile
	 * @param originalFileSaveName
	 * @param session
	 * @param model
	 * @return
	 */
	@PostMapping("/{type}/update")
	public String updateBoard(@PathVariable String type, @RequestParam(defaultValue = "0") int originalFileNo, Board b,
			MultipartFile originalFile, String originalFileSaveName, HttpSession session, Model model) {

		FileAttachment fa = null;

	    String postType;
	    String viewName;

	    switch (type) {
	    case "notice":
	        postType = "NOTICE";
	        viewName = "community/board/noticeUpdate";
	        break;
	    case "student":
	        postType = "STUDENT";
	        viewName = "community/board/studentUpdate";
	        break;
	    case "post":
	    default:
	        postType = "POST";
	        viewName = "community/board/postUpdate";
	    }

	    if (!originalFile.getOriginalFilename().equals("")) {

	        String saveName = FileRenamePolicy.saveFile(originalFile, session, "/resources/board_upfiles/");

	        fa = new FileAttachment();
	        fa.setOriginName(originalFile.getOriginalFilename());
	        fa.setSaveName(saveName);
	        fa.setTargetType(b.getPostType());
	        fa.setTargetNo(b.getPostNo()); 
	        fa.setFilePath("/resources/board_upfiles/");

	        if (originalFileNo != 0) {
	            fa.setFileNo(originalFileNo);
	            String savePath = session.getServletContext().getRealPath("/resources/board_upfiles/");
	            new File(savePath + originalFileSaveName).delete();
	        } 
	        
	    } 

	    b.setPostType(postType);
	    model.addAttribute("type", type);

	    int result = boardService.updateBoard(b, fa);

	    if (result > 0) {
	        session.setAttribute("alertMsg", "게시글 수정 성공");
	        return "redirect:/community/board/" + type + "/detail/" + b.getPostNo();
	    } else {
	        model.addAttribute("errorMsg", "게시글 수정 실패");
	        return "common/errorPage";
	    }

	}

	@PostMapping("/{type}/deleteForm")
	public String deleteBoard(@PathVariable String type, @RequestParam("postNo") int postNo, Model model,
			HttpSession session) {

		int result = boardService.deleteBoard(postNo);

		String postType;
		String viewName;

		switch (type) {
		case "notice":
			postType = "NOTICE";
			viewName = "community/board/noticeDelete";
			break;
		case "student":
			postType = "STUDENT";
			viewName = "community/board/studentDelete";
			break;
		case "post":
		default:
			postType = "POST";
			viewName = "community/board/postDelete";
		}

		if (result > 0) {

			session.setAttribute("alertMsg", "삭제 성공");

			return "redirect:/community/board/" + type;

		} else {

			model.addAttribute("errorMsg", "삭제 실패");

			return "common/errorPage";
		}
	}
	
	@ResponseBody
	@GetMapping("pclist")
	public ArrayList<PostComment> ajaxSelectCommentList(int postNo){
		
		ArrayList<PostComment> list = boardService.selectCommentList(postNo);			
	
		return list;
	}
	
	@ResponseBody
	@PostMapping("pcinsert")
	public String ajaxInsertComment(PostComment pc, HttpSession session) {
		
		int writerNo = ((Member)(session.getAttribute("loginUser"))).getUserNo();
		
		//PostComment VO 에서 String으로 변경
		pc.setWriterNo(writerNo + "");
		
		int result = boardService.insertComment(pc);
		
		return (result > 0 ) ? "success" : "fail";
		
	}	
	
	@ResponseBody
	@GetMapping("/main")
	public ArrayList<Board> mainNoticeList() { // 메인페이지에 나오는 공지사항 리스트를 불러오는 메소드
		
		return boardService.mainNoticeList("NOTICE");
		
	}

	@ResponseBody
	@GetMapping("news/list")
	public Map<String, Object> selectNewsList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage) {
		int listCount = boardService.selectListCount("NEWS");
		int boardLimit = 4;
		int pageLimit = 1;

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<Board> list = boardService.selectNewsList(pi);

		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		return map;
	}

	/**
	 * 학원 소식 상세조회페이지
	 * 
	 * @return
	 */
	@GetMapping("news/detail/{postNo}")
	public ModelAndView academyNews(@PathVariable int postNo, ModelAndView mv) {
		Board b = boardService.selectBoard(postNo);

		ArrayList<FileAttachment> list = boardService.selectFileAttachmentList(postNo);

		mv.addObject("b", b).addObject("list", list).setViewName("common/academyNews");

		return mv;
	}

}

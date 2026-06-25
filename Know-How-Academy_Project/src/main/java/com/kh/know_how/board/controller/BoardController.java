package com.kh.know_how.board.controller;

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

	// @PostMapping 서버(DB)에 데이터를 생성, 변경, 삭제할 때
	// 예)글작성, 이미지 등록, 삭제
	// @GetMapping 서버(DB)에 데이터를 조회 할 때
	// 예)여러 글 목록, 글 작성 페이지, 키워드검색

	/**
	 * 
	 * @param type
	 * @param currentPage
	 * @param viewType    list 인지 album인지 걸러줌
	 * @param mv
	 * @return
	 */
	@GetMapping("{type:notice|post|student}")
	// Controlle에서 정한 type : ~~~ 으로 브라우저요청을 받는다.
	// .jsp에서 a href 링크와 연결되기위한 type
	public ModelAndView selectBoardList(@PathVariable String type,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			@RequestParam(value = "viewType", defaultValue = "list") String viewType, ModelAndView mv) {
		// public ModelAndView selectBoardList
		// (접근제어자) (반환타입) (임의로 정한 메서드명)
		// ModelAndView
		// Model ==

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

		// 변수선언
		int pageLimit;
		int boardLimit;
		int maxPage;
		int startPage;
		int endPage;

		pageLimit = 10;

		// 게시글 목록 형태에 따른 페이징바 적용
		// 삼항연산자 사용 viewType == album일 경우 참(9)
		boardLimit = "album".equalsIgnoreCase(viewType) ? 9 : 10;

		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<Board> list = boardService.selectBoardList(pi, postType);

		mv.addObject("list", list);
		mv.addObject("pi", pi);
		mv.addObject("viewType", viewType);
		mv.setViewName(viewName);// 위 설정된 페이지

		return mv;
	}

	@ResponseBody
	@GetMapping("/ajaxList")
	public Map<String, Object> ajaxSelectBoardList(
			@RequestParam(value = "type", defaultValue = "post") String type,
			@RequestParam(value = "startDate", required = false) String startDate,
			@RequestParam(value = "endDate", required = false) String endDate,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			//뷰타입을 받아 페이징바내용을 설정합니다.
			@RequestParam(value = "viewType", defaultValue = "list") String viewType,
			// 동기식과 비동기식의 충돌로 searchBoardList와 합치기
			// 검색을 이요하지않을땐 null값
			@RequestParam(value = "condition1", required = false) String condition1,
			@RequestParam(value = "condition2", required = false) String condition2,
			@RequestParam(value = "keyword", required = false) String keyword) {

		// 요청온 게시판 타입이 다음과 같을때
		String postType = type.equalsIgnoreCase("notice") ? "NOTICE"
						: type.equalsIgnoreCase("student") ? "STUDENT" 
															: "POST";
		//앨범형이면 9개, 그외엔 10개
		int boardLimit = "album".equalsIgnoreCase(viewType) ? 9 : 10;
		int pageLimit = 10;
		
		Map<String, Object>map = new HashMap<>();

		//참 또는 거짓만 담는 boolean으로 시작
		boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
		//입력된 검색어 판별 문자(한글,숫자,특문)일시 참 공백("  ") 일시 거짓으로 판별하는 코드
		
	    boolean hasDateFilter = startDate != null && !startDate.trim().isEmpty();
	    //입력된 시작일자가 존재할 시 참, 없을 경우 거짓	    
	    
	    boolean hasCategoryFilter 
	    		= condition2 != null && !condition2.trim().isEmpty() && !"all".equalsIgnoreCase(condition2);
	    	
	    if (hasKeyword || hasDateFilter || hasCategoryFilter) {
	    	//1.위에서 구한 값을 통해  
	    	//참 	   || 거짓
	    	//참		   || 참
	    	//거짓	   || 참 일시 
	    	//검색조건 실행	
	    	
	    	//2.거짓 	   || 거짓 일경우
	    	//전체조회 실행
		
			HashMap<String, String> searchmap = new HashMap<>();
			searchmap.put("condition1", condition1);
			searchmap.put("condition2", condition2);
			searchmap.put("keyword", keyword);
			
			searchmap.put("startDate", startDate);
			searchmap.put("endDate", endDate);
			
			searchmap.put("postType", postType);

			int searchCount = boardService.selectSearchCount(searchmap);
			PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit, boardLimit);

			map.put("list", boardService.searchBoardList(searchmap, pi, postType));
			map.put("pi", pi);
			
		
		} else {
			// 검색어 미입력시
			int listCount = boardService.selectListCount(postType);
			PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
			
			map.put("list", boardService.selectBoardList(pi, postType));
			map.put("pi", pi);

			
		}
		return map;//json 형태로 반환
	}

	/*
	 * @GetMapping("{type:notice|post|student}/search") public ModelAndView
	 * searchBoardList(@PathVariable String type,
	 * 
	 * @RequestParam(value = "cpage", defaultValue = "1") int currentPage, String
	 * condition1, String condition2, String keyword, ModelAndView mv) {
	 * 
	 * String postType; String viewName;
	 * 
	 * switch (type) { case "notice": postType = "NOTICE"; viewName =
	 * "community/board/noticeListView"; break; case "student": postType =
	 * "STUDENT"; viewName = "community/board/studentListView"; break; case "post":
	 * default: postType = "POST"; viewName = "community/board/postListView"; break;
	 * }
	 * 
	 * HashMap<String, String> map = new HashMap<>(); map.put("condition1",
	 * condition1); map.put("condition2", condition2); map.put("keyword", keyword);
	 * map.put("postType", postType);
	 * 
	 * // 검색 결과에 따른 페이징 처리가 필요하다면 여기서 로직을 추가하세요. // 현재는 서비스 호출 예시만 작성했습니다. int
	 * searchCount = boardService.selectSearchCount(map);
	 * 
	 * int pageLimit = 10; int boardLimit = 10;
	 * 
	 * PageInfo pi = Pagination.getPageInfo(searchCount, currentPage, pageLimit,
	 * boardLimit);
	 * 
	 * ArrayList<Board> list = boardService.searchBoardList(map, pi, postType);
	 * 
	 * mv.addObject("list", list).addObject("pi", pi).addObject("condition1",
	 * condition1) .addObject("condition2", condition2).addObject("keyword",
	 * keyword).addObject("postType", type) .setViewName(viewName);
	 * 
	 * return mv; }
	 */

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
	public String selectBoard(@PathVariable String type, @PathVariable int postNo, String condition1, String condition2,
			Model model, HttpSession session) {

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
			model.addAttribute("condition1", condition1);
			model.addAttribute("condition2", condition2);
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

		ArrayList<Board> list = boardService.selectCategoryList();

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
		System.out.println("컨트롤러 진입 직후 카테고리: " + b.getCategory());

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

			String saveName = FileRenamePolicy.saveFile(originalFile, session, "resources/board_upfiles/");

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
	public ModelAndView updateForm(@PathVariable String type, @RequestParam("postNo") int postNo, ModelAndView mv) {

		ArrayList<Board> list = boardService.selectCategoryList();

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

		mv.addObject("b", b).addObject("fa", fa).addObject("list", list).addObject("type", type).setViewName(viewName);

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

			String saveName = FileRenamePolicy.saveFile(originalFile, session, "resources/board_upfiles/");

			fa = new FileAttachment();
			fa.setOriginName(originalFile.getOriginalFilename());
			fa.setSaveName(saveName);
			fa.setTargetType(b.getPostType());
			fa.setTargetNo(b.getPostNo());
			fa.setFilePath("resources/board_upfiles/");

			if (originalFileNo != 0) {
				fa.setFileNo(originalFileNo);
				String savePath = session.getServletContext().getRealPath("resources/board_upfiles/");
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
	public ArrayList<PostComment> ajaxSelectCommentList(int postNo) {

		ArrayList<PostComment> list = boardService.selectCommentList(postNo);

		return list;
	}

	@ResponseBody
	@PostMapping("pcinsert")
	public String ajaxInsertComment(PostComment pc, HttpSession session) {

		int writerNo = ((Member) (session.getAttribute("loginUser"))).getUserNo();

		// PostComment VO 에서 String으로 변경
		pc.setWriterNo(writerNo + "");

		int result = boardService.insertComment(pc);

		return (result > 0) ? "success" : "fail";

	}

	@ResponseBody
	@PostMapping("pcdelete")
	public String ajaxDeleteComment(@RequestParam("commentNo") int commentNo, HttpSession session) {

		int result = boardService.deleteComment(commentNo);

		return (result > 0) ? "success" : "fail";

	}

	@ResponseBody
	@GetMapping("news/list")
	public Map<String, Object> selectNewsList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage) {
		int listCount = boardService.selectNewsListCount();
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
		Board b = boardService.selectNews(postNo);

		ArrayList<FileAttachment> list = boardService.selectFileAttachmentList(postNo);

		mv.addObject("b", b).addObject("list", list).setViewName("common/academyNews");

		return mv;
	}

}

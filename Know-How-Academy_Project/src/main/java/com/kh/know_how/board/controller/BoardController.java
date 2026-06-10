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
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.FileRenamePolicy;
import com.kh.know_how.common.template.Pagination;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("community/board")
public class BoardController {

	@Autowired
	private BoardService boardService;

	// 1. 일반 게시글 리스트 조회
	@GetMapping("list")
	public ModelAndView selectBoardList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage,
			ModelAndView mv) {

		String postType ="POST";
		int listCount = boardService.selectListCount();
		int pageLimit = 10;
		int boardLimit = 10;
		
		PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
		ArrayList<Board> list = boardService.selectBoardList(pi, postType);

		mv.addObject("list", list);
		mv.addObject("pi", pi);
		mv.setViewName("community/board/boardListView");

		return mv;
	}

	// 2. 검색 기능
	@GetMapping("search")
	public ModelAndView searchBoardList(String condition1, String condition2, String keyword,
			@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv) {

		HashMap<String, String> map = new HashMap<>();
		map.put("condition1", condition1);
		map.put("condition2", condition2);
		map.put("keyword", keyword);

		// 검색 결과에 따른 페이징 처리가 필요하다면 여기서 로직을 추가하세요.
		// 현재는 서비스 호출 예시만 작성했습니다.
		int searchCount = boardService.selectSearchCount(map);

		return mv;
	}

	// 3. 게시글 상세 조회
	@GetMapping("detail/{postNo}")
	public String selectBoard(@PathVariable int postNo, Model model, HttpSession session) {

		int result = boardService.increaseCount(postNo);

		if (result > 0) {

			Board b = boardService.selectBoard(postNo);
			FileAttachment fa = boardService.selectAttachment(postNo);

			model.addAttribute("b", b);
			model.addAttribute("fa", fa);

			return "community/board/boardDetailView";
		} else {
			return "common/errorPage";
		}
	}

	// 4. 게시글 작성 폼 이동
	@GetMapping("enrollForm")
	public String enrollForm(Model model) {

		ArrayList<Category> list = boardService.selectCategoryList();

		model.addAttribute("list", list);

		return "community/board/boardEnrollForm";
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
	@PostMapping("insert")
	public String insertBoard(Board b, HttpSession session, Model model, MultipartFile originalFile) {
		
		FileAttachment fa = null;

		if (originalFile != null && !originalFile.isEmpty()) {

			String saveName = FileRenamePolicy.saveFile(originalFile, session, "/resources/board_upfiles/");

			fa = new FileAttachment();
			fa.setOriginName(originalFile.getOriginalFilename());
			fa.setSaveName(saveName);
			fa.setFilePath("resources/board_upfiles/");

		}

		int result = boardService.insertBoard(b, fa);

		if (result > 0) {
			session.setAttribute("alertMsg", "게시글 등록 성공");
			return "redirect:/community/board/list";
		} else {
			model.addAttribute("alertMsg", "게시글 등록 실패");
			return "common/errorPage";
		}
	}

	@PostMapping("updateForm")
	public ModelAndView updateForm(@RequestParam("postNo") int postNo, ModelAndView mv) {

		ArrayList<Category> list = boardService.selectCategoryList();

		Board b = boardService.selectBoard(postNo);

		FileAttachment fa = boardService.selectAttachment(postNo);

		mv.addObject("b", b).
		addObject("list", list).
		addObject("fa", fa).
		setViewName("community/board/boardUpdateForm");

		return mv;
	}

	@PostMapping("update")
	public String updateBoard(@RequestParam(defaultValue = "0") int originalFileNo, Board b, MultipartFile originalFile,
			String originalFileSaveName, HttpSession session, Model model) {
		
		FileAttachment fa = null;
	
		if (!originalFile.getOriginalFilename().equals("")) {

			String saveName = FileRenamePolicy.saveFile(originalFile, session, "/resources/board_upfiles/");

			fa = new FileAttachment();
			fa.setOriginName(originalFile.getOriginalFilename());
			fa.setSaveName(saveName);	
			fa.setTargetType(b.getPostType());

			if (originalFileNo != 0) {

				fa.setFileNo(originalFileNo);

				String savePath = session.getServletContext().getRealPath("/resources/board_upfiles/");
				new File(savePath + originalFileSaveName).delete();
			} else {

				fa.setTargetNo(b.getPostNo());
				fa.setFilePath("/resources/board_upfiles/");
			}
		}

		int result = boardService.updateBoard(b, fa);

		if (result > 0) {

			session.setAttribute("alertMsg", "게시글  수정 성공");

			return "redirect:/community/board/detail/" + b.getPostNo();
		} else {

			model.addAttribute("errorMsg", "게시글수정 실패");
			return "common/errorPage";
		}

	}
	
	@PostMapping("deleteForm")
	public String deleteBoard(@RequestParam("postNo") int postNo,
							Model model, HttpSession session) {
			
		int result = boardService.deleteBoard(postNo);
		
		if(result > 0) {
			
			session.setAttribute("alertMsg", "삭제 성공");
			
			return "redirect:/community/board/list";
			
		}else {
			
			model.addAttribute("errorMsg", "삭제 실패");
			
			return "common/errorPage";
		}
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

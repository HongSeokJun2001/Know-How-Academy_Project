package com.kh.know_how.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.know_how.board.model.service.BoardService;
import com.kh.know_how.board.model.vo.Board;
import com.kh.know_how.common.model.vo.PageInfo;
import com.kh.know_how.common.template.Pagination;
import com.kh.know_how.member.model.vo.Member;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/board")
public class BoardController {

    @Autowired
    private BoardService boardService;

    // 1. 일반 게시글 리스트 조회
    @GetMapping("/list")
    public ModelAndView selectBoardList(@RequestParam(value = "cpage", defaultValue = "1") int currentPage, ModelAndView mv) {
        
        int listCount = boardService.selectListCount();
        int pageLimit = 10;
        int boardLimit = 10;
        
        PageInfo pi = Pagination.getPageInfo(listCount, currentPage, pageLimit, boardLimit);
        ArrayList<Board> list = boardService.selectBoardList(pi);
        
        mv.addObject("list", list);
        mv.addObject("pi", pi);
        mv.setViewName("board/boardListView");
        
        return mv;
    }

    // 2. 검색 기능
    @GetMapping("/search")
    public ModelAndView searchBoardList(String condition1, String condition2, String keyword,
                                        @RequestParam(value = "cpage", defaultValue = "1") int currentPage,
                                        ModelAndView mv) {

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
    @GetMapping("detail/{boardNo}")
    public String selectBoard(@PathVariable int boardNo, Model model) {
        
        int result = boardService.increaseCount(boardNo);
        
        if (result > 0) {
            Board b = boardService.selectBoard(boardNo);
            model.addAttribute("b", b);
            return "board/boardDetailView";
        } else {
            return "common/errorPage";
        }
    }

    // 4. 게시글 작성 폼 이동
    @GetMapping("enrollForm")
    public String enrollForm() {
        return "board/boardEnrollForm";
    }

    // 5. 게시글 등록 처리
    @GetMapping("insert") // 주소 매핑이 누락되어 있어 임의로 추가했습니다.
    public String insertBoard(Board b, HttpSession session, Model model) {
        
        Member loginUser = (Member) session.getAttribute("loginUser");
        b.setWriterNo(loginUser.getUserNo());
        
        int result = boardService.inserBoard(b);

        if (result > 0) {
            session.setAttribute("alertMsg", "게시글 등록 성공");
            return "redirect:/board/list";
        } else {
            model.addAttribute("alertMsg", "게시글 등록 실패");
            return "common/errorPage";
        }
    }
}
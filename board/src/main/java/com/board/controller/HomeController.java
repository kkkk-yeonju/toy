package com.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.common.Pagination;
import com.board.service.BoardService;
import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;
import com.board.vo.Member;

@Controller
public class HomeController {
	
	@Autowired
	@Qualifier("boardService")
	private BoardService boardService;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model, @RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "1") int range, String keyword, HttpSession session) {
		
		if(keyword == null) {
			keyword = "";
		}
		
		Member member = (Member)session.getAttribute("loginuser");
		if( member != null) {
			String id = member.getId();
			
			if(id != null) {
				Integer alarmCnt = boardService.findCountAlarmById(id);
				List<Alarm> alarms = boardService.findAlarmById(id);
				
				model.addAttribute("alarmCnt", alarmCnt);
				model.addAttribute("alarms", alarms);
			}
		}
		
		// 전체 게시글 수
		int totalCount = boardService.findBoardListCnt(keyword);
		
		// Pagination 객체 생성
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, totalCount);
		
		model.addAttribute("pagination", pagination);
		
		// 전체 게시글 리스트
		List<Board> boards = boardService.findBoardList(pagination, keyword);
		
		model.addAttribute("boards", boards);
		model.addAttribute("totalCount", totalCount);
				
		return "home";
	}
	
	@RequestMapping(value = "/board-list", method = RequestMethod.POST) // 왜 get이 아니라 post? 내용을 숨겨서 보내야해서????
	public String boardList(Model model, @RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "1") int range, String keyword) {
		// 전체 게시글 수
		int totalCount = boardService.findBoardListCnt(keyword);
		
		// Pagination 객체 생성
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, totalCount);
		
		model.addAttribute("pagination", pagination);
				
		// 전체 게시글 리스트
		List<Board> boards = boardService.findBoardList(pagination, keyword);
		
		model.addAttribute("boards", boards);
		
		return "list";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	@ResponseBody
	public String search(Model model, @RequestParam(required = false, defaultValue = "1") int page, 
			@RequestParam(required = false, defaultValue = "1") int range, String keyword) {
		
		if(keyword == null) {
			keyword = "";
		}
		
		// 전체 게시글 수
		int totalCount = boardService.findBoardListCnt(keyword);
		
		// Pagination 객체 생성
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, totalCount);
		
		model.addAttribute("pagination", pagination);
		
		// 전체 게시글 리스트
		List<Board> boards = boardService.findBoardList(pagination, keyword);
		
		model.addAttribute("boards", boards);
		model.addAttribute("totalCount", totalCount);
				
		return "success";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public String write(HttpSession session, Model model) {
		Member member = (Member)session.getAttribute("loginuser");
		if( member != null) {
			String id = member.getId();
			
			if(id != null) {
				Integer alarmCnt = boardService.findCountAlarmById(id);
				List<Alarm> alarms = boardService.findAlarmById(id);
				
				model.addAttribute("alarmCnt", alarmCnt);
				model.addAttribute("alarms", alarms);
			}
		}
				
		return "write";
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String writeForm(Board board) {
				
		boardService.registerBoardTx(board);
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/detail/{boardNo}", method = RequestMethod.GET)
	public String detail(@PathVariable int boardNo, Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("loginuser");
		if( member != null) {
			String id = member.getId();
			
			if(id != null) {
				Integer alarmCnt = boardService.findCountAlarmById(id);
				List<Alarm> alarms = boardService.findAlarmById(id);
				
				model.addAttribute("alarmCnt", alarmCnt);
				model.addAttribute("alarms", alarms);
			}
		}
		
		Board board = boardService.findBoardByBoardNo(boardNo);
		
		//댓글 보기
		List<Comment> comments = boardService.findCommentListByBoardNo(boardNo);
		
		model.addAttribute("board", board);
		model.addAttribute("comments", comments);
		
		return "detail";
	}
	
	@RequestMapping(value = "/update/{boardNo}", method = RequestMethod.GET)
	public String update(@PathVariable int boardNo, Model model) {
		
		Board board = boardService.findBoardByBoardNo(boardNo);
		
		model.addAttribute("board", board);
		
		return "update";
	}
	
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String updateForm(Board board) {
		
		boardService.updateBoard(board);
				
		return "redirect:/detail/" + board.getBoardNo();
	}
	
	@RequestMapping(value = "/delete/{boardNo}", method = RequestMethod.GET)
	public String delete(@PathVariable int boardNo) {
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/";
	}
	
	/* comment(댓글) */
	@RequestMapping(value = "/write-comment", method = RequestMethod.POST, produces = "text/plain;charset=utf-8") //응답컨텐츠의 종류 지정
	@ResponseBody //반환 값은 뷰이름이 아니고 응답컨텐츠입니다.
	public String writeComment(Comment comment) {
		
		boardService.writeComment(comment);
		
		return "success";
	}
	
	@RequestMapping(value = "/comment-list", method = RequestMethod.POST) // 왜 get이 아니라 post? 내용을 숨겨서 보내야해서????
	public String commentList(int boardNo, Model model) {
		
		List<Comment> comments = boardService.findCommentListByBoardNo(boardNo);
		
		model.addAttribute("comments", comments);
		
		return "comments";
	}
	
	@RequestMapping(value = "/delete-comment", method = RequestMethod.GET)
	@ResponseBody
	public String deleteComment(int commentNo) {
		
		boardService.deleteComment(commentNo);
		
		return "success";
	}
	
	@RequestMapping(value = "/update-comment", method = RequestMethod.POST)
	@ResponseBody
	public String updateComment(Comment comment) {
		
		boardService.updateComment(comment);
		
		return "success";
	}
	
	@RequestMapping(path = "/write-recomment", method = RequestMethod.POST, produces = "text/plain;charset=utf-8") //응답 컨텐츠의 종류 지정
	@ResponseBody //반환 값은 뷰이름이 아니고 응답컨텐츠입니다
	public String writeRecomment(Comment comment) {
	
		boardService.writeRecomment(comment);
		
		return "success"; 
	} 
	
	/* 알람 */
	@RequestMapping(path = "/saveAlarm", method = RequestMethod.POST)
	@ResponseBody
	public String saveAlarm(@RequestBody Alarm alarm) { //@RequestBody 안하면 JSON 못받음???(근데 이게 왜 되는거지..?)
		
		boardService.insertAlarm(alarm);
		
		return "success";
	}
	
	
	@RequestMapping(path = "/countAlarm", method = RequestMethod.POST)
	@ResponseBody
	public Integer countAlarm(HttpSession session) {
		Member loginuser = (Member)session.getAttribute("loginuser");
		String id = loginuser.getId();
		
		//id별 알람 갯수
		Integer alarmCnt = boardService.findCountAlarmById(id);
		
		return alarmCnt;
	}
	
	@RequestMapping(path = "/readAlarm", method = RequestMethod.POST)
	@ResponseBody
	public String readAlarm(int alarmNo) {
		
		boardService.updateAlarmReadCheck(alarmNo);
		
		return "success";
	}
	
}

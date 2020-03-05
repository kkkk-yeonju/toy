package com.board.service;

import java.util.List;

import com.board.common.Pagination;
import com.board.repository.BoardRepository;
import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;

public class BoardServiceImpl implements BoardService{
	private BoardRepository boardRepository;
	
	public BoardRepository getBoardRepository() {
		return boardRepository;
	}


	public void setBoardRepository(BoardRepository boardRepository) {
		this.boardRepository = boardRepository;
	}


	@Override
	public Integer registerBoardTx(Board board) {
		
		int newBoardNo = boardRepository.insertBoard(board);
		
		return newBoardNo;
	}


	@Override
	public List<Board> findBoardList(Pagination pagination, String keyword) {
		
		List<Board> boards = boardRepository.selectBoardList(pagination, keyword);
		
		return boards;
	}


	@Override
	public Board findBoardByBoardNo(int boardNo) {
		
		Board board = boardRepository.selectBoardByBoardNo(boardNo);
		
		return board;
	}


	@Override
	public void updateBoard(Board board) {
		
		boardRepository.updateBoard(board);
		
	}


	@Override
	public void deleteBoard(int boardNo) {
		
		boardRepository.deleteBoard(boardNo);
		
	}


	@Override
	public int findBoardListCnt(String keyword) {
		
		int boardCnt = boardRepository.selectBoardListCnt(keyword);
		
		return boardCnt;
	}


	@Override
	public void writeComment(Comment comment) {
		
		boardRepository.insertComment(comment);
		
	}


	@Override
	public List<Comment> findCommentListByBoardNo(int boardNo) {
		
		List<Comment> comments = boardRepository.selectCommentListByBoardNo(boardNo);
		
		return comments;
	}


	@Override
	public void deleteComment(int commentNo) {
		
		boardRepository.deleteComment(commentNo);
		
	}


	@Override
	public void updateComment(Comment comment) {
		
		boardRepository.updateComment(comment);
		
	}


	@Override
	public void writeRecomment(Comment comment) {
		
		Comment parent = boardRepository.selectCommentByCommentNo(comment.getCommentNo());
		boardRepository.updateCommentStep(parent);
		
		comment.setGroupNo(parent.getGroupNo());
		comment.setDepth(parent.getDepth() + 1);
		comment.setStep(parent.getStep() + 1);	
		
		boardRepository.writeRecomment(comment);
		
	}


	@Override
	public Integer findCountAlarmById(String id) {
		
		Integer alarmCnt = boardRepository.selectCountAlarmById(id);
		
		return alarmCnt;
	}


	@Override
	public void insertAlarm(Alarm alarm) {
		
		boardRepository.insertAlarm(alarm);
		
	}


	@Override
	public List<Alarm> findAlarmById(String id) {
		
		List<Alarm> alarms = boardRepository.selectAlarmById(id);
		
		return alarms;
	}


	@Override
	public void updateAlarmReadCheck(int alarmNo) {
		
		boardRepository.updateAlarmReadCheck(alarmNo);
		
	}

}

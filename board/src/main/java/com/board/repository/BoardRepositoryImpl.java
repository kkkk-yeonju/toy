package com.board.repository;

import java.util.HashMap;
import java.util.List;

import com.board.common.Pagination;
import com.board.mapper.BoardMapper;
import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;

public class BoardRepositoryImpl implements BoardRepository{
	private BoardMapper boardMapper;
	
	
	public BoardMapper getBoardMapper() {
		return boardMapper;
	}


	public void setBoardMapper(BoardMapper boardMapper) {
		this.boardMapper = boardMapper;
	}


	@Override
	public int insertBoard(Board board) {
		
		int newBoardNo = boardMapper.insertBoard(board);
		
		return newBoardNo;
	}


	@Override
	public List<Board> selectBoardList(Pagination pagination, String keyword) {
		
		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("keyword", keyword);
		params.put("startList", pagination.getStartList());
		params.put("listSize", pagination.getListSize());
		
		List<Board> boards = boardMapper.selectBoardList(params);
		
		return boards;
	}


	@Override
	public Board selectBoardByBoardNo(int boardNo) {
		
		Board board = boardMapper.selectBoardByBoardNo(boardNo);
		
		return board;
	}


	@Override
	public void updateBoard(Board board) {
		
		boardMapper.updateBoard(board);
		
	}


	@Override
	public void deleteBoard(int boardNo) {
		
		boardMapper.deleteBoard(boardNo);
		
	}


	@Override
	public int selectBoardListCnt(String keyword) {
		
		HashMap<String,Object> param = new HashMap<String, Object>();
		param.put("keyword", keyword);
		
		int boardCnt = boardMapper.selectBoardListCnt(param);
		
		return boardCnt;
	}


	@Override
	public void insertComment(Comment comment) {
		
		boardMapper.insertComment(comment);
		
	}


	@Override
	public List<Comment> selectCommentListByBoardNo(int boardNo) {
		
		List<Comment> comments = boardMapper.selectCommentListByBoardNo(boardNo);
		
		return comments;
	}


	@Override
	public void deleteComment(int commentNo) {
		
		boardMapper.deleteComment(commentNo);
		
	}


	@Override
	public void updateComment(Comment comment) {
		
		boardMapper.updateComment(comment);
		
	}


	@Override
	public Comment selectCommentByCommentNo(int commentNo) {
		
		Comment comment = boardMapper.selectCommentByCommentNo(commentNo);
		
		return comment;
	}


	@Override
	public void updateCommentStep(Comment parent) {
		
		boardMapper.updateCommentStep(parent);
		
	}


	@Override
	public void writeRecomment(Comment comment) {
		
		boardMapper.insertRecomment(comment);
		
	}


	@Override
	public Integer selectCountAlarmById(String id) {
		
		Integer alarmCnt = boardMapper.selectCountAlarmById(id);
		
		return alarmCnt;
	}


	@Override
	public void insertAlarm(Alarm alarm) {
		
		boardMapper.insertAlarm(alarm);
		
	}


	@Override
	public List<Alarm> selectAlarmById(String id) {
		
		List<Alarm> alarms = boardMapper.selectAlarmById(id);
		
		return alarms;
	}


	@Override
	public void updateAlarmReadCheck(int alarmNo) {
		
		boardMapper.updateAlarmReadCheck(alarmNo);
		
	}

}

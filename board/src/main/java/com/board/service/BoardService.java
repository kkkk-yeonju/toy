package com.board.service;

import java.util.List;

import com.board.common.Pagination;
import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;

public interface BoardService {

	Integer registerBoardTx(Board board);

	List<Board> findBoardList(Pagination pagination, String keyword);

	Board findBoardByBoardNo(int boardNo);

	void updateBoard(Board board);

	void deleteBoard(int boardNo);

	int findBoardListCnt(String keyword);

	void writeComment(Comment comment);

	List<Comment> findCommentListByBoardNo(int boardNo);

	void deleteComment(int commentNo);

	void updateComment(Comment comment);

	void writeRecomment(Comment comment);

	Integer findCountAlarmById(String id);

	void insertAlarm(Alarm alarm);

	List<Alarm> findAlarmById(String id);

	void updateAlarmReadCheck(int alarmNo);

}

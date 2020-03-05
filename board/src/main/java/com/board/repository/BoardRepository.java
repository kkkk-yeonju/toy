package com.board.repository;

import java.util.List;

import com.board.common.Pagination;
import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;

public interface BoardRepository {

	int insertBoard(Board board);

	List<Board> selectBoardList(Pagination pagination, String keyword);

	Board selectBoardByBoardNo(int boardNo);

	void updateBoard(Board board);

	void deleteBoard(int boardNo);

	int selectBoardListCnt(String keyword);

	void insertComment(Comment comment);

	List<Comment> selectCommentListByBoardNo(int boardNo);

	void deleteComment(int commentNo);

	void updateComment(Comment comment);

	Comment selectCommentByCommentNo(int commentNo);

	void updateCommentStep(Comment parent);

	void writeRecomment(Comment comment);

	Integer selectCountAlarmById(String id);

	void insertAlarm(Alarm alarm);

	List<Alarm> selectAlarmById(String id);

	void updateAlarmReadCheck(int alarmNo);

}

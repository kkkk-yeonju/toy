package com.board.mapper;

import java.util.HashMap;
import java.util.List;

import com.board.vo.Alarm;
import com.board.vo.Board;
import com.board.vo.Comment;

//이 인터페이스의 패키지와 인터페이스 이름은 board-mapper.xml 파일의 namespace와 일치
public interface BoardMapper {

	int insertBoard(Board board);

	List<Board> selectBoardList(HashMap<String, Object> param);

	Board selectBoardByBoardNo(int boardNo);

	void updateBoard(Board board);

	void deleteBoard(int boardNo);

	int selectBoardListCnt(HashMap<String, Object> param);

	void insertComment(Comment comment);

	List<Comment> selectCommentListByBoardNo(int boardNo);

	void deleteComment(int commentNo);

	void updateComment(Comment comment);

	Comment selectCommentByCommentNo(int commentNo);

	void updateCommentStep(Comment parent);

	void insertRecomment(Comment comment);

	Integer selectCountAlarmById(String id);

	void insertAlarm(Alarm alarm);

	List<Alarm> selectAlarmById(String id);

	void updateAlarmReadCheck(int alarmNo);

}

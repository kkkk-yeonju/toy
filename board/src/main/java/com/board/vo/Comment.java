package com.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Comment {
	private int commentNo;	// 댓글 번호
	private int boardNo;	// 게시글 번호
	private String writer;	// 작성자
	private String content;	// 내용
	private int groupNo;	// 단계
	private int step;		// 순서
	private int depth;		// 깊이
	private Date regDate;	// 날짜

}

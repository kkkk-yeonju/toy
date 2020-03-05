package com.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Board {
	
	private int boardNo;	//글 번호
	private String title;	//제목
	private String writer;	//작성자
	private String content;	//내용
	private int view;		//조회수
	private Date regDate;	//날짜
	
	private String keyword; //검색어

}

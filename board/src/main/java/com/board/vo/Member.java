package com.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Member {
	private String id; //회원 id
	private String pwd; //회원 비밀번호
	private String name; //회원 이름
	private Date regdate; //가입날짜

}

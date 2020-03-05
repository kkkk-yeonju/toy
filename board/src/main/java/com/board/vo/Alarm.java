package com.board.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Alarm {
	private int alarmNo;
	private String receiver;
	private String sender;
	private String content;
	private Date regDate;
	private boolean readCheck;
}

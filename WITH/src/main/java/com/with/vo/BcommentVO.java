package com.with.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BcommentVO {
	private int comment_no;
	private int user_no;
	private int board_no;
	private String user_name;
	private String comment_content;
	private Date comment_date;
	private int comment_cnt;
}

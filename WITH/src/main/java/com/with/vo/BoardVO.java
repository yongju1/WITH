package com.with.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BoardVO {
	
	private int board_no;
	private int user_no;
	private int board_type;
	private String board_title;
	private String board_content;
	private String board_img;
	private int board_view;
	private int comment_cnt;
	private Date board_date;
	private String user_name;
	private String user_email;
}
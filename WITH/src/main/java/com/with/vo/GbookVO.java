package com.with.vo;

import java.util.Date;

import lombok.Data;

@Data
public class GbookVO {

	private int gbook_no;
	private int user_no;
	private String user_name;
	private int place_no;
	private String place_name;
	private String place_img1;
	private String gbook_content;
	private Date gbook_date;
}

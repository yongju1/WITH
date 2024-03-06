package com.with.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class ScheduleVO {

	private int schedule_no;
	private int user_no;
	private int place_no;
	private String place_name;
	private String schedule_title;
	private Date schedule_date;
	private String schedule_memo;
	private String schedule_mycolor;
}
package com.with.vo;

import java.util.Date;

import lombok.Data;

@Data
public class PlaceVO {
	
	private int PLACE_NO;
	private int place_type;
	private String place_name;
	private String place_zipcode;
	private String place_adr1;
	private String place_adr2;
	private String place_img1;
	private String place_img2;
	private String place_img3;
	private String place_phone;
	private String place_bhours;
	private String place_dayoff;
	private String place_menu;
	private String place_detail;
	private Date place_date;
}

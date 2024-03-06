package com.with.vo;

import lombok.Data;

@Data
public class FileVO {
	
	private int file_no;
	private int PLACE_NO;
	private int BOARD_NO;
	private String original_file_name;
	private String stored_file_name;
	private long file_size;
	private String crea_id;
}

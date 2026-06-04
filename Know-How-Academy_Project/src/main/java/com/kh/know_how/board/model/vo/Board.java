package com.kh.know_how.board.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Board {
	private int postNo;
	private String postType;
	private String category;
	private String title;
	private String content;
	private String postWriter;
	private Date createdAt;
	private int viewCount;
	private String status;
	private String titleImg;
}

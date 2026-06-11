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
public class PostComment {
	
	private int commentNo;
    private int postNo;
    private int writerNo;
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private String status;
}

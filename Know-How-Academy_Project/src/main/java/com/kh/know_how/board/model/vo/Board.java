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
	private int postNo;        // POST_NO
    private String postType;   // POST_TYPE
    private String category;   // CATEGORY
    private String title;      // TITLE
    private String content;    // CONTENT
    private Date createdAt;    // CREATED_AT
    private Date updatedAt;    // UPDATED_AT
    private int writerNo;      // WRITER_NO
    private String status;     // STATUS
    private int viewCount;     // VIEW_COUNT

}

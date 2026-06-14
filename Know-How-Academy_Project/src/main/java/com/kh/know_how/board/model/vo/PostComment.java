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
    
    //DB엔 NUMBER로 되있지만 String으로 변경
    //식별자 데이터를 유연하게 처리하기위해 선택
    //예)123, 0001, 9000 -> user123, Guard0001, person9000
    private String writerNo;
    
    private String content;
    private Date createdAt;
    private Date updatedAt;
    private String status;
    
    // 작성자 이름 (MEMBER 테이블 조인)
    private String userName;
    
    
}

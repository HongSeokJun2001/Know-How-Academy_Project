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
public class FileAttachment {

	private int fileNo;           // 파일 번호
    private int targetNo;         // 게시글 번호
    private String targetType;    // 게시판 유형 (POST, NOTICE 등)
    private String originName;    // 원본파일명
    private String saveName;      // 저장 파일명
    private String filePath;      // 파일 저장 경로
    private Date createdAt;       // 업로드 일
    private Date updatedAt;       // 수정 일자
    private String status;        // 삭제 여부 (Y/N)
    private String fileLevel;     // 파일 구분 (1:썸네일, 2:일반)
	public void setFileLevel(int i) { // 커밋할 때는 지우면 됩니다.
		// TODO Auto-generated method stub
		
	}

}

package com.kh.know_how.counselor.model.vo;

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
public class CounselorProfilImg {
	
	private int profileNo;			//  PROFILE_NO
	private int userNo;			//	USER_NO
	private String originName;		//	ORIGIN_NAME
	private String saveName;		//	SAVE_NAME
	private String filePath;		//	FILE_PATH

}

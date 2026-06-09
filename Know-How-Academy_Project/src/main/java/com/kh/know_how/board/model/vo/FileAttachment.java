package com.kh.know_how.board.model.vo;

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
	private int fileNo;
	private int targetNo;
	private String targetType;
	private String originName;
	private String saveName;
	private String filePath;
}

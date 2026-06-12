package com.kh.know_how.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

public class FileRenamePolicy {

	public static String saveFile(MultipartFile upfile,
								HttpSession session, String path) { // 저장파일명을 만들어주는 메소드
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMM")
								.format(new Date());
		
		String saveName = currentTime + "_" + originName;
		
		String savePath = session.getServletContext()
						  .getRealPath(path);
		
		try {
			upfile.transferTo(new File(savePath + saveName));
		} catch(IOException e) {
			System.out.println(">>> [첨부파일저장실패] ");
			e.printStackTrace();
			return "1";
		}
		
		return saveName;	
	}
	
}

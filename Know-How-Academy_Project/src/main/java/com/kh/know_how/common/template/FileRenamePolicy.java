package com.kh.know_how.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

public class FileRenamePolicy {
	
	//MultipartFile/ HttpSession, String filePath
	//파일명을 수정/ 업로드 후 수정 을 리턴해주는 메소드
	public static String saveFile(MultipartFile originFile, 
									HttpSession session, String filePath) {
		
		String originName = originFile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		String ext = originName.substring(originName.lastIndexOf("."));//.jpg
		
		String saveName = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext()
								 .getRealPath(filePath);
		
		try {
			originFile.transferTo(new File(savePath+saveName));
		}catch(IOException e) {
			e.printStackTrace();
		}
			
		return saveName;
	}

}

package com.kh.know_how.common.template;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpSession;

public class FileRenamePolicy {

	public static String saveFile(MultipartFile upfile,
								HttpSession session, String path) {
		
		String originName = upfile.getOriginalFilename();
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss")
								.format(new Date());
		
		int ranNum = (int)(Math.random() * 90000 + 10000);
		
		String ext = originName.substring(originName.lastIndexOf("."));
		
		String saveName = currentTime + ranNum + ext;
		
		String savePath = session.getServletContext()
						  .getRealPath(path);
		
		try {
			upfile.transferTo(new File(savePath + saveName));
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return saveName;	
	}
	
}

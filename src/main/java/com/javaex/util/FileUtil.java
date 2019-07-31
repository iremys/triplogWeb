package com.javaex.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;

import org.springframework.web.multipart.MultipartFile;

public class FileUtil {

	public void fileCopy(MultipartFile file) {

		//String saveDir = "D:\\upload";
		String saveDir = "/upload";


		// 원파일이름
		String orgName = file.getOriginalFilename();

		// 디렉토리 만들기
		DateTimeUtil dateTimeUtil = new DateTimeUtil();
		//String foler_name = "\\" + dateTimeUtil.getDateStr() + "\\";
		String foler_name = "/" + dateTimeUtil.getDateStr() + "/";
		
		String file_path = saveDir + foler_name;
		File web_file_path = new File(file_path);
		if (!web_file_path.isDirectory()) {
			web_file_path.mkdirs();
		}


		// 파일업로드
		try {
			byte[] fileData = file.getBytes();
			OutputStream out = new FileOutputStream(web_file_path + "/" + orgName);
			BufferedOutputStream bout = new BufferedOutputStream(out);

			bout.write(fileData);

			if (bout != null) {
				bout.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}

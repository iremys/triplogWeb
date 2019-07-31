package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.FileDao;
import com.javaex.util.DateTimeUtil;
import com.javaex.util.FileUtil;
import com.javaex.vo.FileVo;

@Service
public class FileService {
	
	@Autowired
	private FileDao fileDao;
	
	
	//파일정보 저장
	public int addFileInfo(FileVo fileVo){
		
		/* String saveDir = "D:\\upload"; */
		
		String saveDir =  "/upload";
		
		// 디렉토리 만들기
		DateTimeUtil dateTimeUtil = new DateTimeUtil();
		String foler_name = "/" + dateTimeUtil.getDateStr() + "/";
		String web_file_path = saveDir + foler_name + fileVo.getSaveFileName();
		
		fileVo.setWebFilePath(web_file_path);
		return fileDao.insertFileInfo(fileVo);
		
	}
	
	
	//파일복사  -->무조건 카피
	public void copyFile(MultipartFile file) {
		//파일을 복사한다.
		FileUtil fileUtil = new FileUtil();
		fileUtil.fileCopy(file);
	}
	
	
	
	
	
	
	
	

    //같은 글파일 일괄삭제 
	public int removeFileInfo(int inouNo){
		return fileDao.deleteFile(inouNo);
	}
}

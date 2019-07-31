package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.FileVo;

@Repository
public class FileDao {

	@Autowired
	private SqlSession sqlSession;
	
	public int insertFileInfo(FileVo fileVo) {
		return sqlSession.insert("file.insertFile", fileVo);
	}
	
	public int deleteFile(int inoutNo) {
		return sqlSession.insert("file.deleteFile", inoutNo);
	}
	
	
	public List<FileVo> selectFileList(int inoutNo) {
		return sqlSession.selectList("file.selectFileList", inoutNo);
	}
}

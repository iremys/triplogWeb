package com.javaex.vo;

public class FileVo {

	private int webFileNo;
	private int fileNo;
	private int inoutNo;
	private String saveFileName;
	private String filePath;
	private String webFilePath;

	public FileVo() {
	}

	public FileVo(int webFileNo, int fileNo, int inoutNo, String saveFileName, String filePath, String webFilePath) {
		this.webFileNo = webFileNo;
		this.fileNo = fileNo;
		this.inoutNo = inoutNo;
		this.saveFileName = saveFileName;
		this.filePath = filePath;
		this.webFilePath = webFilePath;
	}

	public int getWebFileNo() {
		return webFileNo;
	}

	public void setWebFileNo(int webFileNo) {
		this.webFileNo = webFileNo;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public int getInoutNo() {
		return inoutNo;
	}

	public void setInoutNo(int inoutNo) {
		this.inoutNo = inoutNo;
	}

	public String getSaveFileName() {
		return saveFileName;
	}

	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getWebFilePath() {
		return webFilePath;
	}

	public void setWebFilePath(String webFilePath) {
		this.webFilePath = webFilePath;
	}

	@Override
	public String toString() {
		return "FileVo [webFileNo=" + webFileNo + ", fileNo=" + fileNo + ", inoutNo=" + inoutNo + ", saveFileName="
				+ saveFileName + ", filePath=" + filePath + ", webFilePath=" + webFilePath + "]";
	}

}

package com.javaex.vo;

public class TripVo {
	private int webTripNo;
	private int tripNo;
	private String tripTitle;
	private String startDate;
	private String endDate;
	private String regDate;

	public TripVo() {
	}

	public TripVo(int webTripNo, int tripNo, String tripTitle, String startDate, String endDate, String regDate) {
		this.webTripNo = webTripNo;
		this.tripNo = tripNo;
		this.tripTitle = tripTitle;
		this.startDate = startDate;
		this.endDate = endDate;
		this.regDate = regDate;
	}

	public int getWebTripNo() {
		return webTripNo;
	}

	public void setWebTripNo(int webTripNo) {
		this.webTripNo = webTripNo;
	}

	public int getTripNo() {
		return tripNo;
	}

	public void setTripNo(int tripNo) {
		this.tripNo = tripNo;
	}

	public String getTripTitle() {
		return tripTitle;
	}

	public void setTripTitle(String tripTitle) {
		this.tripTitle = tripTitle;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "TripVo [webTripNo=" + webTripNo + ", tripNo=" + tripNo + ", tripTitle=" + tripTitle + ", startDate="
				+ startDate + ", endDate=" + endDate + ", regDate=" + regDate + "]";
	}

}

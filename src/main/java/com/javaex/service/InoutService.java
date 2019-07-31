package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.FileDao;
import com.javaex.dao.InoutDao;
import com.javaex.vo.FileVo;
import com.javaex.vo.InOutVo;

@Service
public class InoutService {

	@Autowired
	private InoutDao inoutDao;

	@Autowired
	private FileDao fileDao;

	public int addInout(InOutVo inoutVo) {
		int cnt;

		System.out.println("inoutVo.getInoutNo() " + inoutVo.getInoutNo());
		int inoutNoCnt = inoutDao.selectInoutNo(inoutVo.getInoutNo());
		System.out.println("inoutNoCnt " + inoutNoCnt);

		if (inoutNoCnt == 1) {
			cnt = inoutDao.updateInout(inoutVo);
		} else if (inoutNoCnt == 0) {
			cnt = inoutDao.insertInout(inoutVo);
		} else {
			System.out.println("오류");
			cnt = inoutNoCnt;
		}

		// 파일정보 삭제
		fileDao.deleteFile(inoutVo.getInoutNo());

		return cnt; // 1:등록 또는 수정 성공, 나머지숫자 실패

	}

	public void removeInout(int inoutNo) {
		inoutDao.deleteInout(inoutNo);
		fileDao.deleteFile(inoutNo);

	}

	public List<InOutVo> getInoutList(int tripNo) {
		return inoutDao.selectInoutList(tripNo);
	}

	public Map<String, Object> getInoutListPage(int tripNo, int crtPage) {


		////////////////////////////////////////
		// 리스트 가져오기
		/////////////////////////////////////////

		// 페이지당 글갯수
		int listCnt = 10;

		// 현재페이지
		crtPage = (crtPage > 0) ? crtPage : (crtPage = 1); // crtPage가 0보다 작으면 1page로

		// 시작글 번호
		int startIndex = (crtPage - 1) * listCnt; // 1page --> 0, 2page --> 10

		// 글 가져오기
		List<InOutVo> inoutList = inoutDao.selectInoutListPage(tripNo, startIndex, listCnt);

		////////////////////////////////////////
		//페이징 계산
		/////////////////////////////////////////

		// 전체갯수
		int totalCount = inoutDao.selectTotalCount(tripNo);
		System.out.println("totalCount ==>" + totalCount);

		//페이지당 버튼 갯수
		int pageBtnCount = 5;

		//마지막버튼번호
		//1  --> 1~5
		//2  --> 1~5
		//3  --> 1~5
		//6  --> 6~10
		//7  --> 6~10
		//10  --> 6~10
		int endPageBtnNo = (int) Math.ceil(crtPage / (double) pageBtnCount) * pageBtnCount;

		//시작버튼번호
		int startPageBtnNo = endPageBtnNo - (pageBtnCount - 1);

		//다음 화살표 유무
		boolean next = false;
		if (endPageBtnNo * listCnt < totalCount) { // 10*10 < 107
			next = true;
		} else {
			endPageBtnNo = (int) Math.ceil(totalCount / (double) listCnt);
		}

		//이전 화살표 유무
		boolean prev = false;
		if (startPageBtnNo != 1) {
			prev = true;
		}

		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("prev", prev);
		pMap.put("startPageBtnNo", startPageBtnNo);
		pMap.put("endPageBtnNo", endPageBtnNo);
		pMap.put("next", next);
		pMap.put("inoutList", inoutList);

		System.out.println(pMap.toString());

		return pMap;

	}

	public InOutVo getInout(int inoutNo) {
		// inout
		InOutVo inoutVo = inoutDao.selectInout(inoutNo);
		// 파일
		List<FileVo> fileList = fileDao.selectFileList(inoutNo);

		// 결합
		inoutVo.setFileList(fileList);

		return inoutVo;
	}

}

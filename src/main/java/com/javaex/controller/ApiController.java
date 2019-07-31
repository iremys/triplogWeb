package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.FileService;
import com.javaex.service.InoutService;
import com.javaex.service.TripService;
import com.javaex.vo.FileVo;
import com.javaex.vo.InOutVo;
import com.javaex.vo.TripVo;

@Controller
@RequestMapping("/api")
public class ApiController {

	@Autowired
	private TripService tripService;
	
	@Autowired
	private InoutService inoutService;

	@Autowired
	private FileService fileService;

	// inout저장요청
	@ResponseBody
	@RequestMapping(value = "/sendInout")
	public int sendInout(@RequestBody InOutVo inoutVo) {
		System.out.println("sendInout: " + inoutVo.toString());

		// 1:등록 또는 수정 성공,
		// 나머지숫자 실패
		int cnt = inoutService.addInout(inoutVo);
		return cnt;
	}

	// 파일정보 저장요청
	@ResponseBody
	@RequestMapping(value = "/sendFileInfo")
	public int sendFileInfo(@RequestBody FileVo fileVo) {
		System.out.println("fileVo: " + fileVo.toString());

		// 1:등록 성공 // 나머지숫자 실패
		int cnt = fileService.addFileInfo(fileVo);
		return cnt;
	}

	// 파일복사요청
	@ResponseBody
	@RequestMapping(value = "/sendFile")
	public String sendFileo(@RequestParam("file") MultipartFile file) {
		System.out.println("MultipartFile: " + file.getOriginalFilename());
		System.out.println("MultipartFile: " + file.getSize());
		fileService.copyFile(file);

		return "succeess";
	}

	// inoutVo관련 정보 삭제 --> 동기화 실패시
	@RequestMapping(value = "/rollbackInout")
	public String rollbackInout(@RequestParam("inoutNo") int inoutNo) {
		inoutService.removeInout(inoutNo);
		return "index";
	}

	// 여행정보
	@ResponseBody
	@RequestMapping(value = "/triplist", method = RequestMethod.GET)
	public String tripList() {
		
		return tripService.getTripList().toString();
	}
	
	
	// inoutList (지도에 inout출력시 사용)
	@ResponseBody
	@RequestMapping(value="/inoutList")
	public List<InOutVo> inoutList(@RequestParam int tripNo) {
		
		return inoutService.getInoutList(tripNo);
	}
	
	
	// inoutVo 
	@ResponseBody
	@RequestMapping(value="/inout")
	public InOutVo inout(@RequestParam int inoutNo) {
		
		return inoutService.getInout(inoutNo);
	}
	
	
	
	
	
	

}

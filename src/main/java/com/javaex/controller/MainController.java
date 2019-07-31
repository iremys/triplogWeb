package com.javaex.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.InoutService;
import com.javaex.service.TripService;
import com.javaex.vo.InOutVo;
import com.javaex.vo.TripVo;

@Controller
public class MainController {

	@Autowired
	private TripService tripService;
	
	@Autowired
	private  InoutService inoutService;
	
	
	@RequestMapping(value="/")
	public String main(@RequestParam(value="tripNo", defaultValue="0") int tripNo, 
			@RequestParam(value="crtPage", defaultValue="1") int crtPage,
			Model model) {
		
		List<TripVo> tripList = tripService.getTripList();
		
		if(tripNo == 0) {
			tripNo = tripList.get(0).getTripNo();
		}
		
		Map<String, Object> pMap = inoutService.getInoutListPage(tripNo, crtPage);
		
		System.out.println("pMap=> " + pMap.toString());
		model.addAttribute("tripList", tripList);
		model.addAttribute("pMap", pMap);
		model.addAttribute("crtTripNo", tripNo);
		model.addAttribute("crtPage", crtPage);
		return "main";
	}
	
	
	@RequestMapping(value="/map")
	public String map(@RequestParam(value="tripNo", defaultValue="0") int tripNo, Model model) {
		
		List<TripVo> tripList = tripService.getTripList();
		model.addAttribute("tripList", tripList);
		model.addAttribute("crtTripNo", tripNo);
		return "map";
	}
}

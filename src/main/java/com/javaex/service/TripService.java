package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.TripDao;
import com.javaex.vo.TripVo;

@Service
public class TripService {
	
	@Autowired
	private TripDao tripDao;
	
	public List<TripVo> getTripList(){
		return tripDao.selectTripList();
	}
	
}

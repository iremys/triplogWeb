package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.TripVo;


@Repository
public class TripDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<TripVo> selectTripList(){
		return sqlSession.selectList("trip.selectTripList");
	}

}

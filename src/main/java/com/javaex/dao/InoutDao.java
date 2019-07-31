package com.javaex.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.InOutVo;

@Repository
public class InoutDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public int insertInout(InOutVo inoutVo) {
		return sqlSession.insert("inout.insertInout", inoutVo);
	}
	
	public int updateInout(InOutVo inoutVo) {
		return sqlSession.update("inout.updateInout", inoutVo);
	}
	
	public List<InOutVo> selectInoutList(int tripNo) {
		return sqlSession.selectList("inout.selectInoutList", tripNo);
	}
	
	
	public int selectInoutNo(int inoutNo) {
		return sqlSession.selectOne("inout.selectInoutNo", inoutNo);
	}
	
	public int deleteInout(int inoutNo) {
		return sqlSession.delete("inout.deleteInout", inoutNo);
	}
	
	
	public InOutVo selectInout(int inoutNo) {
		return sqlSession.selectOne("inout.selectInout", inoutNo);
	}
	
	
	public List<InOutVo> selectInoutListPage(int tripNo, int startIndex, int offset) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("tripNo", tripNo);
		map.put("startIndex", startIndex);
		map.put("offset", offset);
		return sqlSession.selectList("inout.selectInoutListPage", map);
	}
	
	public int selectTotalCount(int tripNo) {
		return sqlSession.selectOne("inout.selectTotalCount", tripNo);
	}
	
}

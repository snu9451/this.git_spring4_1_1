package web.mvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;

public class Board41MDao2 {
	Logger logger = Logger.getLogger(Board41MDao2.class);
	SqlSessionTemplate sqlSessionTemplate = null;
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}
	public List<Map<String, Object>> getBoardList(Map<String, Object> pmap) {
		logger.info("Board41MDao - getBoardList 호출성공 ");
		List<Map<String, Object>> boardList = null;
		boardList = sqlSessionTemplate.selectList("getBoardList",pmap);
		logger.info("Board41MDao - getBoardList 호출성공 " + boardList);
		return boardList;
	}
	public int boardInsert(Map<String, Object> pmap) {
		logger.info("boardMDao.boardInsert 호출성공");
		int result = 0;
		result = sqlSessionTemplate.insert("boardInsertMaster",pmap);
		
		return result;
	}
	public void bmStepUpdate(Map<String, Object> pmap) {
		logger.info("boardMDao.boardInsert 호출성공");
		int result = 0;
		result = sqlSessionTemplate.update("bmStepUpdate",pmap);
	}
	public void hitCount(int bm_no) {
		logger.info("boardMDao.boardInsert 호출성공");
		int result = 0;
		result = sqlSessionTemplate.update("hitCount",bm_no);
	}
	public int getBmGroup() {
		int result = 0;
		result = sqlSessionTemplate.selectOne("getBmGroup");
		return result;
	}
	public int getBmNo(int bm_no) {
		int result = 0;
		result = sqlSessionTemplate.selectOne("getBmNo", bm_no);
		return result;
	}
	public int boardUpdate(Map<String, Object> pmap) {
		int result = 0;
		result = sqlSessionTemplate.update("boardMUpdate", pmap);
		return result;
	}
	public String getPw(String bm_pw) {
		String pw = "";
		pw = sqlSessionTemplate.selectOne("getPw", bm_pw);
		return pw;
	}
	public int boardDelete(Map<String, Object> pmap) {
		int result = 0;
		result = sqlSessionTemplate.delete("boardMDelete", pmap);
		return result;
	}
	public int boardManagerDelete(Map<String, Object> pmap) {
		int result = 0;
		String bm_nos = (String)pmap.get("bm_no");
		StringTokenizer st = new StringTokenizer(bm_nos,"cutter");
		Map<Integer, Integer> pmap2 = new HashMap<>();
		List<Map<Integer, Integer>> li = new ArrayList<>();
//		for(int j = 0; j < )
		for(int i = 0; i < st.countTokens(); i++) {
			pmap2 = new HashMap<>();
			pmap2.put(i, Integer.parseInt(st.nextToken())+0);
			li.add(pmap2);
		}
		Map<String, List<Map<Integer, Integer>>> pmap3 = new HashMap<>();
		pmap3.put("li", li);
		result = sqlSessionTemplate.delete("boardMManagerDelete", pmap3);
//		if(result == st.countTokens()) {
//			result = 1;
//		}
//		else {
//			result = 0;
//		}
		return result;
	}
}

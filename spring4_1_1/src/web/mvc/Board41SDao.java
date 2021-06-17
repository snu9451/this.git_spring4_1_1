package web.mvc;

import java.util.Map;

import org.apache.log4j.Logger;
import org.mybatis.spring.SqlSessionTemplate;

public class Board41SDao {
	Logger logger = Logger.getLogger(Board41SDao.class);
	SqlSessionTemplate sqlSessionTemplate = null;

	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		this.sqlSessionTemplate = sqlSessionTemplate;
	}

	public int boardInsert(Map<String, Object> pmap) {
		logger.info("boardMDao.boardInsert 호출성공");
		int result = 0;
		pmap.put("bs_seq", 1);
		pmap.put("bs_size", 50);
		result = sqlSessionTemplate.insert("boardInsertSub",pmap);
		
		return result;
	}

	public int boardUpdate(Map<String, Object> pmap) {
		logger.info("boardMDao.boardUpdate 호출성공");
		int result = 0;
		pmap.put("bs_seq", 1);
		pmap.put("bs_size", 50);
//		result = sqlSessionTemplate.update("boardUpdateSub",pmap);
		
		return result;
	}

	public int boardDelete(Map<String, Object> pmap) {
		int result = 0;
		result = sqlSessionTemplate.delete("boardSDelete", pmap);
		return result;
	}
}

package web.mvc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

public class Board41Logic {
	Logger logger = Logger.getLogger(Board41Logic.class);
	private Board41MDao boardMDao = null;
	public void setBoardMDao(Board41MDao boardMDao) {
		this.boardMDao = boardMDao;
	}
	private Board41SDao boardSDao = null;
	public void setBoardSDao(Board41SDao boardSDao) {
		this.boardSDao = boardSDao;
	}

	public List<Map<String, Object>> getBoardList(Map<String, Object> pmap) {
		logger.info("getBoardList 호출 성공");
		List<Map<String, Object>> boardList = null;
		String gubun = null;
		if(pmap.get("gubun") != null) {
			gubun = pmap.get("gubun").toString();			
		}
		if(gubun != null && "detail".equals(gubun)) {
			int bm_no = 0;
			bm_no = Integer.parseInt(pmap.get("bm_no").toString());
			boardMDao.hitCount(bm_no);
		}
		boardList = boardMDao.getBoardList(pmap);
		return boardList;
	}
	//=>board/boardInsert.sp4?bm_no=6&bm_title=게시글제목&bs_file=a.txt&bm_writer=%EC%9D%B4%EC%88%9C%EC%8B%A0&bm_email=test@hot.com&bm_content=%EC%97%B0%EC%8A%B5&bm_pw=123
	public int boardInsert(Map<String, Object> pmap) {
		int result = 0;
		int bm_no = 0;
		int bm_group = 0;
//		int pbm_no = Integer.parseInt(pmap.get("bm_no").toString());
		bm_no = boardMDao.getBmNo(bm_no);
		pmap.put("bm_no", bm_no);
		if(pmap.get("bm_group") != null) {
			bm_group = Integer.parseInt(pmap.get("bm_group").toString());
		}
		if(bm_group > 0) {
			boardMDao.bmStepUpdate(pmap);
			pmap.put("bm_pos", Integer.parseInt(pmap.get("bm_pos").toString()) + 1);
			pmap.put("bm_step", Integer.parseInt(pmap.get("bm_step").toString()) + 1);
		}
		else {//새글일때
			bm_group = boardMDao.getBmGroup();
			pmap.put("bm_group", bm_group);
			pmap.put("bm_pos", 0);
			pmap.put("bm_step", 0);
		}
		if((pmap.get("bs_file") != null) && (pmap.get("bs_file").toString().length() > 0)) {
//			pmap.put("bm_no", bm_no);
			pmap.put("bs_seq", 1);
			boardSDao.boardInsert(pmap);
		}
		logger.info("boardInsert 호출성공");
		int resultMaster = boardMDao.boardInsert(pmap);
			result = 1;
		return result;
	}

	public int boardUpdate(Map<String, Object> pmap) {
		int result = 0;
		String pw = "";
		if(pmap.get("bm_no") != null) {
			pw = boardMDao.getPw(pmap.get("bm_no").toString());			
			if(pw.equals(pmap.get("bm_pw"))) {
				result = boardMDao.boardUpdate(pmap);			
			}
		}
		return result;
	}

	public int boardDelete(Map<String, Object> pmap) {
		int result = 0;
		
		String pw = "";
		if(pmap.get("bm_no") != null && pmap.get("bm_pw") != null) {
			pw = boardMDao.getPw(pmap.get("bm_no").toString());		
			if(pw != null) {
				if(pw.equals(pmap.get("bm_pw"))) {
					result = boardMDao.boardDelete(pmap);
					boardSDao.boardDelete(pmap);
				}
			}
		}
		return result;
	}

	public int boardManagerDelete(Map<String, Object> pmap) {
		
		int result_m = 0;
		int result_s = 0;
		int result = 0;
		
//		// 첨부파일이 있는 삭제대상 게시글의 수
//		int hasFileCnt = Integer.parseInt((pmap.get("total").toString()));
//		logger.info("hasFileCnt ############==> "+hasFileCnt);
		
		// 삭제대상 게시글들의 번호
		String bm_no_files = (String)pmap.get("bm_no_files");
		String bm_no_nofile = (String)pmap.get("bm_no_nofile");
		
		StringTokenizer st_has = new StringTokenizer(bm_no_files,"cutter");
		StringTokenizer st_no = new StringTokenizer(bm_no_nofile,"cutter");
		
//		Map<Integer, Integer> pmap2 = new HashMap<>();
		List li = new ArrayList();
		List hasFileLi = new ArrayList();
		List wholeLi = new ArrayList();
		
		Map map = new HashMap();
		while(st_has.hasMoreTokens()) {
			String token = st_has.nextToken();
			if(token != null && token.length() > 0) {
				hasFileLi.add(Integer.parseInt(token));
				wholeLi.add(Integer.parseInt(token));
			}
		}
		while(st_no.hasMoreTokens()) {
			String token = st_no.nextToken();
			if(token != null && token.length() > 0) {
				wholeLi.add(Integer.parseInt(token));
			}
		}
		map.put("hasFileLi", hasFileLi);
		map.put("wholeLi", wholeLi);
		logger.info("hasFileLi =====> "+hasFileLi);
		logger.info("wholeLi =====> "+wholeLi);
		logger.info("map =====> "+map);
		
		// sub 테이블에서 
		if(hasFileLi.size() > 0) result_s = boardSDao.boardManagerDelete(map);
		if(wholeLi.size() > 0) result_m = boardMDao.boardManagerDelete(map);
		
		// result에는 sub테이블과 main테이블 각각의 처리결과의 합을 담는다.
		result = result_m + result_s;
		logger.info("result =====> "+result);
		if(result == (hasFileLi.size()+wholeLi.size())) {
			result = 1;
		}
		else {
			result = 0;
		}
		return result;
	}

	public int getPwManager(Map<String, Object> pmap) {
		int result = 0;
		
		return result;
	}
	
//	public int boardInsert(Map<String, Object> pmap) {
//		int result = 0;
//		int fileOk = 1;
//		logger.info("boardUpdate 호출성공");
//		int resultMaster = boardMDao.boardInsert(pmap);
//		if(pmap.containsKey("bs_file")) {
//			fileOk = boardSDao.boardInsert(pmap);
//		}
//		if(resultMaster == 1 && fileOk == 1) {
//			result = 1;
//		}
//		else {
//			result = 0;
//		}
//		return result;
//	}
	
//	public int boardUpdate(Map<String, Object> pmap) {
//		int result = 0;
//		int fileOk = 1;
//		logger.info("boardUpdate 호출성공");
//		int resultMaster = boardMDao.boardUpdate(pmap);
//		if(pmap.containsKey("bs_file")) {
//			fileOk = boardSDao.boardUpdate(pmap);
//		}
//		if(resultMaster == 1 && fileOk == 1) {
//			result = 1;
//		}
//		else {
//			result = 0;
//		}
//		return result;
//	}
}

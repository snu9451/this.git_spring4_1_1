package web.mvc;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.google.gson.Gson;
import com.util.HashMapBinder;

public class Board41Controller2 extends MultiActionController{
//	<bean id = "board-controller">
//		<property name = "boardLogic">
//	<bean/>
	Logger logger = Logger.getLogger(Board41Controller2.class);
	private Board41Logic boardLogic = null;

	public void setBoardLogic(Board41Logic boardLogic) {
		logger.info("setBoardLogic 호출성공");
		this.boardLogic = boardLogic;
	}
	//request로 유지하는 방법
	//메소드를 정의하는것은 가능하다.
	//파라미터가 없이도 괜찮은가? - req, res가 없을시 메소드를 찾지못해 실행되지 않는다. - req,res를 파라미터로 가지고있는 메소드를 찾아간다.
	// 이 사실 하나만 보더라도 이것은 의존적이다 라고 이야기 할 수 있지 않을까? - 여러분의 생각은 무엇입니까?
	// 최초 나는 ModelAndView를 사용했습니다. 이것은 MultiActionController를 상속 받았을 때
	// 우리가 doGet에서는 누릴 수 없었던 반환 타입을 바꾸어 쓸 수 있는 혜택을 누릴 수 있게 된 것이다.
	// 여기에 동의 하나? 동의 한다면 ModelAndView의 scope를 request로 한 이유로 생각해보자.
	// 이 생각의 끝에 forward로 페이지를 부른 다는 사실을 인지하게 될 것이다.
	// ModelAndView가 있는데 굳이 파라미터에 req, res가 있어야만 한다. 그렇지 않으면 매핑을 해주지 않을 것이라고
	// 말하는 것은 앞뒤가 맞지 않는 것이다. 이상한 태도를 보이는 것이다.
	// 굳이 없어도 되는 것을 형식적으로 가지고 있어야 한다. doGet안에 있는 것이니까 너도 있어야 해줄거야? 라고 말하는 것이다.
	public ModelAndView getBoardList(HttpServletRequest req, HttpServletResponse res) 
	throws Exception
	{
		logger.info("Board41Controller - getBoardList(req, res) 호출성공");
		HashMapBinder hmb = new HashMapBinder(req);
		Map<String, Object> target = new HashMap<>();
		hmb.bind(target);
		List<Map<String, Object>> boardList = null;
		boardList = boardLogic.getBoardList(target);
		logger.info("boardList : " + boardList);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/getBoardList");
		mav.addObject("boardList", boardList);
		logger.info("boardList1 : " + boardList);
//		HttpSession session = req.getSession();
//		session.setAttribute("name", name);
//		RequestDispatcher view = req.getRequestDispatcher("getBoardList.jsp");
//		view.forward(req, res);//이 부분이 있다면 webcontent - board경로를 탄다// 없다면 web-inf - views - board경로를 탄다
		return mav;
	}
	/****************************
	 * 
	 * @param req
	 * @param res
	 * @return
	 * @throws Exception
	 */
	public ModelAndView getBoardDetail(HttpServletRequest req, HttpServletResponse res) 
			throws Exception
	{
		logger.info("Board41Controller - getBoardDetail(req, res) 호출성공");
		HashMapBinder hmb = new HashMapBinder(req);
		Map<String, Object> target = new HashMap<>();
		hmb.bind(target);
		target.put("gubun", "detail");
		logger.info("bm_no : " + target.get("bm_no"));
		List<Map<String, Object>> boardDetail = null;
		boardDetail = boardLogic.getBoardList(target);
		logger.info("boardDetail : " + boardDetail);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("board/read");
		mav.addObject("boardDetail", boardDetail);
		logger.info("boardDetail : " + boardDetail);
		return mav;
	}
	//json으로 내보내주는 방법 - @RestController:String , @Controller:void or ModelAndView or String
	//@RestController
	public void jsonGetBoardList(HttpServletRequest req, HttpServletResponse res) 
			throws Exception
	{
		logger.info("Board41Controller - jsongetBoardList 호출성공");
		
		List<Map<String, Object>> boardList = null;
		boardList = boardLogic.getBoardList(null);
//		RequestDispatcher view = req.getRequestDispatcher("jsonGetBoardList.jsp");
//		view.forward(req, res);//이 부분이 있다면 webcontent - board경로를 탄다// 없다면 web-inf - views - board경로를 탄다
		Gson gson = new Gson();
		String imsi = gson.toJson(boardList);
		
		res.setContentType("application/json;charset=utf-8");
		PrintWriter out = res.getWriter();
		out.print(imsi);
	}
	
	public void boardInsert(HttpServletRequest req, HttpServletResponse res) throws Exception{
		logger.info("boardInsert 호출성공");
		HashMapBinder hmb = new HashMapBinder(req);
		Map<String, Object> pmap = new HashMap<>();
		//사용자가 입력한 값이나 서버에서 클라이언트에게 요청한 값 넘김.
		hmb.multiBind(pmap);
		logger.info("boardInsert pmap : " + pmap);
		int result = 0;
		// insert 결과를  result에 담는다. 성공 시, result=1
		result = boardLogic.boardInsert(pmap);
		if(result == 1) {
			res.sendRedirect("./getBoardList.sp4");
		}
		else {
			res.sendRedirect("등록실패 페이지 처리");
		}
	}
	
//	public void boardUpdate(HttpServletRequest req, HttpServletResponse res) throws Exception{
//		logger.info("boardUpdate 호출성공");
//		HashMapBinder hmb = new HashMapBinder(req);
//		Map<String, Object> pmap = new HashMap<>();
//		//사용자가 입력한 값이나 서버에서 클라이언트에게 요청한 값 넘김.
//		hmb.bind(pmap);
//		logger.info("boardUpdate pmap : " + pmap);
//		int result = 0;
//		result = boardLogic.boardUpdate(pmap);		
//		if(result == 1) {
//			res.sendRedirect("./getBoardList.sp4");
//		}
//		else {
//			res.sendRedirect("등록실패 페이지 처리");
//		}
//	}
	
	public void boardDelete(HttpServletRequest req, HttpServletResponse res) throws Exception{
		
	}
}

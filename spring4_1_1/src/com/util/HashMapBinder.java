package com.util;

import java.io.File;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class HashMapBinder {
	
	Logger logger = Logger.getLogger(HashMapBinder.class);
	
	// 첨부 파일 처리에 필요한 변수 선언
	// 첨부 파일은 **반드시** POST 방식으로 전송해야 한다.
	// 기존의 request로는 값을 가져오지 못하게 됨.
	// 반드시 이 클래스를 사용해야 사용자가 입력한 값을 넘겨받을 수 있음.
	MultipartRequest multi = null;	
	String realFolder = "";
	// 첨부 파일 한글 처리
	String encType = "UTF-8";
	// 첨부 파일 크기 제한
	int maxSize = 5*1024*1024; // 5MB
	
	HttpServletRequest request = null;
	
	public HashMapBinder() {}
	
	public HashMapBinder(HttpServletRequest request) {
		this.request = request;
		realFolder = "E:\\ssam\\spring4_1_1\\WebContent\\pds";
	}
	
	// 원본(주소번지)을 넘기고 있으므로 반환값이 없어도 괜찮다. 반환-대입 없이도 그 아이가 진짜로 바뀐다.
	public void multiBind(Map<String, Object> target) {
		target.clear();
		try {
			multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
		} catch (Exception e) {
			logger.info("Exception: "+e.toString());
		}
		Enumeration en = multi.getParameterNames(); // 배열 구조체  묶음
		// <input type="text" name="mem_id" ... >
		while(en.hasMoreElements()) {
			String key = (String)en.nextElement();
			logger.info("value: "+multi.getParameter(key));
			target.put(key, multi.getParameter(key));
			logger.info("value: "+target);
		}
		// 첨부 파일에 대한 정보 받아오기
		Enumeration<String> files = multi.getFileNames();
		if(files != null) {
			File file = null; // 파일명을 객체로 만들어 줄 뿐, 안의 내용까지 생성되는 것은 아니다.
			while(files.hasMoreElements()) {
				// 파일 이름 변형
				String fname = files.nextElement();
				String filename = multi.getFilesystemName(fname);
				target.put("bs_file", filename);
				if(filename != null && filename.length() > 1) {
					file = new File(realFolder + "\\" + filename);
				}///////////////////end of inner if
			}///////////////////////end of while
			// 첨부 파일의 크기를 담을 변수
			double size = 0;
			if(file != null) {
				size = file.length();
				target.put("bs_size", size);
			}
		}///////////////////////////end of outer if
		
	}
	
	public void bindPost(Map<String, Object> target) {
		
		Enumeration en = request.getParameterNames();
		while(en.hasMoreElements()) {
			String key = (String)en.nextElement();
			target.put(key, HangulConversion.toUTF(request.getParameter(key)));
			logger.info("value : " + target);
		}
	}
	
	public void bind(Map<String, Object> target) {
		Enumeration<String> en = request.getParameterNames();
		//<input type = "text" name = "mem_id">
		while(en.hasMoreElements()) {
			String key = (String)en.nextElement();
			logger.info("value : " + request.getParameter(key));
			target.put(key, HangulConversion.toUTF(request.getParameter(key)));
			logger.info("value : " + target);
		}
	}
}

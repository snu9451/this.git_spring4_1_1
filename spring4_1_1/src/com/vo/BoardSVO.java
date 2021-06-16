package com.vo;

public class BoardSVO {
	int 	bm_no     	=	0;
	int 	bs_seq  	=	0;
	String 	bs_file 	=	"";
	int 	bs_size 	= 	0;
	private BoardMVO bmVO = null;//실제 조인시에는 이방법말고  Map을 사용
	public int getBm_no() {
		return bm_no;
	}
	public void setBm_no(int bm_no) {
		this.bm_no = bm_no;
	}
	public int getBs_seq() {
		return bs_seq;
	}
	public void setBs_seq(int bs_seq) {
		this.bs_seq = bs_seq;
	}
	public String getBs_file() {
		return bs_file;
	}
	public void setBs_file(String bs_file) {
		this.bs_file = bs_file;
	}
	public int getBs_size() {
		return bs_size;
	}
	public void setBs_size(int bs_size) {
		this.bs_size = bs_size;
	}
	public BoardMVO getBmVO() {
		return bmVO;
	}
	public void setBmVO(BoardMVO bmVO) {
		this.bmVO = bmVO;
	}
}

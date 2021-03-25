package notice;



import java.sql.Timestamp;

import util.CommonVo;

public class NoticeVo extends CommonVo {
	
	private int notice_no;
	private String notice_title;
	private String notice_contents;
	private Timestamp notice_regdate;
	private int readCnt;
	private String[] nos;
	
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_contents() {
		return notice_contents;
	}
	public void setNotice_contents(String notice_contents) {
		this.notice_contents = notice_contents;
	}
	public Timestamp getNotice_regdate() {
		return notice_regdate;
	}
	public void setNotice_regdate(Timestamp notice_regdate) {
		this.notice_regdate = notice_regdate;
	}
	public int getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	public String[] getNos() {
		return nos;
	}
	public void setNos(String[] nos) {
		this.nos = nos;
	}
	

	
	
	
	
}
	
package board;

import java.sql.Timestamp;

import util.CommonVo;

public class BoardVo extends CommonVo{
	private int board_no;
	private int user_no;

	private String filename; 		// 서버에 저장될 파일명
	private String filename_org;
	private Timestamp board_regdate;
	private String board_title;
	private String board_content;
	private int commentCount;
	private String user_name;
	private int readCnt;
	private String[] nos;
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getFilename_org() {
		return filename_org;
	}
	public void setFilename_org(String filename_org) {
		this.filename_org = filename_org;
	}
	public Timestamp getBoard_regdate() {
		return board_regdate;
	}
	public void setBoard_regdate(Timestamp board_regdate) {
		this.board_regdate = board_regdate;
	}
	public String getBoard_title() {
		return board_title;
	}
	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	
	public void setCommentVo(int commentCount) {
		this.commentCount = commentCount;
	}

}

package reply;



import java.sql.Timestamp;

import util.CommonVo;

public class ReplyVo extends CommonVo {
	private int rep_no;
	private int user_no;
	private String rep_section;
	private String rep_title;
	private String rep_content;
	private Timestamp rep_regdate;
	private int ref;
	private int seq;
	private int lev;
	private String user_name;
	private String[] nos;
	public int getRep_no() {
		return rep_no;
	}
	public void setRep_no(int rep_no) {
		this.rep_no = rep_no;
	}
	public int getUser_no() {
		return user_no;
	}
	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}
	public String getRep_section() {
		return rep_section;
	}
	public void setRep_section(String rep_section) {
		this.rep_section = rep_section;
	}
	public String getRep_title() {
		return rep_title;
	}
	public void setRep_title(String rep_title) {
		this.rep_title = rep_title;
	}
	public String getRep_content() {
		return rep_content;
	}
	public void setRep_content(String rep_content) {
		this.rep_content = rep_content;
	}
	public Timestamp getRep_regdate() {
		return rep_regdate;
	}
	public void setRep_regdate(Timestamp rep_regdate) {
		this.rep_regdate = rep_regdate;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String[] getNos() {
		return nos;
	}
	public void setNos(String[] nos) {
		this.nos = nos;
	}
	
	
	
	
	
	
	
	
	

	
}
	
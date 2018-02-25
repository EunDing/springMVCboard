package kr.koreait.VO;


import java.util.Date;

//댓글 한 건을 기억하는 클래스
public class RboardCommentVO {

	private int idx;			//글번호
	private int ref;			//어떤 글의 댓글인가 메인 글의 글번호를 기억한다.
	private String name;		//작성자
	private String password;	//비밀번호
	private String content;		//내용
	private Date wdate;		//작성일
	private String ip;			//작성자 IP
	

	public Date getWdate() {
		return wdate;
	}
	public void setWdate(Date wdate) {
		this.wdate = wdate;
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getRef() {
		return ref;
	}
	public void setRef(int ref) {
		this.ref = ref;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	@Override
	public String toString() {
		return "MRboardCommentVO [idx=" + idx + ", ref=" + ref + ", name=" + name + ", password=" + password
				+ ", content=" + content + ", wdate=" + wdate + ", ip=" + ip + "]";
	}
	
	
}

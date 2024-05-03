package egovframework.fusion.board.vo;

import java.io.Serializable;
public class ReplyVO implements Serializable {
	private static final long serialVersionUID = -8402510944659037798L;
	
	/* 댓글 */
	private Integer reply_id;
	private Integer parent_id;
	private String content;
	private String writer;
	private String del_yn;
	private String register_dt;
	private String update_dt;
	private Integer board_id;
	
	private Integer level;

	public Integer getReply_id() {
		return reply_id;
	}

	public void setReply_id(Integer reply_id) {
		this.reply_id = reply_id;
	}

	public Integer getParent_id() {
		return parent_id;
	}

	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getDel_yn() {
		return del_yn;
	}

	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}

	public String getUpdate_dt() {
		return update_dt;
	}

	public void setUpdate_dt(String update_dt) {
		this.update_dt = update_dt;
	}

	public Integer getBoard_id() {
		return board_id;
	}

	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}

	public Integer getLevel() {
		return level;
	}

	public void setLevel(Integer level) {
		this.level = level;
	}

	public String getRegister_dt() {
		return register_dt;
	}

	public void setRegister_dt(String register_dt) {
		this.register_dt = register_dt;
	}
	
	
	
}







	

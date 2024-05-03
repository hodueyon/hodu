package egovframework.fusion.board.vo;

import java.io.Serializable;

public class HistoryVO implements Serializable {
	private static final long serialVersionUID = -8402510944659037798L;
	
	private String history_id;
	private String user_name;
	private Integer board_id;
	private String cnt_date;
	
	
	public String getHistory_id() {
		return history_id;
	}
	public void setHistory_id(String history_id) {
		this.history_id = history_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public String getCnt_date() {
		return cnt_date;
	}
	public void setCnt_date(String cnt_date) {
		this.cnt_date = cnt_date;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
}

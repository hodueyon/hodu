package egovframework.fusion.studyRoom.vo;

public class ReserveVO {
	Integer reserve_id;
	String user_id;
	Integer seat_id;
	String use_start;
	String use_end;
	Integer purpose_id;
	String cancel_yn;
	
	//조인용
	Integer room_id;
	Integer seat_num;
	
	public Integer getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(Integer reserve_id) {
		this.reserve_id = reserve_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Integer getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(Integer seat_id) {
		this.seat_id = seat_id;
	}
	public String getUse_start() {
		return use_start;
	}
	public void setUse_start(String use_start) {
		this.use_start = use_start;
	}
	public String getUse_end() {
		return use_end;
	}
	public void setUse_end(String use_end) {
		this.use_end = use_end;
	}
	public Integer getPurpose_id() {
		return purpose_id;
	}
	public void setPurpose_id(Integer purpose_id) {
		this.purpose_id = purpose_id;
	}

	public String getCancel_yn() {
		return cancel_yn;
	}
	public void setCancel_yn(String cancel_yn) {
		this.cancel_yn = cancel_yn;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	
	public Integer getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(Integer seat_num) {
		this.seat_num = seat_num;
	}
	@Override
	public String toString() {
		return "ReserveVO [reserve_id=" + reserve_id + ", user_id=" + user_id + ", seat_id=" + seat_id + ", use_start="
				+ use_start + ", use_end=" + use_end + ", purpose_id=" + purpose_id + ", cancel_yn=" + cancel_yn
				+ ", room_id=" + room_id + "]";
	}
	
	
}

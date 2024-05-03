package egovframework.fusion.studyRoom.vo;

public class StudyRoomVO {
	Integer room_id;
	Integer seat_start;
	Integer seat_end;
	Integer time_start;
	Integer time_end;
	
	Integer seat_id;
	Integer reserve_id;
	String use_start;
	String use_end;
	
	//쿼리 용
	Integer usestart;
	Integer useend;
	Integer gap;
	Integer thetime;
	
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public Integer getSeat_start() {
		return seat_start;
	}
	public void setSeat_start(Integer seat_start) {
		this.seat_start = seat_start;
	}
	public Integer getSeat_end() {
		return seat_end;
	}
	public void setSeat_end(Integer seat_end) {
		this.seat_end = seat_end;
	}
	public Integer getTime_start() {
		return time_start;
	}
	public void setTime_start(Integer time_start) {
		this.time_start = time_start;
	}
	public Integer getTime_end() {
		return time_end;
	}
	public void setTime_end(Integer time_end) {
		this.time_end = time_end;
	}
	public Integer getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(Integer seat_id) {
		this.seat_id = seat_id;
	}
	public Integer getReserve_id() {
		return reserve_id;
	}
	public void setReserve_id(Integer reserve_id) {
		this.reserve_id = reserve_id;
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
	public Integer getUsestart() {
		return usestart;
	}
	public void setUsestart(Integer usestart) {
		this.usestart = usestart;
	}
	public Integer getUseend() {
		return useend;
	}
	public void setUseend(Integer useend) {
		this.useend = useend;
	}
	public Integer getGap() {
		return gap;
	}
	public void setGap(Integer gap) {
		this.gap = gap;
	}
	public Integer getThetime() {
		return thetime;
	}
	public void setThetime(Integer thetime) {
		this.thetime = thetime;
	}
	
	
	
}

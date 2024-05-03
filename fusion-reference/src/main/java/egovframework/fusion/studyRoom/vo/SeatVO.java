package egovframework.fusion.studyRoom.vo;

public class SeatVO {
	Integer seat_id;
	Integer seat_num;
	Integer room_id;
	
	Integer total;
	
	public Integer getSeat_id() {
		return seat_id;
	}
	public void setSeat_id(Integer seat_id) {
		this.seat_id = seat_id;
	}
	public Integer getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(Integer seat_num) {
		this.seat_num = seat_num;
	}
	public Integer getRoom_id() {
		return room_id;
	}
	public void setRoom_id(Integer room_id) {
		this.room_id = room_id;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "SeatVO [seat_id=" + seat_id + ", seat_num=" + seat_num + ", room_id=" + room_id + ", total=" + total
				+ "]";
	}
	
	
}

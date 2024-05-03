package egovframework.fusion.commoncode.vo;

import java.util.List;

public class SubCommonVO {
	String sub_id;
	String sub_name;
	String del_yn;
	Integer order_num;
	String upper_id;
	String explain;
	
	String lastId;
	Integer lastOrder;
	String upper_name;
	String expalin;
	
	
	private List<String> numArr;

	public String getSub_id() {
		return sub_id;
	}
	public void setSub_id(String sub_id) {
		this.sub_id = sub_id;
	}
	public String getSub_name() {
		return sub_name;
	}
	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public Integer getOrder_num() {
		return order_num;
	}
	public void setOrder_num(Integer order_num) {
		this.order_num = order_num;
	}
	public String getUpper_id() {
		return upper_id;
	}
	public void setUpper_id(String upper_id) {
		this.upper_id = upper_id;
	}
	public String getLastId() {
		return lastId;
	}
	public void setLastId(String lastId) {
		this.lastId = lastId;
	}
	public Integer getLastOrder() {
		return lastOrder;
	}
	public void setLastOrder(Integer lastOrder) {
		this.lastOrder = lastOrder;
	}
	public List<String> getNumArr() {
		return numArr;
	}
	public void setNumArr(List<String> numArr) {
		this.numArr = numArr;
	}
	public String getExplain() {
		return explain;
	}
	public void setExplain(String explain) {
		this.explain = explain;
	}
	public String getUpper_name() {
		return upper_name;
	}
	public void setUpper_name(String upper_name) {
		this.upper_name = upper_name;
	}
	public String getExpalin() {
		return expalin;
	}
	public void setExpalin(String expalin) {
		this.expalin = expalin;
	}
	
	
	
}

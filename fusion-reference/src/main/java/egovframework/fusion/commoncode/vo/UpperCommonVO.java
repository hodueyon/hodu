package egovframework.fusion.commoncode.vo;

import java.util.List;

public class UpperCommonVO {
	private String upper_id;
	private String upper_name;
	private String del_yn;
	private Integer order_num;
	private String expalin;
	
	private Integer lastOrder;
	
	private String search_type;
	private String search_word;
	
	private String uidd;
	
	private List<String> numArr;

	public String getUpper_id() {
		return upper_id;
	}
	public void setUpper_id(String upper_id) {
		this.upper_id = upper_id;
	}
	public String getUpper_name() {
		return upper_name;
	}
	public void setUpper_name(String upper_name) {
		this.upper_name = upper_name;
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
	public String getExpalin() {
		return expalin;
	}
	public void setExpalin(String expalin) {
		this.expalin = expalin;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getSearch_word() {
		return search_word;
	}
	public void setSearch_word(String search_word) {
		this.search_word = search_word;
	}
	public String getUidd() {
		return uidd;
	}
	public void setUidd(String uidd) {
		this.uidd = uidd;
	}
	
	
	
	
}

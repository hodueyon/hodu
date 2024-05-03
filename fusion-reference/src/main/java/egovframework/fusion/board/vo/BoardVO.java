/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.vo;

import java.io.Serializable;
import java.util.List;

public class BoardVO implements Serializable{

	private static final long serialVersionUID = -8402510944659037798L;

	/* 게시판 */
	private Integer board_num;
	private Integer board_id;
	private Integer category;
	private Integer parent_id;
	private String title;
	private String content;
	private String writer;
	private String del_yn;
	private String register_dt;
	private String update_dt;
	private Integer menu_id;
	
	private List<Integer> numArr;
	
	private String search_type;
	private String search_word;
	
	private Integer start;
	private Integer end;
	
	private Integer level;
	//조회수
	private Integer cnt;
	
	private String whole;
	
	//진행단계별 과제용
	private String manager;
	private String progress;
	private Integer status;
	

	public Integer getBoard_num() {
		return board_num;
	}
	public void setBoard_num(Integer board_num) {
		this.board_num = board_num;
	}

	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(String register_dt) {
		this.register_dt = register_dt;
	}
	public String getUpdate_dt() {
		return update_dt;
	}
	public void setUpdate_dt(String update_dt) {
		this.update_dt = update_dt;
	}

	public List<Integer> getNumArr() {
		return numArr;
	}
	public void setNumArr(List<Integer> numArr) {
		this.numArr = numArr;
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
	public Integer getCnt() {
		return cnt;
	}
	public void setCnt(Integer cnt) {
		this.cnt = cnt;
	}
	public Integer getStart() {
		return start;
	}
	public void setStart(Integer start) {
		this.start = start;
	}
	public Integer getEnd() {
		return end;
	}
	public void setEnd(Integer end) {
		this.end = end;
	}
	public String getWhole() {
		return whole;
	}
	public void setWhole(String whole) {
		this.whole = whole;
	}
	public Integer getLevel() {
		return level;
	}
	public void setLevel(Integer level) {
		this.level = level;
	}

	public Integer getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}
	
	
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getProgress() {
		return progress;
	}
	public void setProgress(String progress) {
		this.progress = progress;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	@Override
	public String toString() {
		return "BoardVO [board_num=" + board_num + ", board_id=" + board_id + ", category=" + category + ", parent_id="
				+ parent_id + ", title=" + title + ", content=" + content + ", writer=" + writer + ", del_yn=" + del_yn
				+ ", register_dt=" + register_dt + ", update_dt=" + update_dt + ", numArr=" + numArr + ", search_type="
				+ search_type + ", search_word=" + search_word + ", start=" + start + ", end=" + end + ", level="
				+ level + ", cnt=" + cnt + ", whole=" + whole + "]";
	}
	
	
	
	
}

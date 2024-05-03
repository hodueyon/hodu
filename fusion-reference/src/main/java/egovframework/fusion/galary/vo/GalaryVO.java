package egovframework.fusion.galary.vo;

import java.util.Arrays;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class GalaryVO {
			
	private Integer galary_id;
	private Integer category;
	private String title;
	private String content ;
	private String writer;
	private String del_yn;
	private String register_dt;
	private String update_dt;
	private Integer menu_id;
	
	//private MultipartFile[] uploadFiles;
	private CommonsMultipartFile files;
	
	
	
	//리스트 뽑는거 때문
	private String image_name;
	private String tag_name;
	private String file_name;
	private String file_route;
	
	//
	private String user_name;
	
	//조회수
	private Integer cnt;
	private Integer likescnt;
		
	//미디어 때문에요
	private String original_name;
	
	//태그땜시 ㅋㅋ
	private List<String> tagArr;
	
	//수정용
	//삭제할 이미지 리스트 
	private List<Integer> imgDelArr;
	private List<Integer> delTagArr;
	private Integer  nowThumnailId;

	//페이징
	private Integer start;
	private Integer end;
	
	private String search_type;
	private String search_word;
	private String whole;
	
	
	//전체 검색용
	private Integer board_id;
	private Integer servey_id;
	private String m_category_name;
	private String menu_name;
	private Integer bcategory;
	private Integer gcategory;
	private Integer auth_id;
	private String writername;
	
	
	//랭킹용
	private String rankType;
	private String rankword;
	
	//태그랭킹용
	private String tagType;
	
	//통계용
	private String start_date;
	private String end_date;
	private Integer varmonth;
	private Integer varyear;
	private String year;
	private String month;
	private String day;
	private String chartype;
	private String week;
	
	public Integer getGalary_id() {
		return galary_id;
	}
	public void setGalary_id(Integer galary_id) {
		this.galary_id = galary_id;
	}
	public Integer getCategory() {
		return category;
	}
	public void setCategory(Integer category) {
		this.category = category;
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
	
	
	public String getOriginal_name() {
		return original_name;
	}
	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}
	public List<String> getTagArr() {
		return tagArr;
	}
	public void setTagArr(List<String> tagArr) {
		this.tagArr = tagArr;
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
	public String getWhole() {
		return whole;
	}
	public void setWhole(String whole) {
		this.whole = whole;
	}

	public CommonsMultipartFile getFiles() {
		return files;
	}
	public void setFiles(CommonsMultipartFile files) {
		this.files = files;
	}
	public Integer getLikescnt() {
		return likescnt;
	}
	public void setLikescnt(Integer likescnt) {
		this.likescnt = likescnt;
	}
	public String getTag_name() {
		return tag_name;
	}
	public void setTag_name(String tag_name) {
		this.tag_name = tag_name;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_route() {
		return file_route;
	}
	public void setFile_route(String file_route) {
		this.file_route = file_route;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}


	public List<Integer> getDelTagArr() {
		return delTagArr;
	}
	public void setDelTagArr(List<Integer> delTagArr) {
		this.delTagArr = delTagArr;
	}
	

	public Integer getNowThumnailId() {
		return nowThumnailId;
	}
	public void setNowThumnailId(Integer nowThumnailId) {
		this.nowThumnailId = nowThumnailId;
	}
	public List<Integer> getImgDelArr() {
		return imgDelArr;
	}
	public void setImgDelArr(List<Integer> imgDelArr) {
		this.imgDelArr = imgDelArr;
	}
	public String getImage_name() {
		return image_name;
	}
	public void setImage_name(String image_name) {
		this.image_name = image_name;
	}
	public Integer getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
	}
	public Integer getServey_id() {
		return servey_id;
	}
	public void setServey_id(Integer servey_id) {
		this.servey_id = servey_id;
	}
	public String getM_category_name() {
		return m_category_name;
	}
	public void setM_category_name(String m_category_name) {
		this.m_category_name = m_category_name;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public Integer getBcategory() {
		return bcategory;
	}
	public void setBcategory(Integer bcategory) {
		this.bcategory = bcategory;
	}
	public Integer getGcategory() {
		return gcategory;
	}
	public void setGcategory(Integer gcategory) {
		this.gcategory = gcategory;
	}
	public Integer getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(Integer auth_id) {
		this.auth_id = auth_id;
	}
	public String getWritername() {
		return writername;
	}
	public void setWritername(String writername) {
		this.writername = writername;
	}
	public String getRankType() {
		return rankType;
	}
	public void setRankType(String rankType) {
		this.rankType = rankType;
	}
	public String getRankword() {
		return rankword;
	}
	public void setRankword(String rankword) {
		this.rankword = rankword;
	}
	
	public String getTagType() {
		return tagType;
	}
	public void setTagType(String tagType) {
		this.tagType = tagType;
	}
	
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public Integer getVarmonth() {
		return varmonth;
	}
	public void setVarmonth(Integer varmonth) {
		this.varmonth = varmonth;
	}
	public Integer getVaryear() {
		return varyear;
	}
	public void setVaryear(Integer varyear) {
		this.varyear = varyear;
	}
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	
	public String getChartype() {
		return chartype;
	}
	public void setChartype(String chartype) {
		this.chartype = chartype;
	}
	
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	@Override
	public String toString() {
		return "GalaryVO [category=" + category + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ "]";
	}
	
	
	
	
	
	
}

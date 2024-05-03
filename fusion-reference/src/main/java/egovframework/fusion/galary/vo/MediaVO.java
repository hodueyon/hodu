package egovframework.fusion.galary.vo;

/**
 * @author ihyeonPark
 *
 */
public class MediaVO {
	
	private Integer media_id;
	private String original_name;
	private String file_name;
	private String file_route;
	private String del_yn;
	private String thumnail_yn;
	private Integer galary_id;
	private long file_size;
	private Integer down_cnt;
	private String del_date;
	
	
	//파일저장떄
	private String uuid;
	
	
	public Integer getMedia_id() {
		return media_id;
	}
	public void setMedia_id(Integer media_id) {
		this.media_id = media_id;
	}
	public String getOriginal_name() {
		return original_name;
	}
	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
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
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getThumnail_yn() {
		return thumnail_yn;
	}
	public void setThumnail_yn(String thumnail_yn) {
		this.thumnail_yn = thumnail_yn;
	}
	public Integer getGalary_id() {
		return galary_id;
	}
	public void setGalary_id(Integer galary_id) {
		this.galary_id = galary_id;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public Integer getDown_cnt() {
		return down_cnt;
	}
	public void setDown_cnt(Integer down_cnt) {
		this.down_cnt = down_cnt;
	}
	public String getDel_date() {
		return del_date;
	}
	public void setDel_date(String del_date) {
		this.del_date = del_date;
	}
	
	

}
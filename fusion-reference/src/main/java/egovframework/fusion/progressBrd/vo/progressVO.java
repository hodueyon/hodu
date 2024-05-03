package egovframework.fusion.progressBrd.vo;

public class progressVO {
	private Integer board_id;
	private String title;
	private  String content;
	private String writer;
	private String register_dt;
	private Integer menu_id;
	private String manager;
	private String progress;
	private Integer status;
	
	private String writer_name;
	private String mag_name;

	
	
	private Integer start;
	private Integer end;
	
	public Integer getBoard_id() {
		return board_id;
	}
	public void setBoard_id(Integer board_id) {
		this.board_id = board_id;
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
	public String getRegister_dt() {
		return register_dt;
	}
	public void setRegister_dt(String register_dt) {
		this.register_dt = register_dt;
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
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
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
	public String getWriter_name() {
		return writer_name;
	}
	public void setWriter_name(String writer_name) {
		this.writer_name = writer_name;
	}
	public String getMag_name() {
		return mag_name;
	}
	public void setMag_name(String mag_name) {
		this.mag_name = mag_name;
	}
	@Override
	public String toString() {
		return "progressVO [board_id=" + board_id + ", title=" + title + ", content=" + content + ", writer=" + writer
				+ ", register_dt=" + register_dt + ", menu_id=" + menu_id + ", manager=" + manager + ", progress="
				+ progress + ", status=" + status + ", writer_name=" + writer_name + ", mag_name=" + mag_name
				+ ", start=" + start + ", end=" + end + "]";
	}
	
	
}

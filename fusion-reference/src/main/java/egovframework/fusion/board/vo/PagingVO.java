package egovframework.fusion.board.vo;

import java.io.Serializable;

public class PagingVO implements Serializable {
	private static final long serialVersionUID = -8402510944659037798L;
	
	private Integer nowPage;
	private Integer startPage;
	private Integer endPage;
	private Integer total;
	//페이지당 글 갯수 
	private Integer cntPerPage; 
	private Integer lastPage;
	
	//쿼리용
	private Integer start;
	private Integer end;
	//페이징 갯수? 
	private Integer cntPage = 5;

	
	public Integer getNowPage() {
		return nowPage;
	}
	public void setNowPage(Integer nowPage) {
		this.nowPage = nowPage;
	}
	public Integer getStartPage() {
		return startPage;
	}
	public void setStartPage(Integer startPage) {
		this.startPage = startPage;
	}
	public Integer getEndPage() {
		return endPage;
	}
	public void setEndPage(Integer endPage) {
		this.endPage = endPage;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(Integer total) {
		this.total = total;
	}
	public Integer getCntPerPage() {
		return cntPerPage;
	}
	public void setCntPerPage(Integer cntPerPage) {
		this.cntPerPage = cntPerPage;
	}
	public Integer getLastPage() {
		return lastPage;
	}
	public void setLastPage(Integer lastPage) {
		this.lastPage = lastPage;
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
	public Integer getCntPage() {
		return cntPage;
	}
	public void setCntPage(Integer cntPage) {
		this.cntPage = cntPage;
	}
	
	public PagingVO() {
		
	}
	public PagingVO(Integer nowPage, Integer cntPerPage) {
		this.nowPage = nowPage;
		this.cntPerPage = cntPerPage;
	}
	public PagingVO(Integer total, Integer nowPage, Integer cntPerPage) {
		this.total = total;
		this.nowPage = nowPage;
		this.cntPerPage = cntPerPage;
	}
	public PagingVO(Integer nowPage, Integer startPage, Integer endPage, Integer total, Integer cntPerPage,
			Integer lastPage, Integer start, Integer end, Integer cntPage) {
		super();
		this.nowPage = nowPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.total = total;
		this.cntPerPage = cntPerPage;
		this.lastPage = lastPage;
		this.start = start;
		this.end = end;
		this.cntPage = cntPage;
	}
	@Override
	public String toString() {
		return "PagingVO [nowPage=" + nowPage + ", startPage=" + startPage + ", endPage=" + endPage + ", total=" + total
				+ ", cntPerPage=" + cntPerPage + ", lastPage=" + lastPage + ", start=" + start + ", end=" + end
				+ ", cntPage=" + cntPage + "]";
	}
	
	
}

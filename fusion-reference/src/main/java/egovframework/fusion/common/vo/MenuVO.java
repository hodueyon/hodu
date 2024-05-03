package egovframework.fusion.common.vo;

public class MenuVO {
	private Integer menu_id;
	private String menu_name;
	private Integer auth_id ;
	private String menu_url;
	private Integer menu_category;
	
	private String auth_name;
	private Integer m_category_id;
	private String m_category_name;
	
	public Integer getMenu_id() {
		return menu_id;
	}
	public void setMenu_id(Integer menu_id) {
		this.menu_id = menu_id;
	}
	public String getMenu_name() {
		return menu_name;
	}
	public void setMenu_name(String menu_name) {
		this.menu_name = menu_name;
	}
	public Integer getAuth_id() {
		return auth_id;
	}
	public void setAuth_id(Integer auth_id) {
		this.auth_id = auth_id;
	}
	public String getMenu_url() {
		return menu_url;
	}
	public void setMenu_url(String menu_url) {
		this.menu_url = menu_url;
	}
	public String getAuth_name() {
		return auth_name;
	}
	public void setAuth_name(String auth_name) {
		this.auth_name = auth_name;
	}
	public String getM_category_name() {
		return m_category_name;
	}
	public void setM_category_name(String m_category_name) {
		this.m_category_name = m_category_name;
	}
	public Integer getM_category_id() {
		return m_category_id;
	}
	public void setM_category_id(Integer m_category_id) {
		this.m_category_id = m_category_id;
	}
	public Integer getMenu_category() {
		return menu_category;
	}
	public void setMenu_category(Integer menu_category) {
		this.menu_category = menu_category;
	}
	
	
	
}

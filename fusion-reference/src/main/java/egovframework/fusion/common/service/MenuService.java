package egovframework.fusion.common.service;

import java.util.List;

import egovframework.fusion.common.vo.MenuHistoryVO;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.galary.vo.GalaryVO;


public interface MenuService {

	//조회
	public List<MenuVO> menulist(Integer auth);
	
	public List<MenuVO> getCategory();
	public List<MenuVO> getAuthes();
	
	//수정
	public void updateMenu(MenuVO vo);
	
	//메뉴삭제
	public void delMenu(Integer menuid );
	
	//메뉴등록
	public void insMenu(MenuVO vo);
	
	//시퀀스 메뉴 아이디
	public Integer makemenuid();
	
	//메뉴건
	public MenuVO getmenu(Integer menuid);
	
	//메뉴 이동 로그 기록 
	public void inputMenuRecord(MenuHistoryVO vo );
	
	//url로 메뉴정보 찾기
	public MenuVO getmenubyurl(String url);
	
	//통계
	public List<MenuHistoryVO> getStatic(MenuHistoryVO vo);
	
	//밑에는 나중에 다 합치자 
	
	//연별 조회
	public List<MenuHistoryVO> yearStatic(MenuHistoryVO vo);
	
	
	//시간대별 통계
	public List<MenuHistoryVO> timeStatic(MenuHistoryVO vo);
	
	//월별
	public List<MenuHistoryVO> monthStatic(MenuHistoryVO vo);
	//일별
	public List<MenuHistoryVO> dayStatic(MenuHistoryVO vo);
	
	//전체 검색 !
	public List<GalaryVO> headerSrchList(GalaryVO vo);
	
	public Integer ckmenuname(MenuVO vo);

	//갤러리 매뉴만 뽑기
		public List<MenuVO> galaryMenu();
	
}

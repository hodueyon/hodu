package egovframework.fusion.common.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.common.vo.MenuHistoryVO;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.galary.vo.GalaryVO;

@Service
public class MenuServiceImpl implements MenuService {

	@Autowired
	MenuMapper menuMapper;
	
	@Override
	public List<MenuVO> menulist(Integer auth) {
		// TODO Auto-generated method stub
		return  menuMapper.menulist(auth);
	}

	@Override
	public List<MenuVO> getCategory() {
		// TODO Auto-generated method stub
		return menuMapper.getCategory();
	}

	@Override
	public List<MenuVO> getAuthes() {
		// TODO Auto-generated method stub
		return menuMapper.getAuthes();
	}

	@Override
	public void insMenu(MenuVO vo) {
		menuMapper.insMenu(vo);
		
	}

	@Override
	public Integer makemenuid() {
		// TODO Auto-generated method stub
		return menuMapper.makemenuid();
	}

	@Override
	public void updateMenu(MenuVO vo) {
		menuMapper.updateMenu(vo);
		
	}

	@Override
	public void delMenu(Integer menuid) {
		menuMapper.delMenu(menuid);
		
	}

	@Override
	public MenuVO getmenu(Integer menuid) {
		// TODO Auto-generated method stub
		return menuMapper.getmenu(menuid);
	}

	@Override
	public void inputMenuRecord(MenuHistoryVO vo) {
		menuMapper.inputMenuRecord(vo);
		
	}

	@Override
	public MenuVO getmenubyurl(String url) {
		// TODO Auto-generated method stub
		return menuMapper.getmenubyurl(url);
	}

	@Override
	public List<MenuHistoryVO> getStatic(MenuHistoryVO vo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MenuHistoryVO> yearStatic(MenuHistoryVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.yearStatic(vo);
	}

	@Override
	public List<MenuHistoryVO> timeStatic(MenuHistoryVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.timeStatic(vo);
	}

	@Override
	public List<MenuHistoryVO> monthStatic(MenuHistoryVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.monthStatic(vo);
	}

	@Override
	public List<MenuHistoryVO> dayStatic(MenuHistoryVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.dayStatic(vo);
	}

	@Override
	public List<GalaryVO> headerSrchList(GalaryVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.headerSrchList(vo);
	}

	@Override
	public Integer ckmenuname(MenuVO vo) {
		// TODO Auto-generated method stub
		return menuMapper.ckmenuname(vo);
	}

	@Override
	public List<MenuVO> galaryMenu() {
		// TODO Auto-generated method stub
		return menuMapper.galaryMenu();
	}

}

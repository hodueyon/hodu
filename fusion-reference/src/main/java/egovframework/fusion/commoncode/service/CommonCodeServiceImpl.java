package egovframework.fusion.commoncode.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.commoncode.vo.UpperCommonVO;

@Service
public class CommonCodeServiceImpl implements CommonCodeService {

	
	@Autowired
	CommonCodeMapper mapper;

	@Override
	public List<UpperCommonVO> upperList(UpperCommonVO vo) {
		// TODO Auto-generated method stub
		return mapper.upperList(vo);
	}

	@Override
	public List<SubCommonVO> subList(UpperCommonVO vo) {
		// TODO Auto-generated method stub
		return mapper.subList(vo);
	}

	@Override
	public void insertUpper(UpperCommonVO vo) {
		// 아이디 순서 찾기
		
		vo.setUpper_id(mapper.findLastIdOrder().getUpper_id());
		
		if(mapper.findLastIdOrder().getOrder_num() == 0) {
			vo.setOrder_num(1);
		}else {
			vo.setOrder_num(mapper.findLastIdOrder().getOrder_num()+1);
		}
		
		mapper.insertUpper(vo);
	}

	@Override
	public void insertSub(SubCommonVO vo) {
		// TODO Auto-generated method stub
		
		Integer num = mapper.findLastOrder(vo);
		
		if(num == null) {
			vo.setOrder_num(1);
		}else {
			vo.setOrder_num(num+1);
		}
		
		mapper.insertSub(vo);
	}

	@Override
	public void delUpper(UpperCommonVO vo) {
		// TODO Auto-generated method stub
		mapper.delUpper(vo);
	}

	@Override
	public void delSub(SubCommonVO vo) {
		// TODO Auto-generated method stub
		mapper.delSub(vo);
	}

	@Override
	public SubCommonVO getUpperSubInfo(String subid) {
		// TODO Auto-generated method stub
		return mapper.getUpperSubInfo(subid);
	}

	@Override
	public void updateUpper(UpperCommonVO vo) {
		// TODO Auto-generated method stub
		mapper.updateUpper(vo);
	}

	@Override
	public void updateSub(SubCommonVO vo) {
		// TODO Auto-generated method stub
		mapper.updateSub(vo);
	}

	@Override
	public String cksBeforDel(UpperCommonVO vo) {
		
		String msg ="잉";
		List<String> arr = vo.getNumArr(); 
		for(int i = 0; i<arr.size(); i++) {
			UpperCommonVO uvo = new UpperCommonVO();
			uvo.setUpper_id(arr.get(i));
			
			List<SubCommonVO> list = mapper.subList(uvo);
			if(list.size() >=1) {
				msg = "false";
				break;
			}else {
				msg = "true";
			}
		}
		return msg;
	}

	@Override
	public Integer upperDuplicateCk(UpperCommonVO vo) {
		// TODO Auto-generated method stub
		return mapper.upperDuplicateCk(vo);
	}

	@Override
	public Integer subDuplicateCk(SubCommonVO vo) {
		// TODO Auto-generated method stub
		return mapper.subDuplicateCk(vo);
	}

	@Override
	public List<SubCommonVO> korealocations() {
		// TODO Auto-generated method stub
		
		return mapper.korealocations();
	}

	@Override
	public UpperCommonVO findLastIdOrder() {
		// TODO Auto-generated method stub
		return mapper.findLastIdOrder();
	}
}

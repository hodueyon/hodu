package egovframework.fusion.user.service;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.user.vo.UserVO;

@Mapper
public interface UserMapper {

	//회원가입
	public void insUser(UserVO vo);
	
	//아이디 중복 체크
	public Integer getCheckId(UserVO vo);
	
	//로그인
	public UserVO getUser(UserVO vo);

	//회원리스트
	public List<UserVO> getUserList();
}


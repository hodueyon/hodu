package egovframework.fusion.user.service;

import java.util.List;

import egovframework.fusion.user.vo.UserVO;

public interface UserService {
	
	//회원가입
	public void insUser(UserVO vo);
	
	//아이디 중복 체크
	public Integer getCheckId(UserVO vo);
	
	//로그인
	public String getUser(UserVO vo);
	
	//유저조회
	public UserVO getUserInfo(UserVO vo);
	
	//회원리스트
		public List<UserVO> getUserList();
}

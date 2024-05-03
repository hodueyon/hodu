package egovframework.fusion.user.service;

import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.user.vo.UserVO;

@Service
public class UserServiceImpl  extends EgovAbstractServiceImpl implements UserService {


private static final Logger LOGGER = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	UserMapper userMapper;
	
	@Override
	public void insUser(UserVO vo) {
		
		//암호화
		vo.setPassword(BCrypt.hashpw(vo.getPassword(), BCrypt.gensalt()));
		
		userMapper.insUser(vo);
	}
	
	@Override
	public Integer getCheckId(UserVO vo) {
		Integer num = userMapper.getCheckId(vo);
		return num;
	}

	@Override
	public String getUser(UserVO vo) {
	    UserVO userVO = userMapper.getUser(vo);
	    String passwd = vo.getPassword();
	    System.out.println(passwd);
	    System.out.println();
	    String msg = "";
	    if(userVO == null){
	        msg = "noInfo";
	    } else if(!BCrypt.checkpw(passwd, userVO.getPassword())){
	        msg = "notPw";
	    } else {
	    	msg = "yes";
	    }
	    return msg;
	}

	@Override
	public UserVO getUserInfo(UserVO vo) {
		// TODO Auto-generated method stub
		return userMapper.getUser(vo);
	}

	@Override
	public List<UserVO> getUserList() {
		// TODO Auto-generated method stub
		return	userMapper.getUserList();
	}
}
package egovframework.fusion.sns.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.server.ResponseStatusException;

import com.google.gson.JsonObject;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.board.service.ReplyService;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.sns.service.SnsService;
import egovframework.fusion.sns.vo.SnsLikeVO;
import egovframework.fusion.sns.vo.SnsReplyVO;
import egovframework.fusion.sns.vo.SnsVO;

@Controller
public class SnsController {
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ReplyService replyService;
	
	@Autowired
	SnsService snsService;
	
	//sns페이지이동
	@RequestMapping(value="/sns/snsList.do" , method = RequestMethod.GET)
	public String snsList(
				@RequestParam(value="menu_id", required = false)Integer menu_id, Model model
				,HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		
		//권한체크 - 1번더
		model.addAttribute("menuid", menu_id);
		//세션에서 값 가져오기 - writer
		Object oId = session.getAttribute("writerId");
		//글등록
		
		SnsVO vo = new SnsVO();
		
		if (oId != null) {
			String loginId  = (String) oId.toString();
			Integer auth =  (Integer) session.getAttribute("auth");
			model.addAttribute("loginId", loginId);
			//model.addAttribute("auth", auth);
		}
		
		return "views/sns/snsPage";
	}
	
	//무한스크롤!
	@RequestMapping(value="/sns/getsnsList.do" , method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getSnsList(
			HttpSession session, HttpServletRequest request, HttpServletResponse response
			,
			@RequestParam(value = "nowPage", required = false) Integer nowPage,
			@RequestParam(value = "cntPerPage", required = false) Integer cntPerPage,
			@RequestParam(value="search_type", required= false)String search_type,
			@RequestParam(value="search_word", required= false)String search_word,
			@RequestParam(value="menu_id", required = false)Integer menu_id
			) {
		

		//권한체크 - 1번더
		Object oId = session.getAttribute("writerId");
		//글등록
		//세션에서 값 가져오기 - writer
		SnsVO vo = new SnsVO();
		
		if (oId != null) {
			String loginId = (String) oId.toString();
			vo.setUser_id(loginId);
		}else {
			vo.setUser_id(null);
		}
		//Integer cntPerPage = 5;
		//Integer nowPage = 1;
		
		System.out.println("ddddd" + vo.getUser_id());
		Map<String,Object> map = new HashMap<>();
				
		if(cntPerPage == null) {
			vo.setCntPerPage(5);
			cntPerPage=  5;
			request.setAttribute("cntPerPage", 5);
		}else {
			vo.setCntPerPage(cntPerPage);
			map.put("cntPerPage", cntPerPage);
			request.setAttribute("cntPerPage", cntPerPage);

		}
		
		if(search_type != null) {
			if(search_word != null) {
				vo.setSearch_type(search_type);
				vo.setSearch_word(search_word);
				map.put("searchType", vo.getSearch_type());
				request.setAttribute("searchType", search_type);
				request.setAttribute("searchWord", search_word);
						
			}
		}
		
		if(nowPage == null) {
			vo.setNowPage(1);
			nowPage = 1;
		}else {
			vo.setNowPage(nowPage);
			
		}
		int start = (nowPage -1)*cntPerPage+1;
		
		vo.setMenu_id(menu_id);
		vo.setStart(start);
		

		System.out.println("dddd111!"+ vo.toString());
		List<SnsVO> SnsList = snsService.snslist(vo);
		
		
		for(int i=0; i<SnsList.size(); i++) {
			SnsList.get(i).getContent();
		}
		map.put("SnsList", SnsList);
		
		return map;
	}
	
	//이미지 파일 등록
	 @RequestMapping(value="/sns/imageUpload.do", method = RequestMethod.POST)
	 @ResponseBody
		public String fileUpload(HttpServletRequest request, HttpServletResponse response,
				MultipartHttpServletRequest multiFile) throws IOException {
		
			
			JsonObject json = new JsonObject();
			// Json 객체를 출력하
			PrintWriter printWriter = null;
			OutputStream out = null;
			
			MultipartFile file = multiFile.getFile("upload");
			
			if (file != null) {
				
				if (file.getSize() > 0 && StringUtils.isNotBlank(file.getOriginalFilename())) {
					if (file.getContentType().toLowerCase().startsWith("image/")) {

						try {
							
							String OriginalName = file.getOriginalFilename();
							
							byte[] bytes;
							//파일을 바이트 타입으로 변경
							bytes = file.getBytes();
							//파일이 실제로 저장되는 경로 
							String uploadPath = "C:/snsUpload/";
							
							File uploadFile = new File(uploadPath);
							if (!uploadFile.exists()) {
								uploadFile.mkdirs();
							}
							
							String fileName = UUID.randomUUID().toString()+OriginalName;
							
							uploadPath = uploadPath + "/" + fileName;
							out = new FileOutputStream(new File(uploadPath));
							out.write(bytes);
							
							//클라이언트에 이벤트 추가
							printWriter = response.getWriter();
							response.setContentType("text/html");
							
							String encodName = URLEncoder.encode(fileName, "UTF-8");
							//이미지 가져오는 url 
							String fileUrl = "/snsfile/" + encodName;
							
							//ck에디터에 보낼값 넣어주고 보내기
							json.addProperty("uploaded", 1);
							json.addProperty("fileName", fileName);
							json.addProperty("url", fileUrl);
							printWriter.println(json);
						} catch (IOException e) {
							e.printStackTrace();
						} finally {
							if(out !=null) {
								out.close();
							}
							if(printWriter != null) {
								printWriter.close();
							}
						}
					}
				}
			}
				return null;
		}

	
	
	//글등록
	@RequestMapping(value="/sns/inputSns.do" , method = RequestMethod.POST,  produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<SnsVO> inputSns(@RequestBody SnsVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		//글등록
		//세션에서 값 가져오기 - writer
		vo.setWriter(loginId);
		
		snsService.insertSns(vo);
		
		
		//sns리스트 가져오기
		List<SnsVO> list = snsService.snslist(vo);
		return list;
	}
	
	//글 삭제
	@RequestMapping(value="/sns/delSns.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsVO> delSns(@RequestBody SnsVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		snsService.delSns(vo);
		
		//sns리스트 가져오기
		List<SnsVO> list = snsService.snslist(vo);
		return list;
	}
	
	//글수정
	@RequestMapping(value="/sns/updateSns.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsVO> updateSns(@RequestBody SnsVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		Integer snsnum =  vo.getSns_id();
		snsService.updateSns(vo);
		
		//sns리스트 가져오기
		List<SnsVO> list = snsService.snslist(vo);
		return list;
	}
	
	
	//좋아요
	@RequestMapping(value="/sns/addLike.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsVO> inputLike(@RequestBody SnsLikeVO vo) {

		//좋아요 등록
		snsService.inputLike(vo);
		
		SnsVO svo = new SnsVO();
		svo.setUser_id(vo.getUser_id());
		svo.setMenu_id(vo.getMenu_id());
		svo.setCntPerPage(vo.getCntPerPage());
		svo.setStart(1);
		
		//리스트받아오기
		List<SnsVO> list = snsService.snslist(svo);
		list.forEach(System.out::println);
		return list;
	}
	
	//좋아요취소
	@RequestMapping(value="/sns/delLike.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsVO> delLike(@RequestBody SnsLikeVO vo) {

		//좋아요 등록
		snsService.delLIke(vo);
		
		SnsVO svo = new SnsVO();
		svo.setUser_id(vo.getUser_id());
		svo.setMenu_id(vo.getMenu_id());
		svo.setCntPerPage(vo.getCntPerPage());
		svo.setStart(1);
		//리스트받아오기
		List<SnsVO> list = snsService.snslist(svo);
		
		return list;
	}
	
	//댓글불러오기
	@RequestMapping(value="/sns/replyList.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsReplyVO> replyeList(@RequestBody SnsReplyVO vo) {
		
		//댓글리스트
		List<SnsReplyVO> replies = snsService.replylist(vo.getBrd_id());
		
		return replies;
	}
	
	//댓글등록
	@RequestMapping(value="/sns/inputReply.do" , method = RequestMethod.POST)
	@ResponseBody
	public List<SnsReplyVO> inputReply(@RequestBody SnsReplyVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		Object oId = session.getAttribute("writerId");
		String loginId = (String) oId.toString();
		vo.setWriter(loginId);
		//댓글등록
		snsService.inputReply(vo);
		
		
		//댓글리스트
		List<SnsReplyVO> replies = snsService.replylist(vo.getBrd_id());
		
		return replies;
	}
	
	//댓글삭제
	@RequestMapping(value="/sns/delReply.do", method = RequestMethod.POST)
	@ResponseBody
	public List<SnsReplyVO> delReply(@RequestBody SnsReplyVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		
		//댓글등록
		snsService.delReply(vo);
		
		
		//댓글리스트
		List<SnsReplyVO> replies = snsService.replylist(vo.getBrd_id());
		
		return replies;
	}
	
	//댓글수정
	@RequestMapping(value="/sns/updateReply.do", method = RequestMethod.POST)
	//@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public ResponseEntity<List<SnsReplyVO>> updateReply(@RequestBody SnsReplyVO vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws IOException {
		//권한확인
		Object oauth = session.getAttribute("auth");
		Object oId = session.getAttribute("writerId");

		Integer auth = 4;
		String login = "";
		if(oauth == null) {
			auth = 4; 
		}else {
			auth =  (Integer) session.getAttribute("auth");
		}
		
		if(oId != null) {
			login = (String) oId;
		}
		String writer = snsService.getReply(vo.getReply_id()).getWriter();
		
		//권한없을때 
		if(writer != login ||  auth != 1) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Collections.emptyList());
		}

		snsService.updateReply(vo);
		List<SnsReplyVO> list = snsService.replylist(vo.getBrd_id());
		return ResponseEntity.status(HttpStatus.OK).body(list) ;
	}
	
	//기능시 권한체크
	@RequestMapping(value="/sns/ckAuth.do", method = RequestMethod.POST)
	@ResponseBody
	public String ckAuth( HttpServletRequest request,
			HttpServletResponse response, HttpSession session,
			@RequestParam(value = "methodNum", required = false) Integer methodNum,
			@RequestParam(value = "menu_id", required = false) Integer menu_id,
			@RequestParam(value="sns_id", required= false)Integer sns_id,
			@RequestParam(value="reply_id", required= false)Integer reply_id) {
		
		String msg = "dd";
		Object oauth = session.getAttribute("auth");
		Object oId = session.getAttribute("writerId");

		Integer auth = 4;
		
		if(oauth == null) {
			auth = 4; 
		}else {
			auth =  (Integer) session.getAttribute("auth");
		}
		
		if(sns_id != null) {
			
		}
		//
		if(methodNum == 1) {
			//글등록 권한 확인
		
		}
		
		return msg;
	}
}

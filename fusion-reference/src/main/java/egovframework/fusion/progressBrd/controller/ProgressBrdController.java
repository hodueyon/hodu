package egovframework.fusion.progressBrd.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;

import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.board.vo.PagingVO;
import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.commoncode.vo.SubCommonVO;
import egovframework.fusion.progressBrd.service.ProgressService;
import egovframework.fusion.progressBrd.vo.ObjectVO;
import egovframework.fusion.progressBrd.vo.ckoverVO;
import egovframework.fusion.progressBrd.vo.progressVO;
import egovframework.fusion.sns.vo.SnsVO;

@Controller
public class ProgressBrdController {
	
	@Autowired
	ProgressService pservice;
	
	@Autowired
	MenuService menuService;
	
	//리스트
		@RequestMapping(value = "/progress/boardList.do", method = RequestMethod.GET)
		public String progressBrdList(PagingVO pagingVo ,Model model,
				@RequestParam(value = "nowPage", required = false) Integer nowPage,
				@RequestParam(value = "cntPerPage", required = false) Integer cntPerPage,
				@RequestParam(value="menu_id", required = false)Integer menu_id,
				@RequestParam(value="progress", required = false)String progress,
				HttpServletRequest request,
				HttpServletResponse response) {
			
			HttpSession session = request.getSession();
			Object oId = session.getAttribute("writerId");
			String loginId = (String) oId.toString();
			
			Integer auth = (Integer) session.getAttribute("auth");
			

			if (loginId != null) {
				model.addAttribute("loginId", loginId);
				model.addAttribute("auth", auth);
			}

			progressVO vo = new progressVO();
			
			if (nowPage == null) {
				nowPage = 1;
			}
			if (cntPerPage == null) {
				cntPerPage = 5;
			}
			
			if(cntPerPage != null) {
				model.addAttribute("cntPerPage", cntPerPage);
			}
			
			if(menu_id == null) {
				menu_id = 43;
			}
			
			
			//사용자인지 관리자인지 체크
			if(auth <3) {
				//관리자
				vo.setManager(loginId);
				model.addAttribute("tabs", pservice.getMagTabs());
				if(progress == null) {
					progress = pservice.getMagTabs().get(0).getSub_id();
				}
			}else {
				vo.setWriter(loginId);
				if(progress == null) {	
					if( pservice.getmyTabs(vo).size() == 0) {
						System.out.println("잉잉!");
						progress ="E01";
						model.addAttribute("tabs", pservice.getTabsForNoBrd());
					}else {
						System.out.println("잘들어옴!");
						progress = pservice.getmyTabs(vo).get(0).getSub_id();
						model.addAttribute("tabs", pservice.getmyTabs(vo));
					}
				}else {
					System.out.println("잘들어옴2!");
					model.addAttribute("tabs", pservice.getmyTabs(vo));
				}
			}
			

			Integer cntPage = 5;
			Integer endPage = 0;
			Integer startPage = 0;
			Integer lastPage = 0;
			Integer nowBlock = 0;
			
			//수정
			//수정
			vo.setProgress(progress);
			vo.setMenu_id(menu_id);
			Integer total = pservice.cntTotal(vo);
			//쿼리용
			int start = (nowPage-1)*cntPerPage+1;
			int end = nowPage*cntPerPage;
			
			vo.setStart(start); 
			vo.setEnd(end);
			
			
			//현재 나의 블록 
			nowBlock = (int) Math.ceil((double) nowPage / cntPage);
			//시작페이징
			startPage = (nowBlock - 1) * cntPage + 1;
			lastPage = (int) Math.ceil((double) total / cntPerPage);
			
			
			//더 작은수 리턴
			endPage = Math.min((startPage + (cntPage - 1)), lastPage);

			PagingVO pvo = new PagingVO(nowPage, startPage, endPage, total, cntPerPage,lastPage, start, end, cntPage);
			List<progressVO> boardList = pservice.getAllBrd(vo);
			

			model.addAttribute("menu_id", menu_id);
			model.addAttribute("total", total);
			model.addAttribute("paging", pvo);
			model.addAttribute("boardList", boardList);
			model.addAttribute("nowPage", pvo.getNowPage());
			model.addAttribute("cntperpage", pvo.getCntPerPage());
			model.addAttribute("menu_id", menu_id);
			model.addAttribute("progress", progress);
			
			return "views/progressBrd/brdList";
				
		}
		
		//글작성페이지 
		@RequestMapping(value = "/progress/boardRegister.do", method = RequestMethod.GET)
		public String boardRegister(Integer menu_id,String progress,Integer cntPerPage, Integer nowPage, Model model,HttpServletRequest request, HttpServletResponse response) {
			HttpSession session = request.getSession(); 
			//메뉴뿌리기용
			Integer auth = (Integer) session.getAttribute("auth");
			List<MenuVO> menulist = menuService.menulist(auth);
			
			model.addAttribute("menulists", menulist);
			
			menu_id = 43;
			model.addAttribute("menu_id", menu_id);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("cntperpage", cntPerPage);
			model.addAttribute("progress", progress);
			
			//관리자리스트
			model.addAttribute("manageList", pservice.managerList());
			
			return "views/progressBrd/registerBrd";
			
		}
		
		
		
		//글등록
		@RequestMapping(value="/progress/inputBrd.do" , method = RequestMethod.POST)
		@ResponseBody
		public String inputSns(@RequestBody progressVO vo, HttpServletRequest request,
				HttpServletResponse response, HttpSession session) {
			
			
			Object oId = session.getAttribute("writerId");
			String loginId = (String) oId.toString();
			//글등록
			//세션에서 값 가져오기 - writer
			vo.setWriter(loginId);
			pservice.inputBrd(vo);

			return " gg";
		}
		
		
		//이미지 파일 등록
		 @RequestMapping(value="/progress/imageUpload.do", method = RequestMethod.POST)
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
								String uploadPath = "C:/progressUpload/";
								
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
								String fileUrl = "/progressFile/" + encodName;
								
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
		 
		 
		 //글읽기
		 @RequestMapping(value="/progress/getPost.do", method = RequestMethod.GET)
		 public String readBoardPost(Integer board_id,String progress,Integer menu_id, Integer cntPerPage, Integer nowPage, Model model,HttpServletRequest request, HttpServletResponse response) {
				HttpSession session = request.getSession(); 
				//메뉴뿌리기용
				Integer auth = (Integer) session.getAttribute("auth");
				

				List<MenuVO> menulist = menuService.menulist(auth);
				model.addAttribute("menulists", menulist);

				model.addAttribute("auth", auth);
				
				progressVO vo = new progressVO();
				
				//탭가져오기
		
				model.addAttribute("tabs", pservice.getMagTabs());
			
				model.addAttribute("boardPost", pservice.getOnePost(board_id));
				model.addAttribute("menu_id", menu_id);
				model.addAttribute("cntPerPage", cntPerPage);
				model.addAttribute("nowPage", nowPage);
				model.addAttribute("progress", progress);
				
				//첫검토 불러오기
				model.addAttribute("firstFeedback", pservice.getFirstFeedback(board_id));
				
				//가장 최근의 이의제기 가져오기
				model.addAttribute("recentObject", pservice.getRecentObject(board_id));
				if(pservice.getRecentObject(board_id) != null) {
					String con = pservice.getRecentObject(board_id).getUser_content().replaceAll("\n", "\\\\n" );
					model.addAttribute("newcon" , con );
				}
				//이의제기 횟수
				model.addAttribute("objectCnt", pservice.cntObject(board_id));
				
				return "views/progressBrd/getPost";
				
		}
		 
		 //관리자- 첫 검토
		 @RequestMapping(value="/progress/inputDecision.do", method = RequestMethod.POST)
		 @ResponseBody
		 public String inputDecusuib(@RequestBody ckoverVO vo,HttpServletRequest request, HttpServletResponse response) {
				

				//첫검토 등록...
				pservice.inputFirstDecision(vo);
				
				progressVO progress = new progressVO();
				if(vo.getStatus() == 1) {
					progress.setProgress("E04");
				}else {
					progress.setProgress("E02");
				}
				
				progress.setBoard_id(vo.getBoard_id());
				
				progress.setStatus(vo.getStatus());
				
				//검토중으로 수정하기 
				pservice.updateStepStatus(progress);
				return "/progressBrd/getPost";
				
		}
		 
	 	//글 수정 페이지
		@RequestMapping(value = "/progress/boardEditFrm.do", method = RequestMethod.GET)
		public String boardEditFrm(Integer board_id, String progress,Integer cntPerPage, Integer nowPage,Integer menu_id,  Model model,HttpServletRequest request, HttpServletResponse response) {
			HttpSession session = request.getSession(); 
			//메뉴뿌리기용
			Integer auth = (Integer) session.getAttribute("auth");
			
			List<MenuVO> menulist = menuService.menulist(auth);
			model.addAttribute("menulists", menulist);


			menu_id = 43;
			model.addAttribute("menu_id", menu_id);
			model.addAttribute("cntPerPage", cntPerPage);
			model.addAttribute("nowPage", nowPage);
			model.addAttribute("boardPost", pservice.getOnePost(board_id));
			
			//관리자리스트
			model.addAttribute("manageList", pservice.managerList());
			
			return "views/progressBrd/boardPostModify";
			
		}
		
		//글 수정 
		@RequestMapping(value = "/progress/boardEditInc.do", method = RequestMethod.POST)
		@ResponseBody
		public String boardEditInc(@RequestBody progressVO vo, HttpServletRequest request,
				HttpServletResponse response) {
			
			//메뉴뿌리기용
			
			pservice.updateBoard(vo);
			
			return "success";
			
		}	
		 
		 //의의제기 글쓰기
		@RequestMapping(value = "/progress/objectInput.do", method = RequestMethod.POST)
		@ResponseBody
		public String objectInput(@RequestBody ObjectVO vo, HttpServletRequest request,
				HttpServletResponse response) {
			
			//글 등록
			pservice.inputUserObject(vo);
			
			//상태업데이트
			progressVO progress = new progressVO();
			progress.setBoard_id(vo.getBoard_id());
			progress.setProgress("E03");
			
			pservice.updateStepStatus(progress);
			
			return "success";
			
		}	
		 
		 //의의제기 수정
		@RequestMapping(value = "/progress/objectEdit.do", method = RequestMethod.POST)
		@ResponseBody
		public String objectEdit(@RequestBody ObjectVO vo, HttpServletRequest request,
				HttpServletResponse response) {
			
			//글 수정
			pservice.editMyObject(vo);

			return "success";
			
		}
		 
		 //이의제기 답변달기
		@RequestMapping(value = "/progress/inputObjectReply.do", method = RequestMethod.POST)
		@ResponseBody
		public String inputObjectReply(@RequestBody ObjectVO vo, HttpServletRequest request,
				HttpServletResponse response) {
			
			//글 수정
			pservice.inputObjectReply(vo);
			
			//이의제기 총 횟수 찾기.
			Integer num =pservice.cntObject(vo.getBoard_id());
			
			//상태업데이트
			progressVO progress = new progressVO();
			if(vo.getStatus() == 1) {
				progress.setProgress("E04");
			}else {
				if(num >= 3) {
					progress.setProgress("E04");
				}else {
					progress.setProgress("E02");
				}
			}
			
			progress.setBoard_id(vo.getBoard_id());
			progress.setStatus(vo.getStatus());

			pservice.updateStepStatus(progress);

			return "success";
			
		}
		
		//모든 이력 내역 
		@RequestMapping(value="/progress/getAllRecord.do", method = RequestMethod.GET)
		 public String getAllRecord(Integer board_id, Model model,HttpServletRequest request, HttpServletResponse response) {
				HttpSession session = request.getSession(); 
				
				model.addAttribute("boardPost", pservice.getOnePost(board_id));
				
				//첫검토 불러오기
				model.addAttribute("firstFeedback", pservice.getFirstFeedback(board_id));
				
				//모든 이의제기 가져오기
				model.addAttribute("objects", pservice.getAllObject(board_id));
				//이의제기 횟수
				model.addAttribute("objectCnt", pservice.cntObject(board_id));
				
				return "/views/progressBrd/getAllRecord";
				
		}
		
		//동의하기
		@RequestMapping(value="/progress/agreeFirstFeedBack.do", method = RequestMethod.GET)
		 public String agreeFirstFeedBack(Integer board_id,Integer cntPerPage, Integer nowPage, Integer menu_id, Model model,HttpServletRequest request, HttpServletResponse response) {
			

			progressVO progress = new progressVO();
			progress.setProgress("E04");
			progress.setBoard_id(board_id);
			
			pservice.updateStepStatus(progress);
			
			return "redirect:/progress/boardList.do?cntPerPage="+cntPerPage+"&nowPage="+nowPage+"&menu_id="+menu_id;
		}
		 

	}

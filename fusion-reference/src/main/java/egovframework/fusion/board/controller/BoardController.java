/*********************************************************
 * 업 무 명 : 게시판 컨트롤러
 * 설 명 : 게시판을 조회하는 화면에서 사용 
 * 작 성 자 : 김민규
 * 작 성 일 : 2022.10.06
 * 관련테이블 : 
 * Copyright ⓒ fusionsoft.co.kr
 *
 *********************************************************/
package egovframework.fusion.board.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.fusion.board.service.BoardService;
import egovframework.fusion.board.service.BoardServiceImpl;
import egovframework.fusion.board.service.ReplyService;
import egovframework.fusion.board.vo.BoardVO;
import egovframework.fusion.board.vo.HistoryVO;
import egovframework.fusion.board.vo.PagingVO;
import egovframework.fusion.board.vo.ReplyVO;

@Controller
public class BoardController {
	
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	BoardService boardService;
	
	@Autowired
	ReplyService replyService;

	/*
	 * 게시판 리스트 출력
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String gopage(BoardVO boardVO, PagingVO pagingVo, Model model,
			@RequestParam(value = "nowPage", required = false) Integer nowPage,
			@RequestParam(value = "cntPerPage", required = false) Integer cntPerPage,
			@RequestParam(value="search_type", required= false)String search_type,
			@RequestParam(value="search_word", required= false)String search_word,
			@RequestParam(value="menu_id", required = false)Integer menu_id,
			HttpServletRequest request,
			HttpServletResponse response) {
		
			
		if(search_type != null || search_word !=null) {
			boardVO.setSearch_type(search_type);
			boardVO.setSearch_word(search_word);
			model.addAttribute("searchType", search_type);
			model.addAttribute("searchWord", search_word);
		}
		

		// 세션아이디값
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("memberId");
		if (loginId != null) {
			model.addAttribute("loginId", loginId);
		}


		if (nowPage == null) {
			nowPage = 1;
		}
		if (cntPerPage == null) {
			cntPerPage = 10;
		}
		
		if(cntPerPage != null) {
			model.addAttribute("cntPerPage", cntPerPage);
		}
		
		if(menu_id == null) {
			menu_id = 1;
		}

		Integer cntPage = 5;
		
		Integer endPage = 0;
		Integer startPage = 0;
		Integer lastPage = 0;
		Integer nowBlock = 0;
		
		//쿼리용
		int start = (nowPage-1)*cntPerPage+1;
		int end = nowPage*cntPerPage;
		boardVO.setMenu_id(menu_id);
		boardVO.setStart(start); 
		boardVO.setEnd(end);
		
		Integer total = boardService.cntBoard(boardVO);
		List<BoardVO> boardList = boardService.getBoardList(boardVO);
		

		//현재 나의 블록 
		nowBlock = (int) Math.ceil((double) nowPage / cntPage);
		//시작페이징
		startPage = (nowBlock - 1) * cntPage + 1;
		lastPage = (int) Math.ceil((double) total / cntPerPage);
		
		
		//더 작은수 리턴
		endPage = Math.min((startPage + (cntPage - 1)), lastPage);

		PagingVO pvo = new PagingVO(nowPage, startPage, endPage, total, cntPerPage,lastPage, start, end, cntPage);
		log.warn(pvo.toString());
		
		model.addAttribute("total", total);
		model.addAttribute("paging", pvo);
		// 공지 게시글
		model.addAttribute("noticeList", boardService.getNoticeList(boardVO));
		// 일반 글목록
		model.addAttribute("boardList", boardList);
		model.addAttribute("nowPage", pvo.getNowPage());
		model.addAttribute("cntperpage", pvo.getCntPerPage());
		model.addAttribute("menu_id", menu_id);
		//가장최근 한건
		model.addAttribute("recentNotice", boardService.getRecentNotice(menu_id));
		
		BoardVO vovovo = boardService.getRecentNotice(menu_id);


		return "views/board/boardList";
	}
	

	/*
	 * 게시글 등록 페이지 이동
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardRegister.do", method = RequestMethod.GET)
	public String boardRegister(Integer menu_id,BoardVO boardVO, Model model) {
		model.addAttribute("menu_id", menu_id);
		
		return "views/board/boardRegister";
		
	}

	/*
	 * 게시글 등록
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/insBoardPost.do", method = RequestMethod.POST)
	public String insBoardPost(BoardVO boardVO, Model model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("memberId");
		boardVO.setWriter(loginId);
		boardVO.setParent_id(0);
		boardService.insBoardPost(boardVO);
		System.out.println(boardVO.getContent());
		model.addAttribute("menu_id", boardVO.getMenu_id());
		return "views/board/msg";
	}

	/*
	 * 게시글 조회
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardPost.do", method = RequestMethod.GET)
	public String boardPost(BoardVO boardVO, Model model, HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("memberId");
		System.out.println(loginId);
		System.out.println(boardVO.getBoard_id());
		Integer brdId = boardVO.getBoard_id();

		if (loginId != null) {
			System.out.println("yes");
			model.addAttribute("loginId", loginId);

			HistoryVO hvo = new HistoryVO();
			hvo.setBoard_id(brdId);
			hvo.setUser_name(loginId);

			Integer num = boardService.ckHistory(hvo);

			System.out.println("First" + num);

			if (num < 1) {
				// 기록 넣기
				boardService.insHistory(hvo);
				// 게시글조회
				BoardVO boardPost = boardService.getBoardPost(boardVO);
				model.addAttribute("boardPost", boardPost);

			} else {
				BoardVO boardPost = boardService.getBoardPost(boardVO);
				model.addAttribute("boardPost", boardPost);

				System.out.println("Second" +boardPost);

			}
		} else {
			System.out.println("no");
			BoardVO boardPost = boardService.getBoardPost(boardVO);
			model.addAttribute("boardPost", boardPost);

			System.out.println("Third" +boardPost);
		}

		ReplyVO replyVO = new ReplyVO();
		System.out.println(brdId);
		replyVO.setBoard_id(brdId);
		
		List<ReplyVO> list = replyService.getReplyAll(replyVO);
		model.addAttribute("menu_id", boardVO.getMenu_id());
		System.out.println("===================================");
		for(ReplyVO vo : list) {
			System.out.println(vo.getContent());
		}
				
		model.addAttribute("replies", list);
		return "/views/board/boardPost";
	}

	/*
	 * 공지글
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/board/boardNotice.do", method = RequestMethod.POST)
	public Map<String, Object> boardNotice(BoardVO boardVO, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> map = new HashMap<>();

		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("memberId");

		System.out.println(loginId);
		System.out.println(boardVO.getBoard_id());

		Integer brdId = boardVO.getBoard_id();

		if (loginId != null) {
			System.out.println("yes");
			map.put("loginId", loginId);

			HistoryVO hvo = new HistoryVO();
			hvo.setBoard_id(brdId);
			hvo.setUser_name(loginId);

			Integer num = boardService.ckHistory(hvo);

			System.out.println(num);

			if (num == 0) {
				// 기록 넣기
				boardService.insHistory(hvo);
				// 게시글조회
				BoardVO boardPost = boardService.getBoardPost(boardVO);
				map.put("boardPost", boardPost);

			} else {
				BoardVO boardPost = boardService.getBoardPost(boardVO);
				map.put("boardPost", boardPost);

				System.out.println(boardPost);

			}
		} else {
			System.out.println("no");
			BoardVO boardPost = boardService.getBoardPost(boardVO);
			map.put("boardPost", boardPost);
			ReplyVO replyVO = new ReplyVO();
			replyVO.setBoard_id(brdId);
			// List<ReplyVO> list = replyService.getReplyAll(replyVO);
			// model.addAttribute("replies", list);
			System.out.println(boardPost);
		}

		return map;
	}

	/*
	 * 게시글 수정 페이지 진입
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/boardPostModify.do", method = RequestMethod.GET)
	public String boardPostModify(BoardVO boardVO, Model model) {

		try {
			BoardVO boardPost = boardService.getBoardPost(boardVO);
			model.addAttribute("boardPost", boardPost);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/views/board/boardPostModify";
	}

	/*
	 * 게시글 수정
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/updBoardPost.do", method = RequestMethod.POST)
	public String updBoardPost(BoardVO boardVO, Model model) {

		boardService.updBoardPost(boardVO);
		
		Integer category = boardVO.getCategory();
		
		if(category == 1 ) {
			return "views/board/msg";
		}else {
			return "redirect:/board/boardPost.do?board_id=" + boardVO.getBoard_id();
		}

	}

	/*
	 * 게시글 삭제
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/board/delBoardPost.do", method = RequestMethod.GET)
	public String delBoardPost(BoardVO boardVO, Model model) {
		System.out.println(boardVO);
		try {
			boardService.delBoardPost(boardVO);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/board/boardList.do";
	}

	/*
	 * 게시글 선택 삭제
	 * 
	 * @param
	 * 
	 * @return
	 * 
	 * @exception Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/board/delChkBoardPost.do", method = RequestMethod.POST)
	public String delChkBoardPost(@RequestBody BoardVO boardVO, Model model) {

		try {
			boardService.delChkBoardPost(boardVO);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/board/boardList.do";
	}

	// 답글, 답답글 작성페이지 이동
	@RequestMapping(value = "/board/insertRePost.do", method = RequestMethod.GET)
	public String insertRePostFrm(BoardVO boardVO, Model model) {

		BoardVO boardPost = boardService.getBoardPost(boardVO);
		model.addAttribute("boardPost", boardPost);

		return "/views/board/boardRePost";
	}

	// 답글 작성 입력
	@ResponseBody
	@RequestMapping(value = "/board/insBrdRePost.do", method = RequestMethod.POST)
	public String insertRepostDo(BoardVO vo, HttpServletRequest request, HttpServletResponse response, Model model) {

		// 세션에서 뽑아내기
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("memberId");

		Integer parentId = vo.getParent_id();

		BoardVO bvo = new BoardVO();
		bvo.setBoard_id(parentId);

		// 조상의 카테고리 뽑아오기.
		BoardVO Parent = boardService.getBoardPost(bvo);
		Integer category = Parent.getCategory();

		
		vo.setCategory(category);
		vo.setWriter(loginId);

		boardService.insBoardPost(vo);

		String msg = "등록완료!";

		return msg;
	}

}

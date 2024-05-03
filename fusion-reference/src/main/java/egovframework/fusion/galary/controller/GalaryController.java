package egovframework.fusion.galary.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.exc.InvalidFormatException;

import egovframework.fusion.board.vo.PagingVO;
import egovframework.fusion.common.service.MenuService;
import egovframework.fusion.common.vo.MenuVO;
import egovframework.fusion.galary.service.GalaryService;
import egovframework.fusion.galary.vo.DownloadsVO;
import egovframework.fusion.galary.vo.GalaryHistoryVO;
import egovframework.fusion.galary.vo.GalaryVO;
import egovframework.fusion.galary.vo.LikeVO;
import egovframework.fusion.galary.vo.MakeJxlsExcel;
import egovframework.fusion.galary.vo.MediaVO;
import egovframework.fusion.galary.vo.TagRcdVO;
import egovframework.fusion.galary.vo.TagsVO;
import egovframework.fusion.user.service.UserService;
import net.sf.jxls.exception.ParsePropertyException;

@Controller
public class GalaryController {
	
	@Autowired
	GalaryService galaryservice;
	
	@Autowired
	UserService userService; 
	
	@Autowired
	MenuService menuService;
	
//	@RequestMapping(value="/galary/galaryList.do", method = RequestMethod.GET )
//	public String GalaryList(GalaryVO galaryVO,PagingVO pagingVo, Model model) {
//		System.out.println("gdgdgdgdgd");
//		return "views/galary/galaryAll";
//	}
	
	//목록조회-검색,페이징처리 다
	@RequestMapping(value="/galary/galaryList.do", method = RequestMethod.GET )
	public String gopage(GalaryVO galaryVO, PagingVO pagingVo, Model model,
			@RequestParam(value = "nowPage", defaultValue = "1", required = false) Integer nowPage,
			@RequestParam(value = "cntPerPage",  defaultValue = "9",required = false) Integer cntPerPage,
			@RequestParam(required = false)String search_type,
			@RequestParam(required = false)String search_word,
			@RequestParam(required = false)Integer menu_id,
			HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		

		if(menu_id == null) {
			menu_id = 1;
		}
		
		// 세션아이디값
		Object oId = session.getAttribute("writerId");
		if (oId != null) {
			String loginId = (String) oId.toString();
			model.addAttribute("loginId", loginId);
		}
		
		Integer auth = (Integer) session.getAttribute("auth");
		
		model.addAttribute("auth", auth);
		
		System.out.println(search_type);
		
		if(search_type != null) {
			if(search_word != null) {
				galaryVO.setSearch_type(search_type);
				galaryVO.setSearch_word(search_word);
				
				model.addAttribute("searchType", search_type);
				model.addAttribute("searchWord", search_word);				
			}
		}
		if (cntPerPage!=0 && cntPerPage != null) {
			model.addAttribute("cntPerPage", cntPerPage);
		}
		if(galaryVO.getCategory()!= null) {
			model.addAttribute("category", galaryVO.getCategory());
		}
		
		Integer cntPage = 5;
		
		Integer endPage = 0;
		Integer startPage = 0;
		Integer lastPage = 0;
		Integer nowBlock = 0;
		
		Integer total = galaryservice.cntGalary(galaryVO);
		
		//쿼리용
		int start = (nowPage-1)*cntPerPage+1;
		int end = nowPage*cntPerPage;
			
		galaryVO.setStart(start); 
		galaryVO.setEnd(end);
		galaryVO.setMenu_id(menu_id);
		
		//현재 나의 블록 
		nowBlock = (int) Math.ceil((double) nowPage / cntPage);
		//시작페이징
		startPage = (nowBlock - 1) * cntPage + 1;
		lastPage = (int) Math.ceil((double) total / cntPerPage);
		
		
		//더 작은수 리턴
		endPage = Math.min((startPage + (cntPage - 1)), lastPage);

		PagingVO pvo = new PagingVO(nowPage, startPage, endPage, total, cntPerPage,lastPage, start, end, cntPage);
		
		
		model.addAttribute("total", total);
		model.addAttribute("paging", pvo);
			
		List<GalaryVO> galaryList = galaryservice.getGalaryList(galaryVO);
		System.out.println(galaryList);

		model.addAttribute("galarylist", galaryList);
		model.addAttribute("menu_id", menu_id);
		
		//랭킹 - 조회수로 뽑기, 처음은 일간으로 잡기!
		galaryVO.setRankType("day");
		model.addAttribute("Ranks", galaryservice.getRanksCnt(galaryVO));
		
		//태그 랭킹 - 처음엔 일간으로 잡고 뽑기~!
		galaryVO.setTagType("day");
		model.addAttribute("tagRank", galaryservice.getRanksTags(galaryVO));
		
		
		return "views/galary/galaryAll";
	}
	
	//한건보기
	@RequestMapping(value="/galary/galaryPost.do", method=RequestMethod.GET)
	public String galaryPost(Integer galary_id,
						@RequestParam(value = "cntPerPage",required = false)Integer cntPerPage,
						@RequestParam(value = "nowPage", required = false)Integer nowPage,
						@RequestParam(value = "search_type", required = false)String search_type,
						@RequestParam(value = "search_word", required = false)String search_word,
						@RequestParam(value = "category", required = false)Integer category,
						@RequestParam(value = "menu_id", required = false)Integer menu_id
						, Model model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		System.out.println("AAAAAAAAAAAA"+galary_id);
		String loginId = (String) session.getAttribute("writerId");
		
		GalaryVO galaryvo = new GalaryVO();
		galaryvo.setGalary_id(galary_id);
		
		
		model.addAttribute("category", category);
		model.addAttribute("search_word", search_word);
		model.addAttribute("search_type", search_type);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("cntPerPage", cntPerPage);
		model.addAttribute("menu_id", menu_id);

		

		MediaVO mvo = new MediaVO();
		
		if (loginId != null) {
			System.out.println("yes");
			model.addAttribute("loginId", loginId);
			System.out.println("로그인 되어있다 로그인 되어있다" + loginId);

			GalaryHistoryVO hvo = new GalaryHistoryVO();
			hvo.setGalary_id(galary_id);
			hvo.setUser_id(loginId);

			Integer num = galaryservice.CkGalHistory(hvo);
			
			LikeVO lvo = new LikeVO();
			lvo.setGalary_id(galary_id);
			lvo.setUser_id(loginId);
			Integer likeyn = galaryservice.ckLikes(lvo);
			model.addAttribute("likeyn", likeyn);
			System.out.println("좋아요 여부 있는지 확인 하장"+ likeyn);
			System.out.println("First" + num);
	
			if (num < 1) {
				// 기록 넣기
				galaryservice.InsGalHistory(hvo);
				// 게시글조회
				
			} 
		} else {
			System.out.println("no");
			System.out.println(galaryvo.toString());
			GalaryVO galPost = galaryservice.getGalary(galary_id);
			
			GalaryHistoryVO hvo2 = new GalaryHistoryVO();
			hvo2.setGalary_id(galary_id);
			hvo2.setUser_id("nonUser");
			
			galaryservice.InsGalHistory(hvo2);
			
			
		}
		
		Integer auth = (Integer) session.getAttribute("auth");
		
	    if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
		
		GalaryVO galPost = galaryservice.getGalary(galary_id);
		mvo.setGalary_id(galary_id);
		List<MediaVO> allImages = galaryservice.getAllResize(mvo);
		model.addAttribute("galPost", galPost);
		System.out.println(galPost);
		model.addAttribute("Images", allImages);
		
		return "views/galary/galaryReadPost";
	}
	

	//좋아요 넣기
	@ResponseBody
	@RequestMapping(value="/galary/addLike.do", method = RequestMethod.POST)
	public Integer addLike(Integer galary_id, HttpServletRequest request, HttpServletResponse response) {
		LikeVO likevo = new LikeVO();

		HttpSession session = request.getSession();
		
		Object oId = session.getAttribute("writerId");
		//로그인한 유저의 아이디
		String loginId = (String) oId.toString();
			
		likevo.setCancel_yn("n");
		likevo.setUser_id(loginId);
		likevo.setGalary_id(galary_id);
		
		galaryservice.InsLikes(likevo);
		
		Integer num = galaryservice.ckLikes(likevo);

		return num;
	}
	
	//좋아요 해제
	@ResponseBody
	@RequestMapping(value="/galary/delLikes.do", method= RequestMethod.POST)
	public Integer delLIke(Integer galary_id, HttpServletRequest request, HttpServletResponse response) {
		LikeVO likevo = new LikeVO();

		HttpSession session = request.getSession();
		
		Object oId = session.getAttribute("writerId");
		//로그인한 유저의 아이디
		String loginId = (String) oId.toString();
		
		likevo.setUser_id(loginId);
		likevo.setGalary_id(galary_id);
		
		galaryservice.delLikes(likevo);
		Integer num = galaryservice.ckLikes(likevo);
		return num;
		
			
	}
	
	//갤러리 글삭제
	@RequestMapping(value="/galary/delGalaryPost.do", method=RequestMethod.GET)
	public String delGalaryPost(Integer galary_id,Integer menu_id) {
			
		System.out.println(galary_id);
		GalaryVO vo = new GalaryVO();
		
		vo.setGalary_id(galary_id);
		
		galaryservice.delGalaryPost(vo);
	
		return "redirect:/galary/galaryList.do?menu_id="+menu_id;
	}
	
	
	//포스트 등록 페이지 이동
	@RequestMapping(value="/galary/galaryInputFrm.do", method = RequestMethod.GET)
	public String inputGalary(Integer menu_id,Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		model.addAttribute("menu_id", menu_id);
		
		Integer auth = (Integer) session.getAttribute("auth");
		
		if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
		
		return "views/galary/inputPost";
	}
	
	//포스트 등록
	@RequestMapping(value="/galary/insGalaryPost.do", method=RequestMethod.POST)
	@ResponseBody
	public String inputGalaryPost(GalaryVO gvo, MultipartFile[] uploadFiles,HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response){ 
		//갤러리포스트등록
		// 세션아이디값
		Object oId = session.getAttribute("writerId");
				
		String loginId = (String) oId.toString();
								
		gvo.setWriter(loginId);		
		//System.out.println("vo에서 꺼냄" + gvo.getUploadFiles());
		galaryservice.insGalaryPost(gvo);		
		
	
//		//태그 넣깅
		if(gvo.getTagArr() != null) {
			galaryservice.insTags(gvo);
		}
		
		System.out.println("gvo!!" + gvo.toString());
		System.out.println("uploadFiles !!" + uploadFiles);
//		 
//		//선언
		MediaVO mediavo = new MediaVO();
		mediavo.setGalary_id(gvo.getGalary_id());
//		
		String thumNailFileName = gvo.getOriginal_name();
		System.out.println("업로드파일즈"+uploadFiles);
		System.out.println("잉잉잉!"+uploadFiles.length);
		
		mediavo.setOriginal_name(thumNailFileName);
		for(int i=0;i<uploadFiles.length;i++) {

			MultipartFile[] upload= {uploadFiles[i]};
			galaryservice.insImage(upload, mediavo);
			
		}		
		return "redirect:/galary/galaryList.do";

	}
	
	
	//포스트 수정 페이지 이동
	@RequestMapping(value="/galary/galaryPostEditFrm.do", method=RequestMethod.GET)
	public String galaryPostEditFrm(Integer galary_id,Integer menu_id, Model model,HttpSession session,
			HttpServletRequest request,
			HttpServletResponse response) {
		
		model.addAttribute("menu_id", menu_id);
		MediaVO mvo = new MediaVO();

		GalaryVO galPost = galaryservice.getGalary(galary_id);
		mvo.setGalary_id(galary_id);
		
		List<MediaVO> allImages = galaryservice.getAllResize(mvo);
		model.addAttribute("galaryPost", galPost);
		
		System.out.println(galPost);
		model.addAttribute("Images", allImages);
		
		List<TagsVO> taglist = galaryservice.getTags(galary_id);
		model.addAttribute("taglist", taglist);
		
		MediaVO thumnailvo = galaryservice.getThumnail(galary_id);
		model.addAttribute("thumnail", thumnailvo);
		
		for(int i =0; i<taglist.size(); i++) {
			System.out.println(taglist.get(i).getTag_name());
		}
		
	Integer auth = (Integer) session.getAttribute("auth");
		
		if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
		return "views/galary/postEditFrm";
	}
	
	//포스트 수정
	@RequestMapping(value="/galary/editGalaryPost.do", method=RequestMethod.POST)
	@ResponseBody
	public String galaryPostEdit(  GalaryVO gvo, MultipartFile[] uploadFiles,HttpSession session,
									HttpServletRequest request,
									HttpServletResponse response) {
		
		//갤러리수정
		galaryservice.UpdateGalaryPost(gvo,uploadFiles);

		return "true";
	}
	

	//다운로드 기록남기기
	@RequestMapping(value="/galary/insDownRecord.do" , method=RequestMethod.POST)
	@ResponseBody
	public String insDownloadecord(Integer media_id ,Integer galary_id, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		// 세션아이디값
		Object oId = session.getAttribute("writerId");
				
		String loginId = (String) oId.toString();
		DownloadsVO vo = new DownloadsVO();
		
		
		vo.setMedia_id(media_id);
		vo.setUser_id(loginId);
		
		
		//다운로드 히스토리추가
		galaryservice.InsDownloads(vo);
		
		//미디어 조회 .. 
		MediaVO mvo = galaryservice.mediasrh(media_id, galary_id);
		
		System.out.println();
		
		//다운로드 카운트 업 
		galaryservice.updateDownCnt(mvo.getMedia_id());
		
		return "true";
	}
	
	
	//랭킹 가져오기
	@RequestMapping(value="/galary/getRankData.do", method=RequestMethod.POST)
	@ResponseBody
	public List<GalaryVO> getRankData(@RequestBody GalaryVO vo){
		
		String word = vo.getRankword();
		List<GalaryVO> list = new ArrayList<>();
		System.out.println(word);
		if(word.equals("cnt")) {
			list = galaryservice.getRanksCnt(vo);
			System.out.println("조회수");
		}
		
		if(word.equals("like")) {
			list = galaryservice.getRankLike(vo);
			System.out.println("좋ㅇ아요");

		}
		
		if(word.equals("down")) {
			list = galaryservice.getRanksDownCnt(vo);
			System.out.println("다운");

		}
		
		System.out.println(list.size());
		return list;
	}
	
	//태그기록넣기
	@RequestMapping(value="/galary/insTagsClickRcd.do" , method=RequestMethod.POST)
	@ResponseBody
	public String insTagsClickRcd(@RequestBody TagRcdVO vo) {
		
		galaryservice.inputTagsRcd(vo);
		
		return "true";
	}
	
	//통계페이지 이동
	@RequestMapping(value="/galary/galStat.do", method=RequestMethod.GET)
	public String galStat(Model model) {
		
		model.addAttribute("galMenu", menuService.galaryMenu());
		return "views/galary/galaryStats";
	}
	
	//갤러리 통계데이터 가져오기
	@RequestMapping(value="/galary/getgalstatistics.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> galstatistics(@RequestParam(value="menu_id", required = false)Integer menu_id) {
		GalaryVO vo = new GalaryVO();
		Map<String, Object> map = new HashMap<>();
		
		if(menu_id == 0) {
			menu_id = 7;
		}
		
		Integer year = 0;
		Integer month = 0;
		
		
		//기본값은 올해, 기준 달,갤러리1을 가장 초기 값으로 잡기
		  LocalDate today = LocalDate.now();
	      LocalDate firstday = today.withDayOfYear(1);
	      LocalDate lastday = today.withDayOfYear(today.lengthOfYear());

		  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		  String start = firstday.format(formatter);
		  String end = lastday.format(formatter);
		  System.out.println(start);
		  System.out.println(end);
		 
		  vo.setStart_date(start);
		  vo.setEnd_date(end);
		  vo.setMenu_id(menu_id);
		  
		  DateTimeFormatter monthformat = DateTimeFormatter.ofPattern("MM");
		  month = Integer(firstday.format(monthformat));
		  year = today.getYear();
	
		  System.out.println("이게 브이오" + vo);
		  
		map.put("menuid", menu_id);
		map.put("cnt", galaryservice.getCntstatsByMonth(vo));
		map.put("likes", galaryservice.getLikestatsByMonth(vo));
		map.put("down", galaryservice.getDownstatsByMonth(vo));
		map.put("tags", galaryservice.getTagStaticsByMonth(vo));

		map.put("year", year);
		return map;
	}
	
	//조회수 차트 바꾸기
	@RequestMapping(value="/galay/changeCntChart.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> changeCntChart(@RequestBody GalaryVO vo) {
		Map<String, Object> map = new HashMap<>();

		
		String type = vo.getChartype();

		if(type.equals("day")) {
			map.put("cnt", galaryservice.getCntstatsByDay(vo));
		}

		if(type.equals("week")) {
			map.put("cnt", galaryservice.getCntstatsByWeek(vo));
		}
		
		if(type.equals("month")) {
			map.put("cnt", galaryservice.getCntstatsByMonth(vo));

		}
		return map;
	}
	
	//좋아요 차트바꾸기
	@RequestMapping(value="/galay/changeLikeChart.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> changeLikeChart(@RequestBody GalaryVO vo) {
		Map<String, Object> map = new HashMap<>();

		
		String type = vo.getChartype();

		if(type.equals("day")) {
			map.put("like", galaryservice.getLikeStatsByDay(vo));
		}

		if(type.equals("week")) {
			map.put("like", galaryservice.getLikeStatsByWeek(vo));
		}
		
		if(type.equals("month")) {
			map.put("like", galaryservice.getLikestatsByMonth(vo));

		}
		return map;
	}
	
	//다운로드 차트바꾸기
	@RequestMapping(value="/galay/changedownChart.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> changedownChart(@RequestBody GalaryVO vo) {
		Map<String, Object> map = new HashMap<>();

		
		String type = vo.getChartype();
		
		if(type.equals("day")) {
			map.put("down", galaryservice.getDownstatsByDay(vo));
		}

		if(type.equals("week")) {
			map.put("down", galaryservice.getDownstatsByWeek(vo));
		}
		
		if(type.equals("month")) {
			map.put("down", galaryservice.getDownstatsByMonth(vo));

		}
		return map;
	}
	
	//조회수 차트 바꾸기
	@RequestMapping(value="/galay/changeTagChart.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> changeTagChart(@RequestBody GalaryVO vo) {
		Map<String, Object> map = new HashMap<>();

		
		String type = vo.getChartype();
		
		if(type.equals("day")) {
			map.put("tag", galaryservice.getTagStaticsByDay(vo));
		}

		if(type.equals("week")) {
			map.put("tag", galaryservice.getTagStaticsByWeek(vo));
		}
		
		if(type.equals("month")) {
			map.put("tag", galaryservice.getDownstatsByMonth(vo));

		}
		return map;
	}
	//태그 클라우드
	@RequestMapping(value= "/galary/goTagCloud.do", method = RequestMethod.GET)
	public String goTagCloud(Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		
		Integer auth = (Integer) session.getAttribute("auth");
		
		if (auth == null) {
	        auth = 4;
	    }
	    
		List<MenuVO> menulist = menuService.menulist(auth);
		
		model.addAttribute("menulists", menulist);
		
		return "views/galary/galaryTagCloud";
	}
	
	//태그 클라우드 정보 뽑기
	@RequestMapping(value= "/galary/getTagCloudData.do", method = RequestMethod.GET)
	@ResponseBody
	public List<TagsVO> getTagCloudData() {
		
		List<TagsVO>list = galaryservice.allTags();
		return list;
	}
	
	//태그 랭크 변경
	@RequestMapping(value="/galary/chageTagRank.do", method = RequestMethod.POST)
	@ResponseBody
	public List<TagsVO> chageTagRank(@RequestBody GalaryVO vo  ){
		
		List<TagsVO>list = galaryservice.getRanksTags(vo);
		
		return list;
	}
	
	//모달용
	@RequestMapping(value="/galary/modalStats.do", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> modalStats(@RequestBody GalaryVO vo){
		Map<String, Object> map = new HashMap<>();
		
		String type = vo.getChartype();
		Integer year = 0;
		Integer month = 0;
		
		System.out.println("일단 도착해썽");
		if(vo.getStart_date() == null) {
			 LocalDate today = LocalDate.now();
			 year = today.getYear();

		      LocalDate firstday = today.withDayOfYear(1);
		      LocalDate lastday = today.withDayOfYear(today.lengthOfYear());

			  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			  DateTimeFormatter monthformat = DateTimeFormatter.ofPattern("MM");
			  
			   month = Integer(firstday.format(monthformat));
			  String start = firstday.format(formatter);
			  String end = lastday.format(formatter);
			  System.out.println(start);
			  System.out.println(end);
			 
			  vo.setStart_date(start);
			  vo.setEnd_date(end);
		}
		
		if(vo.getStart_date() != null) {
			String stringstart = vo.getStart_date();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			LocalDate startdate = LocalDate.parse(stringstart, formatter);
			 year = startdate.getYear();
			 month = startdate.getMonthValue();
		}
		
		if(type == null) {
			System.out.println("달");
			type="month";
			vo.setChartype("month");
		}
		
		System.out.println(vo.getGalary_id().getClass().getName());
		System.out.println("vo" + vo.toString());
		if(type.equals("day")) {
			map.put("like", galaryservice.getLikeStatsByDay(vo));
			map.put("cnt", galaryservice.getCntstatsByDay(vo));
			map.put("month", month);

		}

		if(type.equals("week")) {
			map.put("like", galaryservice.getLikeStatsByWeek(vo));
			map.put("cnt", galaryservice.getCntstatsByWeek(vo));
			map.put("month", month);
			

		}
		
		if(type.equals("month")) {
			map.put("like", galaryservice.getLikestatsByMonth(vo));
			map.put("cnt", galaryservice.getCntstatsByMonth(vo));
		}
		
		map.put("type", vo.getChartype());
		map.put("year", year);

		return map;
	}

	private Integer Integer(String format) {
		// TODO Auto-generated method stub
		return null;
	}
	
	//엑셀
	@RequestMapping(value="/galary/getExcelfile.do", method=RequestMethod.POST)
	@ResponseBody
	public void getExcelfile(@RequestBody GalaryVO vo, HttpServletResponse response, HttpServletRequest request) throws InvalidFormatException, ParsePropertyException, org.apache.poi.openxml4j.exceptions.InvalidFormatException{
			String type= vo.getChartype();
			
			//변수설정
			Map<String, Object> map = new HashMap<>();
			List<GalaryVO> likeList = new ArrayList<>();
			List<GalaryVO> cntList = new ArrayList<>();
			List<GalaryVO> downList = new ArrayList<>();
			
			String title = "Galary stats List";
			
			ClassPathResource classPathResource = new ClassPathResource("templates/excel/statsList.xlsx");
			if(type.equals("day")) {
				likeList = galaryservice.getLikeStatsByDay(vo);
				cntList = galaryservice.getCntstatsByDay(vo);
				downList = galaryservice.getDownstatsByDay(vo);

			}

			if(type.equals("week")) {
				likeList = galaryservice.getLikeStatsByWeek(vo);
				cntList = galaryservice.getCntstatsByWeek(vo);
				downList = galaryservice.getDownstatsByWeek(vo);

			}
			
			if(type.equals("month")) {
				likeList = galaryservice.getLikestatsByMonth(vo);
				cntList = galaryservice.getCntstatsByMonth(vo);
				downList = galaryservice.getDownstatsByMonth(vo);
			}
			
			map.put("likeList", likeList);
			map.put("cntList", cntList);
			map.put("downList", downList);
			
			String newFileName = "엑셀파일";
			
			MakeJxlsExcel mje = new MakeJxlsExcel();
			mje.download(request, response, map, newFileName, "sample.xlsx");
			
			
			
	}	
}

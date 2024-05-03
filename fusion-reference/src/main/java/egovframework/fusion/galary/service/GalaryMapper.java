package egovframework.fusion.galary.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.fusion.galary.vo.DownloadsVO;
import egovframework.fusion.galary.vo.GalaryHistoryVO;
import egovframework.fusion.galary.vo.GalaryVO;
import egovframework.fusion.galary.vo.LikeVO;
import egovframework.fusion.galary.vo.MediaVO;
import egovframework.fusion.galary.vo.TagRcdVO;
import egovframework.fusion.galary.vo.TagsVO;

@Mapper
public interface GalaryMapper {
	
	//갤러리 조회- 전체조회, 검색조회, 카테고리 조회
	public List<GalaryVO> getGalaryList(GalaryVO galaryVo);
	
	//총 글수 조회
	public Integer cntGalary(GalaryVO galaryVo);
	
	//갤러리 한건 조회 -> media와 조인 
	public GalaryVO getGalary(Integer galary_id);
	
	//이미지 몽땅 조회
	public List<MediaVO> getAllResize(MediaVO mediavo);
	
	//게시글 등록
	public void insGalaryPost(GalaryVO galaryVo);
	
	//게시글 삭제
	public void delGalaryPost(GalaryVO galaryVo);
	
	//게시글 수정
	public void UpdateGalaryPost(GalaryVO galaryVo);
	
	
	//사진파일 수정
	public void updateImage(MediaVO mediaVO);
	
	//사진파일 삭제
	public void delImage(GalaryVO galaryVo);
	
	//사진파일 등록
	public void insImage(MediaVO mediaVO);
	
	//태그등록
	public void insTags(GalaryVO galaryVo);
	
	//태그삭제
	public void delTags(GalaryVO galaryVo);
	
	//태그 조회
	public List<TagsVO> getTags(Integer galary_id);
	
	//조회수 체크
	public Integer CkGalHistory(GalaryHistoryVO galaryhistoryVO);
	
	//조회수 등록
	public void InsGalHistory(GalaryHistoryVO galaryhistoryVO);
	
	//다운로드 기록 등록
	public void InsDownloads(DownloadsVO downloadsVO);
	
	//미디어 조회수 업데이트
	public void updateDownCnt(Integer media_Id);
	
	//다운로드 기록 수? 조회
	public Integer cntDownloads(DownloadsVO downloadsVO);
	
	//좋아요 수 ? 조회
	public Integer cntLikes(LikeVO likevo);
	
	//좋아요 등록
	public void InsLikes(LikeVO likevo);
	
	//좋아요 여부 조회
	public Integer ckLikes(LikeVO likevo);
	
	//조아요 취소
	public void delLikes(LikeVO likevo);
	
	//썸네일찾기
	public MediaVO getThumnail(Integer galary_id);
	
	//썸네일 취소시키기
	public void cancelThumnail(Integer galary_id);
	
	//원래 있던 사진 썸넬로 바꾸는거
	public void changeThumnail(GalaryVO galaryVO);
	
	//미디어조회
	public MediaVO mediasrh(Map<String,Object> map);
	
	//랭킹용 데이터 뽑기 - 조회수
	public List<GalaryVO> getRanksCnt(GalaryVO galaryVo);
	
	//랭킹용 데이터 - 좋아요수
	public List<GalaryVO> getRankLike(GalaryVO galaryVO);
	
	//랭킹용 데이터 뽑기 - 태그 - 가장 추후에 할것 
	
	public List<TagsVO> getRanksTags(GalaryVO vo);
	
	// 랭킹용 데이터 뽑기 - 다운로드수
	public List<GalaryVO> getRanksDownCnt(GalaryVO galaryVo);
	
	//일별 통계 - 조회수
	public List<GalaryVO> getCntstatsByDay(GalaryVO galaryVo);

	//주별 통계 - 조회수
	public List<GalaryVO> getCntstatsByWeek(GalaryVO galaryVo);
	
	//월별 통계 - 조회수
	public List<GalaryVO> getCntstatsByMonth(GalaryVO galaryVo);
	
	//일 - 다운로드수
	public List<GalaryVO> getDownstatsByDay(GalaryVO galaryVo);
	//주 - 다운
	public List<GalaryVO> getDownstatsByWeek(GalaryVO galaryVo);
	//월 - 다운로드수
	public List<GalaryVO> getDownstatsByMonth(GalaryVO galaryVo);
	
	//일 - 좋아요
	public List<GalaryVO> getLikeStatsByDay(GalaryVO galaryVo);
	//주 - 좋아요
	public List<GalaryVO> getLikeStatsByWeek(GalaryVO galaryVo);
	//월 - 좋아요 
	public List<GalaryVO> getLikestatsByMonth(GalaryVO galaryVo);
	
	//태그 클릭시 조회수
	public void inputTagsRcd(TagRcdVO vo);
	
	//모든 태그 다 가져오기
	public List<TagsVO> allTags();
	
	//탭으로 통계 낼것 생각하기~!
	//퍼센테이지?
	public List<GalaryVO> getTagStaticsByDay(GalaryVO vo);
	public List<GalaryVO> getTagStaticsByWeek(GalaryVO vo);
	public List<GalaryVO> getTagStaticsByMonth(GalaryVO vo);
	
	
	

}

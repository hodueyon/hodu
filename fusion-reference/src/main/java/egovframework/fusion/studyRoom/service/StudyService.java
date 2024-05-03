package egovframework.fusion.studyRoom.service;

import java.util.List;

import egovframework.fusion.studyRoom.vo.ReserveVO;
import egovframework.fusion.studyRoom.vo.SeatVO;
import egovframework.fusion.studyRoom.vo.StudyRoomVO;
import egovframework.fusion.studyRoom.vo.UsePurposeVO;

public interface StudyService {
	//좌석리스트 가져오기
		List<SeatVO> getSeats(ReserveVO vo);
		
		//독서실 데이터 가져오기
		List<StudyRoomVO> getInfoReserveBySeat(ReserveVO vo);
		
		//목적 데이터 조회
		List<UsePurposeVO> purposeList();
		
		//독서실 정보 가져오기
		StudyRoomVO getInfoStudyRoom(Integer roomid);
		
		//예약내역
		List<ReserveVO> myReservationList(String userId);
		
		//예약하기
		public void insertReservation(ReserveVO vo);
		
		//예약취소
		public void canleReservation(Integer Reserve_id);
		
		//이미 예약
		public List<ReserveVO> ckReserve(ReserveVO vo);
		
		//로그인한 유저가 동시간에 혹시 다른 좌석도 예약해놓았는지 체크체크
		public List<ReserveVO> ckTimeMyOtherReserv(ReserveVO vo);
}

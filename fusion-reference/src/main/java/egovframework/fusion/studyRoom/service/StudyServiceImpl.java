package egovframework.fusion.studyRoom.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.fusion.studyRoom.vo.ReserveVO;
import egovframework.fusion.studyRoom.vo.SeatVO;
import egovframework.fusion.studyRoom.vo.StudyRoomVO;
import egovframework.fusion.studyRoom.vo.UsePurposeVO;

@Service
public class StudyServiceImpl implements StudyService{
	
	@Autowired
	StudyMapper mapper;
	@Override
	public List<SeatVO> getSeats(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.getSeats(vo);
	}

	@Override
	public List<UsePurposeVO> purposeList() {
		// TODO Auto-generated method stub
		return mapper.purposeList();
	}

	@Override
	public List<ReserveVO> myReservationList(String userId) {
		// TODO Auto-generated method stub
		return mapper.myReservationList(userId);
	}


	@Override
	public List<StudyRoomVO> getInfoReserveBySeat(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.getInfoReserveBySeat(vo);
	}

	@Override
	public StudyRoomVO getInfoStudyRoom(Integer roomid) {
		// TODO Auto-generated method stub
		return mapper.getInfoStudyRoom(roomid);
	}

	@Override
	public void insertReservation(ReserveVO vo) {
		// TODO Auto-generated method stub
		mapper.insertReservation(vo);
	}

	@Override
	public void canleReservation(Integer Reserve_id) {
		// TODO Auto-generated method stub
		mapper.canleReservation(Reserve_id);
	}

	@Override
	public List<ReserveVO> ckReserve(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.ckReserve(vo);
	}

	@Override
	public List<ReserveVO> ckTimeMyOtherReserv(ReserveVO vo) {
		// TODO Auto-generated method stub
		return mapper.ckTimeMyOtherReserv(vo);
	}

}

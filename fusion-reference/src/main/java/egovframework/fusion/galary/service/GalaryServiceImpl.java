package egovframework.fusion.galary.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.imageio.ImageIO;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import egovframework.fusion.galary.vo.DownloadsVO;
import egovframework.fusion.galary.vo.GalaryHistoryVO;
import egovframework.fusion.galary.vo.GalaryVO;
import egovframework.fusion.galary.vo.LikeVO;
import egovframework.fusion.galary.vo.MediaVO;
import egovframework.fusion.galary.vo.TagRcdVO;
import egovframework.fusion.galary.vo.TagsVO;

@Service
public class GalaryServiceImpl extends EgovAbstractServiceImpl implements GalaryService{
	

	@Autowired
	GalaryMapper galaryMapper;
	
	@Autowired
	GalaryService galaryservice;
	
//	@Resource(name="propertiesService")
//	EgovPropertyService pService;
	
	String originalPath = "C:/upload/OriginalImage/";
	String resizePath =  "C:/upload/ResizeImage/";
	
	 
	@Override
	public List<GalaryVO> getGalaryList(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		List<GalaryVO> list = galaryMapper.getGalaryList(galaryVo);
		List<String>taglist = new ArrayList<>();
		for(int i = 0; i<list.size(); i++) {
			String tags = list.get(i).getTag_name();
			String[] array = tags.split(",");
			for(int j=0; j<array.length; j++) {
				taglist.add(array[j]);
			}
			for (String str : array) {
				System.out.println("태그 : " + str);
			}
			for (String str : taglist) {
				System.out.println("태그리스트 : " + str);
			}
			
			list.get(i).setTagArr(taglist);
			taglist = new ArrayList<>();
		}
		
		return list;
	}

	@Override
	public GalaryVO getGalary(Integer galary_id) {
		// TODO Auto-generated method stub
		return galaryMapper.getGalary(galary_id);
	}

	@Override
	public void insGalaryPost(GalaryVO galaryVo) {
		galaryMapper.insGalaryPost(galaryVo);
		
	}

	@Override
	public void delGalaryPost(GalaryVO galaryVo) {
		galaryMapper.delGalaryPost(galaryVo);
		
	}

	@Override
	public void UpdateGalaryPost(GalaryVO galaryVo, MultipartFile[] uploadFiles) {
		//갤러리 수정
		galaryMapper.UpdateGalaryPost(galaryVo);
		
		//태그삭제
		if (galaryVo.getDelTagArr() != null) {
			galaryMapper.delTags(galaryVo);
		}
		//태그추가
		if( galaryVo.getTagArr() != null) {
			galaryMapper.insTags(galaryVo);
		}
		//사진삭제
		if(galaryVo.getImgDelArr()!= null) {
			galaryMapper.delImage(galaryVo);
		}
		
		//선언
		MediaVO mediavo = new MediaVO();
		
		if (uploadFiles != null) {
		   if(galaryVo.getOriginal_name()!= null) {
			//새로운 썸네일 아이디가 있을때 ~ //썸네일을 취소시켜주어야 합니다..
			   Integer num = galaryVo.getGalary_id();
			   galaryMapper.cancelThumnail(num); 
			   mediavo.setGalary_id(galaryVo.getGalary_id());
			   mediavo.setOriginal_name(galaryVo.getOriginal_name());
			   //원래 있던 이미지가 썸네일로 바뀌었을때
			   galaryMapper.changeThumnail(galaryVo);
		   }
		   
		   //이미지 등록~~
		   mediavo.setGalary_id(galaryVo.getGalary_id());

			for(int i=0;i<uploadFiles.length;i++) {
				MultipartFile[] upload= {uploadFiles[i]};
				galaryservice.insImage(upload, mediavo);
			}		
		}//end of if
	}

	@Override
	public void updateImage(MediaVO mediaVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delImage(MediaVO mediaVO) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<MediaVO> insImage(MultipartFile[] uploadfile,MediaVO media) {
		 List<MediaVO> list = new ArrayList<MediaVO>();
		 MediaVO vo = new MediaVO();
		 MediaVO reVO = new MediaVO();

		 //파일 경로위치에 물리적으로 저장하기 - 사진이 없을 때도 고려
	      for(MultipartFile file : uploadfile) {
	         if(!file.isEmpty()) {
	        	 
	        	 System.out.println("썸네일당첨" + media.getOriginal_name());
        		 System.out.println("파일명" +file.getOriginalFilename());
        		 
	        	 if(file.getOriginalFilename().equals(media.getOriginal_name())) {
	        		 
	        		 //썸네일이란 뜻 
	        		 vo.setUuid(UUID.randomUUID().toString());
	        		 vo.setOriginal_name(file.getOriginalFilename());
	        		 vo.setFile_name("thumnail"+vo.getUuid() + "_" + vo.getOriginal_name());
	        		 vo.setThumnail_yn("y");
	        		 
	        	 }else {
	        		 System.out.println(file.getOriginalFilename());
	 	        	vo.setUuid(UUID.randomUUID().toString());
	 	        	vo.setOriginal_name(file.getOriginalFilename()); 
	 	        	vo.setFile_name(vo.getUuid());
	 	        	vo.setThumnail_yn("n");
	        	 }
	        	
	        	
	        	vo.setFile_size(file.getSize());
	        	String str = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));
	            String folderPath = str.replace("/", File.separator);

	            //make folder ==================
	            File originalPathFolder= new File(originalPath, folderPath);
	            File resizePathFolder = new File(resizePath, folderPath);
	            //File newFile= new File(dir,"파일명");
	            //->부모 디렉토리를 파라미터로 인스턴스 생성
	            
	            if(originalPathFolder.exists() == false){
	            	originalPathFolder.mkdirs();
	            	originalPathFolder.setWritable(true);
	                //만약 uploadPathFolder가 존재하지않는다면 makeDirectory하라는 의미
	                //mkdir(): 디렉토리에 상위 디렉토리가 존재하지 않을경우에는 생성이 불가능한 함수
	    			//mkdirs(): 디렉토리의 상위 디렉토리가 존재하지 않을 경우에는 상위 디렉토리까지 모두 생성하는 함수
	               }

	            String originalName = originalPath + File.separator + folderPath +File.separator + vo.getUuid() + "_" + vo.getOriginal_name();
	            
	            Path originalSavePath = Paths.get(originalName);
	            //파일저장
	            try {
					file.transferTo(originalSavePath);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	            vo.setFile_route(folderPath + "/" + vo.getUuid() + "_" + vo.getOriginal_name());

	            list.add(vo);

	            //리사이징
	            if(resizePathFolder.exists() == false){
	            	resizePathFolder.mkdirs();
	            	resizePathFolder.setWritable(true);
	                //만약 resizePathFolder가 존재하지않는다면 makeDirectory하라는 의미
	                //mkdir(): 디렉토리에 상위 디렉토리가 존재하지 않을경우에는 생성이 불가능한 함수
	    			//mkdirs(): 디렉토리의 상위 디렉토리가 존재하지 않을 경우에는 상위 디렉토리까지 모두 생성하는 함수
	               }
	            
	            // MultipartFile을 BufferedImage로 변환
	            BufferedImage img;
				try {
					img = ImageIO.read(file.getInputStream());
				     int imgwidth = img.getWidth();
			         int imgheight = img.getHeight();
			         //리사이징할거 정의 
			          int resizewidth = (int) (imgwidth*0.8);
			          int resizeHeight = (int) (imgheight*0.8);
			          
			          // 리사이징된 이미지 생성
		            BufferedImage resizedImg = new BufferedImage(resizewidth, resizeHeight, BufferedImage.TYPE_INT_RGB);
		            resizedImg.createGraphics().drawImage(img.getScaledInstance(resizewidth, resizeHeight, java.awt.Image.SCALE_SMOOTH), 0, 0, null);
		            
		            String resizeName = resizePath + File.separator + folderPath +File.separator + vo.getUuid() + "_" + vo.getOriginal_name();
		            Path resizeSavePath = Paths.get(resizeName);
		            ImageIO.write(resizedImg, "jpg", resizeSavePath.toFile());
		            // 리사이징된 이미지 저장
		            
		            long resizesize = resizeSavePath.toFile().length();
		            reVO.setFile_size(resizesize);
		            
		            reVO.setOriginal_name(vo.getOriginal_name());
		            reVO.setFile_route(folderPath + "/" + vo.getUuid() + "_" + vo.getOriginal_name());
		            reVO.setFile_name("Resize"+vo.getFile_name());  
		            reVO.setUuid(vo.getUuid());
		            reVO.setThumnail_yn(vo.getThumnail_yn());
		            list.add(reVO);
				} catch (IOException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
	         }//end if
	      }
	      
	      //저장한 파일 데이터베이스에 저장하기
	      for(int i=0; i<list.size(); i++) {
	    	  MediaVO newvo= new MediaVO();
	    	  newvo.setOriginal_name(list.get(i).getOriginal_name());
	    	  newvo.setFile_route(list.get(i).getFile_route());
	    	  newvo.setFile_name(list.get(i).getFile_name());
	    	  newvo.setGalary_id(media.getGalary_id());
	    	  newvo.setFile_size(list.get(i).getFile_size());
	    	  newvo.setThumnail_yn(list.get(i).getThumnail_yn());
	    	  newvo.setDel_yn("n");
	    	  galaryMapper.insImage(newvo);
	       }
	      return list;
	}

	@Override
	public void insTags(GalaryVO galaryvo) {
		
		galaryMapper.insTags(galaryvo);
	}

	@Override
	public void delTags(TagsVO tagsVo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Integer CkGalHistory(GalaryHistoryVO galaryhistoryVO) {
		
		return galaryMapper.CkGalHistory(galaryhistoryVO);
	}

	@Override
	public void InsGalHistory(GalaryHistoryVO galaryhistoryVO) {
		galaryMapper.InsGalHistory(galaryhistoryVO);
	}

	@Override
	public void InsDownloads(DownloadsVO downloadsVO) {
		galaryMapper.InsDownloads(downloadsVO);
		
	}

	@Override
	public Integer cntDownloads(DownloadsVO downloadsVO) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Integer cntLikes(LikeVO likevo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void InsLikes(LikeVO likevo) {
		// TODO Auto-generated method stub
		galaryMapper.InsLikes(likevo);;
	}

	@Override
	public Integer ckLikes(LikeVO likevo) {
		// TODO Auto-generated method stub
		return galaryMapper.ckLikes(likevo);
	}

	@Override
	public void delLikes(LikeVO likevo) {
		// TODO Auto-generated method stub
		galaryMapper.delLikes(likevo);
	}

	@Override
	public Integer cntGalary(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.cntGalary(galaryVo);
	}

	@Override
	public List<MediaVO> getAllResize(MediaVO mediavo) {
		// TODO Auto-generated method stub
		return galaryMapper.getAllResize(mediavo);
	}

	@Override
	public List<TagsVO> getTags(Integer galary_id) {
		// TODO Auto-generated method stub
		return galaryMapper.getTags(galary_id);
	}

	@Override
	public void updateDownCnt(Integer media_Id) {
	
		galaryMapper.updateDownCnt(media_Id);
	}

	@Override
	public MediaVO getThumnail(Integer galary_id) {
		// TODO Auto-generated method stub
		return galaryMapper.getThumnail(galary_id);
	}

	@Override
	public MediaVO mediasrh(Integer medianame, Integer galary_id) {
		// TODO Auto-generated method stub
		Map<String,Object> map = new HashMap<>();
		map.put("media_id", medianame);
		map.put("galary_id", galary_id);
		return galaryMapper.mediasrh(map);
	}

	@Override
	public List<GalaryVO> getRanksCnt(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getRanksCnt(galaryVo);
	}

	@Override
	public List<GalaryVO> getRankLike(GalaryVO galaryVO) {
		// TODO Auto-generated method stub
		return galaryMapper.getRankLike(galaryVO);
	}

	@Override
	public List<TagsVO> getRanksTags(GalaryVO vo) {
		// TODO Auto-generated method stub
		return galaryMapper.getRanksTags(vo);
	}

	@Override
	public List<GalaryVO> getRanksDownCnt(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getRanksDownCnt(galaryVo);
	}

	@Override
	public List<GalaryVO> getCntstatsByDay(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getCntstatsByDay(galaryVo);
	}

	@Override
	public List<GalaryVO> getCntstatsByWeek(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getCntstatsByWeek(galaryVo);
	}

	@Override
	public List<GalaryVO> getCntstatsByMonth(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getCntstatsByMonth(galaryVo);
	}

	@Override
	public List<GalaryVO> getDownstatsByDay(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getDownstatsByDay(galaryVo);
	}

	@Override
	public List<GalaryVO> getDownstatsByWeek(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getDownstatsByWeek(galaryVo);
	}

	@Override
	public List<GalaryVO> getDownstatsByMonth(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getDownstatsByMonth(galaryVo);
	}

	@Override
	public List<GalaryVO> getLikeStatsByDay(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getLikeStatsByDay(galaryVo);
	}

	@Override
	public List<GalaryVO> getLikeStatsByWeek(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		return galaryMapper.getLikeStatsByWeek(galaryVo);
	}

	@Override
	public List<GalaryVO> getLikestatsByMonth(GalaryVO galaryVo) {
		// TODO Auto-generated method stub
		System.out.println("galleryVO @@@@@" + galaryVo.toString());
		
		return galaryMapper.getLikestatsByMonth(galaryVo);
	}

	@Override
	public void inputTagsRcd(TagRcdVO vo) {
		// TODO Auto-generated method stub
		galaryMapper.inputTagsRcd(vo);
	}

	@Override
	public List<TagsVO> allTags() {
		// TODO Auto-generated method stub
		return galaryMapper.allTags();
	}

	@Override
	public List<GalaryVO> getTagStaticsByDay(GalaryVO vo) {
		// TODO Auto-generated method stub
		return galaryMapper.getTagStaticsByDay(vo);
	}

	@Override
	public List<GalaryVO> getTagStaticsByWeek(GalaryVO vo) {
		// TODO Auto-generated method stub
		return galaryMapper.getTagStaticsByWeek(vo);
	}

	@Override
	public List<GalaryVO> getTagStaticsByMonth(GalaryVO vo) {
		// TODO Auto-generated method stub
		return galaryMapper.getTagStaticsByMonth(vo);
	}



	



}
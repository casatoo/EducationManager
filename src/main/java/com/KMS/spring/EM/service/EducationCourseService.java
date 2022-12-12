package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.EducationCourseRepository;
import com.KMS.spring.EM.repository.MemberRepository;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.EducationCourse;
import com.KMS.spring.EM.vo.Member;
import com.KMS.spring.EM.vo.ResultData;
import com.KMS.spring.EM.vo.registeInfo;

/**
 * 
 * @author Administrator
 * 서비스 어노테이션 추가
 */
@Service
public class EducationCourseService {
	@Autowired
	private AttrService attrService;
/**
 * 리포지토리에 연결해야되니까 인스턴스 객체 만들기
 */
	@Autowired
	public EducationCourseRepository educationCourseRepository;
	
	/**
	 * 생성자
	 * @param educationCourseRepository
	 */
	public EducationCourseService(EducationCourseRepository educationCourseRepository) {
		this.educationCourseRepository = educationCourseRepository;
	}
	/**
	 * 교육과정 일부 리스트 조회
	 * @return List<EducationCourse>
	 */
	public List<EducationCourse> getEducationCourseSomeList( int limitFrom, int itemsInAPage){
		
		return educationCourseRepository.getEducationCourseSomeList(limitFrom,itemsInAPage);
	}
	/**
	 * 10자리 인증코드 생성
	 * attrService에 값 생성
	 * @param loginMemberId
	 * @return String
	 */
	public String educationCourseModifyAuthKey(int educationCourseId) {
		String educationCourseModifyAuthKey = Ut.getTempPassword(10);

		attrService.setValue("educationCourse", educationCourseId, "extra", "educationCourseModifyAuthKey", educationCourseModifyAuthKey,Ut.getDateStrLater(60 * 5));

		return educationCourseModifyAuthKey;
	}
	
	
	/**
	 * 교육과정 상세 조회
	 * @param id
	 * @return EducationCourse
	 */
	public EducationCourse getEducationCourse(int id) {
		return educationCourseRepository.getEducationCourse(id);
	}
	
	public List<EducationCourse> getEducationCourseList(){
		
		return educationCourseRepository.getEducationCourseList();
	}
	
	public List<registeInfo> getMyeduStatus(int id) {
		
		return educationCourseRepository.getMyeduStatus(id);
	}
	public ResultData doModify(
			int educationCourseId, 
			String startOfEducation, 
			String endOfEducation, 
			String title, 
			String place, 
			int managerMemberId, 
			int status) {
		
		educationCourseRepository.doModify(educationCourseId, startOfEducation, endOfEducation, title, place, managerMemberId,status);
		return ResultData.from("S-1","교육과정 수정 성공","id",educationCourseId);
		
	}
	public ResultData registe(int educationCourseId, int memberId) {
		
		registeInfo rd = educationCourseRepository.getRegisteInfo(educationCourseId,memberId);
		
		if(rd != null) {
			return ResultData.from("F-1", Ut.f("이미 등록되어 있습니다."));
		}
		
		educationCourseRepository.registe(educationCourseId,memberId);
		
		return ResultData.from("S-1", Ut.f("수강신청되었습니다."));
	}
	public ResultData doDelete(int educationCourseId, int memberId) {
		
		registeInfo rd = educationCourseRepository.getRegisteInfo(educationCourseId,memberId);
		
		if(rd == null) {
			return ResultData.from("F-1", Ut.f("수강중인 과정이 아닙니다."));
		}
		
		educationCourseRepository.doDelete(educationCourseId,memberId);
		
		return ResultData.from("S-1","수강취소되었습니다.","id",educationCourseId);
	}
	public ResultData create(String title, String startOfEducation, String endOfEducation, String place,
			int managerMemberId) {
			
		EducationCourse educationCourse= educationCourseRepository.getEducationCourseByTitle(title);
		if(educationCourse != null) {
			return ResultData.from("F-1", Ut.f("이미 등록된 과정입니다."));
		}
		
		educationCourseRepository.create(title,startOfEducation,endOfEducation,place,managerMemberId);
		
		return ResultData.from("S-1", Ut.f("교육과정 등록 성공"));
	}
	public ResultData delete(int educationCourseId) {
		
		EducationCourse educationCourse = educationCourseRepository.getEducationCourse(educationCourseId);
		if(educationCourse == null) {
			return ResultData.from("F-1", Ut.f("존재하지 않는 교육과정입니다."));
		}
		educationCourseRepository.delete(educationCourseId);
		return ResultData.from("S-1", Ut.f("교육과정을 삭제 했습니다."));
	}
	
}

package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.EducationCourseRepository;
import com.KMS.spring.EM.repository.MemberRepository;
import com.KMS.spring.EM.vo.EducationCourse;
import com.KMS.spring.EM.vo.registeInfo;

/**
 * 
 * @author Administrator
 * 서비스 어노테이션 추가
 */
@Service
public class EducationCourseService {

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
	
}

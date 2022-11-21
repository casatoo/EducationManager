package com.KMS.spring.EM.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.KMS.spring.EM.repository.EducationCourseRepository;
import com.KMS.spring.EM.repository.MemberRepository;
import com.KMS.spring.EM.vo.EducationCourse;

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
	
	public EducationCourseService(EducationCourseRepository educationCourseRepository) {
		this.educationCourseRepository = educationCourseRepository;
	}
	
	public List<EducationCourse> getEducationCourseList(){
		
		return educationCourseRepository.getEducationCourseList();
	}

	public EducationCourse getEducationCourse(int id) {
		return educationCourseRepository.getEducationCourse(id);
	}
}

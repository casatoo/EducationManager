package com.KMS.spring.EM.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KMS.spring.EM.vo.EducationCourse;

@Mapper
public interface EducationCourseRepository {
	
	public List<EducationCourse> getEducationCourseSomeList(int limitFrom, int itemsInAPage);

	public EducationCourse getEducationCourse(int id);

	public List<EducationCourse> getEducationCourseList();
}
package com.KMS.spring.EM.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.KMS.spring.EM.vo.EducationCourse;
import com.KMS.spring.EM.vo.registeInfo;

@Mapper
public interface EducationCourseRepository {
	
	public List<EducationCourse> getEducationCourseSomeList(int limitFrom, int itemsInAPage);

	public EducationCourse getEducationCourse(int id);

	public List<EducationCourse> getEducationCourseList();

	public List<registeInfo> getMyeduStatus(int id);

	public void doModify(int educationCourseId, String startOfEducation, String endOfEducation, String title, String place, int managerMemberId, int status);

	public void registe(int educationCourseId, int memberId);

	public registeInfo getRegisteInfo(int educationCourseId, int memberId);

	public void doDelete(int educationCourseId, int memberId);

	public EducationCourse getEducationCourseByTitle(String title);

	public void create(String title, String startOfEducation, String endOfEducation, String place, int managerMemberId);

	public void delete(int educationCourseId);
}
package com.KMS.spring.EM.controllr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KMS.spring.EM.service.EducationCourseService;
import com.KMS.spring.EM.vo.EducationCourse;
import com.KMS.spring.EM.vo.ResultData;
import com.KMS.spring.EM.vo.Rq;
import com.KMS.spring.EM.vo.registeInfo;

@Controller
public class UsrEducationCourseController {
	
	@Autowired
	EducationCourseService educationCourseService;
	@Autowired
	private Rq rq;
	/**
	 * 교육과정 상세보기
	 * 디테일 페이지로 이동
	 * @param id
	 * @param model
	 * @return
	 */
	@RequestMapping("usr/educationCourse/detail")
	public String detail(int id,Model model) {
		
		EducationCourse educationCourse = educationCourseService.getEducationCourse(id);
		
		model.addAttribute("educationCourse",educationCourse);
		
		return "usr/educationCourse/detail";
	}
	@RequestMapping("usr/educationCourse/calendar")
	public String detail(Model model) {
		List<EducationCourse> educationCourses = educationCourseService.getEducationCourseList();
		
		model.addAttribute("educationCourses",educationCourses);
		return "usr/educationCourse/calendar";
	}
	
	@RequestMapping("usr/educationCourse/schedule")
	@ResponseBody
	public ResultData schedule(Model model) {
		
		
		List<EducationCourse> educationCourses = educationCourseService.getEducationCourseList();
		
		ResultData rd = ResultData.from("S-1", "조회성공", "educationCourses",educationCourses);
		
		return rd;
	}
	@RequestMapping("usr/educationCourse/eduStatus")
	public String eduStatus(Model model) {
		List<registeInfo> myeduStatus = educationCourseService.getMyeduStatus(rq.getLoginedMemberId());
		
		model.addAttribute("myeduStatus",myeduStatus);
		return "usr/educationCourse/eduStatus";
	}

}

package com.KMS.spring.EM.controllr;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KMS.spring.EM.service.EducationCourseService;
import com.KMS.spring.EM.vo.EducationCourse;

@Controller
public class UsrEducationCourseController {
	
	@Autowired
	EducationCourseService educationCourseService;
	
	
	@RequestMapping("usr/educationCourse/detail")
	public String detail(int id,Model model) {
		
		EducationCourse educationCourse = educationCourseService.getEducationCourse(id);
		
		model.addAttribute("educationCourse",educationCourse);
		
		return "usr/educationCourse/detail";
	}

}

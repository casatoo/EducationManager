package com.KMS.spring.EM.controllr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KMS.spring.EM.service.EducationCourseService;
import com.KMS.spring.EM.vo.EducationCourse;

@Controller
public class UsrHomeController {
	@Autowired
	EducationCourseService educationCourseService;
	
	@RequestMapping("usr/home/main")
	public String showMain(Model model) {
		
		List<EducationCourse> educationCourses = educationCourseService.getEducationCourseList();
		
		model.addAttribute("educationCourses",educationCourses);
		return "usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:usr/home/main";
	}
}

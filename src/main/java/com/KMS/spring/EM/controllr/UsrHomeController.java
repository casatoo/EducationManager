package com.KMS.spring.EM.controllr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.KMS.spring.EM.service.ArticleService;
import com.KMS.spring.EM.service.EducationCourseService;
import com.KMS.spring.EM.vo.Article;
import com.KMS.spring.EM.vo.EducationCourse;
import com.KMS.spring.EM.vo.Rq;

@Controller
public class UsrHomeController {
	@Autowired
	private EducationCourseService educationCourseService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private Rq rq;
	
	@RequestMapping("usr/home/main")
	public String showMain(Model model) {
		
		/**
		 * 최근 작성된 부터 3개 교육과정 가져옴
		 */
		List<EducationCourse> educationCourses = educationCourseService.getEducationCourseSomeList(0,3);
		/**
		 * 최근 작성된 공지사항 게시글 6개 가져옴
		 */
		List<Article> articles = articleService.getForPrintArticles(1, 0, 6, "", "");
		
		model.addAttribute("educationCourses",educationCourses);
		model.addAttribute("articles",articles);
		return "usr/home/main";
	}

	@RequestMapping("/")
	public String showRoot() {
		return "redirect:usr/home/main";
	}
}

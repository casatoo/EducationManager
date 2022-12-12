package com.KMS.spring.EM.controllr;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.KMS.spring.EM.service.AttrService;
import com.KMS.spring.EM.service.EducationCourseService;
import com.KMS.spring.EM.utill.Ut;
import com.KMS.spring.EM.vo.Attr;
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
	@Autowired
	AttrService attrService;
	
	
	@RequestMapping("usr/educationCourse/registe")
	@ResponseBody
	public String doAdd(int educationCourseId) {
		List<registeInfo> myeduStatus = educationCourseService.getMyeduStatus(rq.getLoginedMemberId());
		
		ResultData rd = educationCourseService.registe(educationCourseId, rq.getLoginedMemberId());
		
		return Ut.jsReplace(rd.getMsg(), "../educationCourse/eduStatus");
				
	}

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
	/**
	 * 인증 코드 생성
	 * @return String
	 */
	@RequestMapping("/usr/educationCourse/createAuthKey")
	@ResponseBody
	public String createAuthKey(int educationCourseId) {
		
		String educationCourseModifyAuthKey = educationCourseService.educationCourseModifyAuthKey(educationCourseId);
		
		return educationCourseModifyAuthKey;
	}
	@RequestMapping("usr/educationCourse/doModify")
	@ResponseBody
	public String doModify(
			int educationCourseId, 
			String startOfEducation,
			String endOfEducation,
			String title, 
			String place,
			int managerMemberId,
			int status, 
			String educationCourseModifyAuthKey) {
		
		if(educationCourseModifyAuthKey == null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 생성되지 않았습니다."));
		}
		Attr getAttr = attrService.get("educationCourse", educationCourseId, "extra", "educationCourseModifyAuthKey");
		
		if(getAttr==null) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 만료되었습니다. 다시 시도해주세요"));
		}
		if(!getAttr.getValue().equals(educationCourseModifyAuthKey)) {
			return Ut.jsHistoryBack(Ut.f("인증코드가 일치하지 않습니다. 다시 시도해주세요"));
		}
		
		startOfEducation = startOfEducation.replaceAll("-","");
		endOfEducation = endOfEducation.replaceAll("-","");
		
		if(Ut.empty(startOfEducation)) {
			return Ut.jsHistoryBack(Ut.f("교육 시작일을 지정해주세요"));
		}
		if(Ut.empty(endOfEducation)) {
			return Ut.jsHistoryBack(Ut.f("교육 종료일을 지정해주세요"));
		}
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack(Ut.f("교육과정명을 입력해주세요"));
		}
		if(Ut.empty(place)) {
			return Ut.jsHistoryBack(Ut.f("교육 장소를 입력해주세요"));
		}
		
		ResultData rd = educationCourseService.doModify(educationCourseId, startOfEducation,endOfEducation,title,place,managerMemberId,status);
		
		return Ut.jsReplace(Ut.f("%d번 교육과정 수정", educationCourseId),  Ut.f("../educationCourse/detail?id=%d", educationCourseId));
	}
	
	@RequestMapping("usr/educationCourse/doDelete")
	@ResponseBody
	public String doDelete(int educationCourseId) {
		
		ResultData rd = educationCourseService.doDelete(educationCourseId, rq.getLoginedMemberId());
		
		return Ut.jsReplace(rd.getMsg(), "../educationCourse/eduStatus");
				
	}
	@RequestMapping("usr/educationCourse/create")
	@ResponseBody
	public String create(String title, String startOfEducation, String endOfEducation,String place, int managerMemberId ) {
		
		if(Ut.empty(startOfEducation)) {
			return Ut.jsHistoryBack(Ut.f("교육 시작일을 지정해주세요"));
		}
		if(Ut.empty(endOfEducation)) {
			return Ut.jsHistoryBack(Ut.f("교육 종료일을 지정해주세요"));
		}
		if(Ut.empty(title)) {
			return Ut.jsHistoryBack(Ut.f("교육과정명을 입력해주세요"));
		}
		if(Ut.empty(place)) {
			return Ut.jsHistoryBack(Ut.f("교육 장소를 입력해주세요"));
		}
		if(Ut.empty(managerMemberId)) {
			return Ut.jsHistoryBack(Ut.f("담당자를 선택해주세요"));
		}
		
		ResultData rd = educationCourseService.create(title,startOfEducation,endOfEducation,place,managerMemberId);
		
		return Ut.jsReplace(rd.getMsg(), "../educationCourse/calendar");
	}
	
	@RequestMapping("usr/educationCourse/delete")
	@ResponseBody
	public String delete(int educationCourseId) {
		
		ResultData rd = educationCourseService.delete(educationCourseId);
		
		return Ut.jsReplace(rd.getMsg(), "../educationCourse/calendar");
	}
}

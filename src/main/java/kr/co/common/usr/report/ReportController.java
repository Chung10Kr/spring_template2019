package kr.co.common.usr.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.common.utl.codeUtil.service.CodeUtilService;
import kr.co.common.utl.file.service.FileService;
import kr.co.common.com.controller.DefaultController;
import kr.co.common.usr.notice.service.NoticeService;
import kr.co.common.com.utils.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * 설 명 : 리포트
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 11. 26.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11. 26.       lcy         최초 생성
 * </pre>
 */
@Controller
public class ReportController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "NoticeService")
	private NoticeService noticeService;
	
	@RequestMapping(value = "/USR/REPORT/notice")
	public ModelAndView  onNotice() throws Exception {
		/************** 프로그램 로직 **************/
		Map<String,Object> result = noticeService.get(commandMap); //공지사항 조회
		/************** 프로그램 로직 **************/
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/CIS/CIS1140R0";
		mav.setViewName(resultURL);
		mav.addObject("result",result);
		/************** ModelView 로직 **************/
		return mav;
	};
}

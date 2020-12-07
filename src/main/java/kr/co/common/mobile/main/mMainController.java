package kr.co.common.mobile.main;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.com.controller.DefaultController;
import kr.co.common.usr.login.service.LoginService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 7.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 7.       lcy         최초 생성
 * </pre>
 */
@Controller
public class mMainController extends DefaultController {
	
	@Resource(name = "LoginService")
	private LoginService loginService;
	
	/*레이아웃*/
	@RequestMapping(value = "/MOBILE/{web_url1}/{web_url2}")
	public ModelAndView onMovileLay( @PathVariable String web_url1,@PathVariable String web_url2) throws Exception {
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/MOBILE/"+web_url1+"/"+web_url2;
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	};
	/*레이아웃*/

	
	@RequestMapping(value = "/MOBILE/LOGIN/check")
	public ModelAndView loginProc() throws Exception {
		
		HttpSession session = request.getSession(true);
		session.removeAttribute(SESSION_KEY_USER);
		session.removeAttribute("TopMenuListSession");
		session.removeAttribute("leftMenuListSession");
		
		/************** 프로그램 로직 **************/
		String resultMessage = null;
		String resultURL = null;
		
		Map<String,Object> member = loginService.getMember(commandMap);
		ModelAndView mav = new ModelAndView();
		
		if (!StringUtil.isBlank(member)) {
			// 메뉴권한정보
			resultURL = "redirect:/MOBILE/MAIN/main";
			
			session.setAttribute(SESSION_KEY_USER, member);
			
		}else{
			resultURL= "/NVWR/COMM/error";
			mav.addObject("ERROR_TYPE", "AlertAndRedirect");
			mav.addObject("REDIRECT_URL", "/MOBILE/LOGIN/login");
			mav.addObject("ERROR_MESSAGE", "[Hitec]\n아이디와 비밀번호를 확인해주세요.");
		}
		/************** 프로그램 로직 **************/
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		mav.setViewName(resultURL);
		mav.addObject("resultMessage", resultMessage );
		/************** ModelView 로직 **************/
		return mav;
	};
	
	
};



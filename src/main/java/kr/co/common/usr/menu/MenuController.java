package kr.co.common.usr.menu;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.common.com.controller.DefaultController;
import kr.co.common.com.utils.StringUtil;
import kr.co.common.usr.menu.service.MenuService;



/**
 * 설 명 : 메뉴 관련 컨트롤러
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 8.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 8.       lcy         최초 생성
 *  2019. 11. 7.       lcy         Left Menu 처리
 * </pre>
 */
@Controller
public class MenuController extends DefaultController {

	@SuppressWarnings("unused")
	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "MenuService")
	private MenuService menuService;

	/**
	* <pre>
	* 1. 개요 :     Top 메뉴 처리
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 7.
	* @Method Name : getLeftMenu
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/USR/TMENU/{web_url1}")
	public ModelAndView getLeftMenu( 
			@PathVariable String web_url1
			) throws Exception {
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		
		commandMap.put("SYSTEM_ID", web_url1 );
		commandMap.put("setTopMenu", "_Y" );
		
		HttpSession session = request.getSession(true);
		
		
		session.removeAttribute(SYSTEM_ID);
		session.setAttribute(SYSTEM_ID,web_url1);
		session.setAttribute("menuC","_Y");

		List<Map<String, Object>> leftMenuList = menuService.getLeftMenuList(commandMap);
		String onTop_Url = leftMenuList.get(0).get("menuurl").toString();
		String resultURL = "redirect:"+onTop_Url;
		mav.setViewName(resultURL);
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	};
	
	/**
	* <pre>
	* 1. 개요 :    Left 메뉴 처리
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 7.
	* @Method Name : getMenu
	* @return
	* @throws Exception
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/USR/LMENU/{web_url1}/{web_url2}")
	public ModelAndView getMenu( @PathVariable String web_url1,@PathVariable String web_url2 ) throws Exception {
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		
		HttpSession session = request.getSession(true);
		List<Map<String, Object>> leftMenuList = (List<Map<String, Object>>) session.getAttribute("leftMenuListSession");
		
		String source_path  = StringUtil.compareString(leftMenuList ,"menu_seq", web_url1+"/"+web_url2  , "source_path");
		String resultURL = "/VWR/"+source_path;
		
		/*
		Url 직접 변경시
		1. 같은 대 메뉴상에서 변경시 -> MenuController.java
		2. 다른 메뉴로 변경시 ->head.jsp
		*/
		if(source_path == null){
			resultURL= "/NVWR/COMM/error";
			mav.addObject("ERROR_TYPE", "AlertAndRedirect");
			mav.addObject("REDIRECT_URL", "/NVWR/COMM/main");
			mav.addObject("ERROR_MESSAGE", "직접 URL 변경은 제한됩니다.");
		};
		
			String menuNm  = StringUtil.noNull( StringUtil.compareString(leftMenuList ,"menu_seq", web_url1+"/"+web_url2  , "menu_nm") );
			
			mav.addObject("MENU_NM" , menuNm);
			mav.addObject("MENU_SEQ" , web_url1+"/"+web_url2);
			mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	};
	

}

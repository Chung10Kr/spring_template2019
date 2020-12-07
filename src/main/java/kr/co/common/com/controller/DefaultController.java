package kr.co.common.com.controller;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.usr.menu.service.MenuService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class DefaultController extends CommonController {

	static Logger logger = LoggerFactory.getLogger(DefaultController.class);

	@Resource(name = "MenuService")
	protected MenuService menuService;
	
	
	
	/**
	 * TOP 메뉴 정보 세팅
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@ModelAttribute("TopMenuList")
	public List<Map<String, Object>> init(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap) throws Exception {
		
		this.request = request;
		this.response = response;
		this.commandMap = commandMap;
		this.commandMap.putAll(getAuthUserInfo());// login_user_id 자동 세팅
		
		List<Map<String, Object>> topMenuList = null;
		List<Map<String, Object>> leftMenuList =null;
		HttpSession session = request.getSession(true);
		String theme = null;
		
		Map<String,Object > memberVo = getAuthenticatedUser();
		if (memberVo != null){
			//탑 메뉴 세션
			if (session.getAttribute("TopMenuListSession") != null) {
				topMenuList = (List<Map<String, Object>>) session.getAttribute("TopMenuListSession");
			} else {
				topMenuList = menuService.getTopMenuList(commandMap);
				session.setAttribute("TopMenuListSession", topMenuList);
			};
			this.commandMap.put("SYSTEM_ID",StringUtil.noNull( session.getAttribute(SYSTEM_ID) ) );
			
			//레프트 메뉴 세션
			if((session.getAttribute("leftMenuListSession") != null) && ( !"_Y".equals( StringUtil.noNull(session.getAttribute( "menuC" )) ))){
				leftMenuList = (List<Map<String, Object>>) session.getAttribute("leftMenuListSession"); 
			}else{
				leftMenuList = menuService.getLeftMenuList(commandMap);
				if(leftMenuList.size() != 0){
					session.setAttribute("leftMenuListSession", leftMenuList);
				};
			};
			session.removeAttribute("menuC");
			
			
			//테마 세션
			if (session.getAttribute("theme") != null) {
				theme = session.getAttribute("theme").toString();
			} else {
				theme = StringUtil.noNull(memberVo.get("theme").toString() , "NAVY" );
				session.setAttribute("theme", theme);
			};
			
			request.setAttribute("theme",theme);
			request.setAttribute("LeftMenuList", leftMenuList);
			
			//현재 해당하는 메뉴 find
			request.setAttribute("menuMap", StringUtil.compareMap(leftMenuList ,"menuurl", request.getServletPath() ) );			
			
		};
		
		
		
		return topMenuList;
	};
}

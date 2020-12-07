package kr.co.common.com.interceptor;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.common.com.utils.StringUtil;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 인증여부 체크 인터셉터 
 * 전자정부 공통 서비스 참조
 * 수정자 : LCY
 */
public class AuthenticInterceptor extends HandlerInterceptorAdapter {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	/**
	 * 세션에 계정정보(MemberMap)가 있는지 여부로 인증 여부를 체크한다. 
	 * 계정정보(MemberMap)가 없다면, 로그인 페이지로 이동한다.
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
			
		String contentType = StringUtil.noNull(request.getContentType());
        		
		HttpSession session = request.getSession(true);
		Map<String,Object> memberMap = (Map<String, Object>) session.getAttribute("memberMap");
		String webRoot = request.getServletPath();
		
		if(memberMap == null){ // 로그인을 하지 않은 상태 ,
			session.invalidate();
			if (log.isInfoEnabled()) {
				log.info("session is null");
			}
			String viewUrl = "/NVWR/COMM/error";
			
			//Ajax 처리
			if (contentType.equals("application/x-www-form-urlencoded; charset=UTF-8"))
			{
				viewUrl = "redirect:/ajaxAccessInfoFail";
			}
			
			ModelAndView model = new ModelAndView(viewUrl);
			model.addObject("ERROR_TYPE", "AlertAndRedirect");
			model.addObject("REDIRECT_URL", "/USR/LOGIN/login");
			model.addObject("ERROR_MESSAGE", "[Hitec]\n로그인 정보가 없습니다.\n다시 로그인 해주세요.");
			throw new ModelAndViewDefiningException(model);
		}
		
		return true;
	};

};

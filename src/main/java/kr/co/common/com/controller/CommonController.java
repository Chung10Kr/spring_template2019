package kr.co.common.com.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;



@Controller
public class CommonController implements ControllerConstants {

	private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

	protected HttpServletRequest request;
	protected HttpServletResponse response;
	protected Map<String, Object> commandMap;
	
	/**
	 * 인증된 사용자객체를 VO형식으로 가져온다.
	 * @return Object - 사용자 ValueObject
	 */
	@SuppressWarnings("unchecked")
	public Map<String,Object> getAuthenticatedUser() {
		return (Map<String,Object>) RequestContextHolder.getRequestAttributes().getAttribute(SESSION_KEY_USER, RequestAttributes.SCOPE_SESSION);
	}
	
	
	/**
	 * <pre>
	 * 1. 개요 : 인증된 사용자 정보 Map에 세팅
	 * 2. 처리내용 : 인증된 사용자 정보 Map에 세팅
	 * </pre>
	 * @Method Name : getAuthUserInfo
	 * @return
	 */
	public Map<String, Object> getAuthUserInfo() {
		Map<String, Object> returnMap = new HashMap<String, Object>();
		Map<String,Object> av = (Map<String,Object>) getAuthenticatedUser();
		if (av != null) {
			returnMap.put("login_user_id", av.get("user_id"));//아이디
			returnMap.put("login_lang", av.get("lang"));//언어
			returnMap.put("login_comp_cd", av.get("comp_cd"));//회사
			
		}
		return returnMap;
	}

	/**
	 * <pre>
	 * 1. 개요 : flshMap 값 리턴
	 * 2. 처리내용 : 저장, 수정, 삭제시 redirect:/ 를 이용해서 페이지를 이동시 함께 보내져야 할 parameter 들을 hidden 속성으로 보내면 , 해당 페이지에서 아래 함수를 호출하면
	 * 숨겨진 파라미터의 값을 꺼내올수 있습니다.
	 * redirect 를 보내기전에 해당 값들을 hidden 속성으로 보낼경우에는 일반적인 방법과 동일하게 cMap 에 추가 한뒤에 아래와 같이 flashMap 에 cMap 의 값을 복사하면 됩니다
	 * setFlashMap(cMap, request)
	 * 위와 같이 한 후에 redirect:/보내질주소경로 를 하면 아래 함수를 통해서 hidden 속성의 값을 가져올 수 있습니다.
	 * </pre>
	 * @Method Name : getFlashMap
	 * @param cMap
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	protected Map<String, Object> getFlashMap(Map<String, Object> cMap, HttpServletRequest request){
		Map<String, Object> flashMap = (Map<String, Object>) RequestContextUtils.getInputFlashMap(request);
		if (flashMap != null) {
			cMap.putAll(flashMap);
		}
		return cMap;
	}

	/**
	 * <pre>
	 * 1. 개요 : flashMap 값 세팅
	 * 2. 처리내용 : redirect 를 사용시 hidden 속성으로 파라미터를 전송하려고 할 경우 아래 함수를 호출
	 * </pre>
	 * @Method Name : setFlashMap
	 * @param cMap
	 * @param request
	 * @throws Exception
	 */
	protected void setFlashMap(Map<String, Object> cMap, HttpServletRequest request) throws Exception {
		FlashMap flashMap = RequestContextUtils.getOutputFlashMap(request);
		flashMap.putAll(cMap);
	}
	/**
	 * <pre>
	 * 1. 개요 : 메시지처리 데이터모델 생성
	 * 2. 처리내용 :
	 * </pre>
	 * @Method Name : getErrorModel
	 * @param errorType - 메시지유형[참조: 메시지처리 구분코드]
	 * @param errorMessage - 메시지메세지[메시지유형이 Script 처리일 경우는 Script값]
	 * @return ModelAndView
	 * @throws Exception
	 */
	protected final ModelAndView getErrorModel(String errorType, String errorMessage){
		return getErrorModel(errorType, errorMessage, "");
	}

	/**
	 * <pre>
	 * 1. 개요 : 에러 처리 데이터모델 생성
	 * 2. 처리내용 :
	 * </pre>
	 * @Method Name : getErrorModel
	 * @param errorType - 메시지유형[참조: 메시지처리 구분코드]
	 * @param errorMessage - 메시지메세지[메시지유형이 Script 처리일 경우는 Script값]
	 * @param redirectUrl - 페이지이동주소
	 * @return ModelAndView
	 * @throws Exception
	 */
	protected final ModelAndView getErrorModel(String errorType, String errorMessage, String redirectUrl){

		ModelAndView model = new ModelAndView(ERROR_HANDLER_PATH);
		model.addObject("ERROR_TYPE", errorType);
		if (ERROR_SCRIPT_ONLY.equals(errorType)) {
			model.addObject("SCRIPT", errorMessage);
		} else {
			model.addObject("ERROR_MESSAGE", errorMessage);
			model.addObject("REDIRECT_URL", redirectUrl);
		}
		return model;
	}
}

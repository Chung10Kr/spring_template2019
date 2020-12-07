package kr.co.common.com.controller;



/**
 * 컨트롤러 기본 상수
 * @author 개발팀 Bang-ji-hwan
 * @since 2013.08.31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2013.08.31  bjh            최초 생성
 *
 * </pre>
 */
public interface ControllerConstants {

	/** 회원 세션아이디 */
	public static final String SESSION_KEY_USER = "memberMap";
	/** SYSTEM_ID Session ID*/
	public static final String SYSTEM_ID = "SYSTEM_ID";
	
	
	/** 에러 처리 구분코드 */
	public static final String ERROR_ALERT_AND_NONE 	= "AlertAndNone";
	public static final String ERROR_ALERT_AND_BACK 	= "AlertAndBack";
	public static final String ERROR_ALERT_AND_RELOAD 	= "AlertAndReload";
	public static final String ERROR_ALERT_AND_REDIRECT = "AlertAndRedirect";
	public static final String ERROR_ALERT_AND_CLOSE 	= "AlertAndClose";
	public static final String ERROR_SCRIPT_ONLY 		= "ScriptOnly";
	public static final String ERROR_HANDLER_PATH 		= "cmmn/errorMessage";
	
}

package kr.co.common.usr.auth;

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
import kr.co.common.usr.auth.service.AuthService;
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
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 12. 16.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 12. 16.       lcy         최초 생성
 * </pre>
 */
@Controller
public class AuthController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "AuthService")
	private AuthService authService;
	
	@Resource(name = "FileService")
	private FileService fileService;
	
	/**
	* <pre>
	* 1. 개요 :    권한조회
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 12. 16.
	* @Method Name : onGetList
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/AUTH/getList")
	public Map<String,Object>  onGetList() throws Exception {
		
		List<Map<String,Object>> returnList = authService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :   role별 권한 조회  
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 12. 16.
	* @Method Name : onGetList2
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/AUTH/getAuthList")
	public Map<String,Object>  onGetList2() throws Exception {
		
		List<Map<String,Object>> returnList = authService.getAuthList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :   권한 수정
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 12. 16.
	* @Method Name : onUpdateAuth
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/AUTH/updateAuth")
	public Map<String,Object>  onUpdateAuth() throws Exception {
		
		authService.updateAuth(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		return returnMap;
	};
		
}

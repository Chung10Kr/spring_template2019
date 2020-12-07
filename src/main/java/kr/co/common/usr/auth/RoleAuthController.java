package kr.co.common.usr.auth;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import kr.co.common.utl.file.service.FileService;
import kr.co.common.com.controller.DefaultController;
import kr.co.common.usr.auth.service.RoleAuthService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 12. 26.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 12. 26.       lcy         최초 생성
 * </pre>
 */
@Controller
public class RoleAuthController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "RoleAuthService")
	private RoleAuthService roleAuthService;
	
	@Resource(name = "FileService")
	private FileService fileService;
	
	
	@ResponseBody
	@RequestMapping(value = "/USR/RAUTH/getList")
	public Map<String,Object>  onGetList() throws Exception {
		
		List<Map<String,Object>> returnList = roleAuthService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	
	@ResponseBody
	@RequestMapping(value = "/USR/RAUTH/getAuthList")
	public Map<String,Object>  onGetList2() throws Exception {
		
		List<Map<String,Object>> returnList = roleAuthService.getAuthList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	
	@ResponseBody
	@RequestMapping(value = "/USR/RAUTH/updateRole")
	public Map<String,Object>  onUpdateAuth() throws Exception {
		
		roleAuthService.updateAuth(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		return returnMap;
	};
		
}

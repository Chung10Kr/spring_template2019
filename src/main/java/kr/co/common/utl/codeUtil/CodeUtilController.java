package kr.co.common.utl.codeUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import kr.co.common.utl.codeUtil.service.CodeUtilService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * 설 명 : 공통으로 사용될 코드를 관리한다.
 * @author 개발팀 Bang-ji-hwan
 * @since 2018. 7. 23.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2018. 7. 23.     bjh                최초 생성
 *  2019. 9. 30.     LCY                getCodeList 하나로 수정
 * </pre>
 */
@Controller
public class CodeUtilController{

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "CodeUtilService")
	private CodeUtilService codeUtilService;

	/**
	 * <pre>
	 * 1. 개요 :
	 * 2. 처리내용 :
	 * </pre>
	 * @Method Name : workPlaceListAjax
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/UTL/CODE/getList")
	public Map<String, Object> codeListAjax(
			HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap
			) throws Exception {
		List<Map<String, Object>> list = null;;
		try {
			list = codeUtilService.getCodelist(commandMap);
		} catch (Exception e) {
			log.info(e.toString());
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		return result;
	}
	@ResponseBody
	@RequestMapping(value = "/UTL/CODE/getCaptionAndCodeList")
	public Map<String, Object> getCaptionAndCodeList(
			HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap
			) throws Exception {
		List<Map<String, Object>> list = null;;
		try {
			list = codeUtilService.getCaptionAndCodeList(commandMap);
		} catch (Exception e) {
			log.info(e.toString());
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("list", list);
		return result;
	}
	
	
}

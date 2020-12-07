package kr.co.common.job;


import java.sql.Array;
import java.util.*;

import javax.annotation.Resource;

import kr.co.common.com.controller.DefaultController;
import kr.co.common.job.service.JobService;
import kr.co.common.com.utils.StringUtil;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;



/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 30.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 30.       lcy         최초 생성
 *  2019. 10. 30.       lcy         update,delete 수정
 * </pre>
 */
@Controller
public class JobController extends DefaultController{
	@Resource(name = "JobService")
	private JobService jobService;
	

	@ResponseBody
	@RequestMapping(value = "/JOB/{web_url1}/getList")
	public Map<String,Object> onGetList(@PathVariable String web_url1) throws Exception {
		
		List<Map<String,Object>> returnList = jobService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	@ResponseBody
	@RequestMapping(value = "/JOB/{web_url1}/get")
	public Map<String,Object> onGet(@PathVariable String web_url1) throws Exception {
		Map<String,Object> result = jobService.get(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result",result);
		
		return returnMap;
	};
	@ResponseBody
	@RequestMapping(value = "/JOB/{web_url1}/insert")
	public Map<String,Object> onInsert(@PathVariable String web_url1) throws Exception {
		int result = jobService.insert(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	@ResponseBody
	@RequestMapping(value = "/JOB/{web_url1}/update")
	public Map<String,Object> onUpdate(@PathVariable String web_url1) throws Exception {
		/*data 추출 후 commandMap 과 통합*/
		Map<String,Object> paramMap = StringUtil.getMapFromJsonStr(commandMap.get("data").toString() );
		paramMap.putAll(commandMap);
		/*data 추출 후 commandMap 과 통합*/
		

		int result = jobService.update(paramMap); 
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	@ResponseBody
	@RequestMapping(value = "/JOB/{web_url1}/delete")
	public Map<String,Object> onDelete(@PathVariable String web_url1) throws Exception {
		/*data 추출 후 commandMap 과 통합*/
		List<Map<String, Object>> data = StringUtil.getListMapFromJsonStr(commandMap.get("data").toString());
		commandMap.put("data",data);
		/*data 추출 후 commandMap 과 통합*/
		
		int result = jobService.update(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result);
		return returnMap;
	};
	

};



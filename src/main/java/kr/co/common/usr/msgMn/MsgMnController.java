package kr.co.common.usr.msgMn;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.utl.file.service.FileService;
import kr.co.common.com.controller.DefaultController;
import kr.co.common.usr.msgMn.service.MsgMnService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class MsgMnController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "MsgMnService")
	private MsgMnService MsgMnService;
	
	@Resource(name = "FileService")
	private FileService fileService;
	
	@ResponseBody
	@RequestMapping(value = "/USR/MSGMN/getList")
	public Map<String,Object>  onGetList() throws Exception {
		
		List<Map<String,Object>> returnList = MsgMnService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	@RequestMapping(value = "/USR/MSGMN/insertPop")
	public ModelAndView onInsertPop() throws Exception {
		/************** 프로그램 로직 **************/
		List<Map<String,Object>> langList = MsgMnService.getLang(commandMap);
		/************** 프로그램 로직 **************/
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/CIS/CIS1070P0";
		mav.setViewName(resultURL);
		mav.addObject("langList",langList);
		/************** ModelView 로직 **************/
		return mav;
	};
	@ResponseBody
	@RequestMapping(value = "/USR/MSGMN/insert")
	public Map<String,Object> onInsert() throws Exception {
		int result = MsgMnService.insert(request,commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	@ResponseBody
	@RequestMapping(value = "/USR/MSGMN/update")
	public Map<String,Object> onUpdate() throws Exception {
		int result = MsgMnService.update(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
}

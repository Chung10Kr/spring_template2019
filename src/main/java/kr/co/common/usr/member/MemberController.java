package kr.co.common.usr.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.co.common.usr.member.service.MemberService;
import kr.co.common.utl.codeUtil.service.CodeUtilService;
import kr.co.common.utl.file.service.FileService;
import kr.co.common.com.controller.DefaultController;
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
 * 설 명 : 회원정보 관리
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 11. 25.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11. 25.       lcy         최초 생성
 * </pre>
 */
@Controller
public class MemberController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "MemberService")
	private MemberService memberService;
	
	/**
	* <pre>
	* 1. 개요 :  회원관리 리스트 조회
	* 2. 처리내용 : 회원관리 리스트 조회
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onGetList
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/getList")
	public Map<String,Object>  onGetList() throws Exception {
		
		List<Map<String,Object>> returnList = memberService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :  회원관리 조회  
	* 2. 처리내용 : 회원관리,첨부파일 조회
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onGet
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/get")
	public Map<String,Object> onGet() throws Exception {
		
		Map<String,Object> result = memberService.get(commandMap); //회원관리 조회
		commandMap.put("id",StringUtil.noNull( result.get("attach_file_no")).split(",") );
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result",result);
		
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :  회원관리 등록  
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onInsert
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/insert")
	public Map<String,Object> onInsert() throws Exception {
		int result = memberService.insert(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	/**
	* <pre> 
	* 1. 개요 :  회원관리 변경    
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 25.
	* @Method Name : onUpdate
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/update")
	public Map<String,Object> onUpdate() throws Exception {
		int result = memberService.update(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :  회원관리 삭제
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 25.
	* @Method Name : onDelete
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/delete")
	public Map<String,Object> onDelete() throws Exception {
		int result = memberService.delete(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	
	
	/**
	* <pre>
	* 1. 개요 :   PWD 변경 팝업
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 29.
	* @Method Name : onUpdatePwd
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/USR/MEMBER/pwdChg")
	public ModelAndView  onUpdatePwd() throws Exception {
		/************** 프로그램 로직 **************/
		Map<String,Object> result = memberService.get(commandMap); //회원관리 조회
		/************** 프로그램 로직 **************/
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/COMM/pwdChg";
		mav.setViewName(resultURL);
		mav.addObject("result",result);
		/************** ModelView 로직 **************/
		return mav;
	};
	/**
	* <pre>
	* 1. 개요 :   패스워드 회원정보 변경
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 29.
	* @Method Name : onPwdChg
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/MEMBER/updatePwd")
	public Map<String,Object> onPwdChg() throws Exception {
		int result = memberService.updatePwd(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
};

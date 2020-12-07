package kr.co.common.usr.notice;

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
import kr.co.common.usr.notice.service.NoticeService;
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
 * 설 명 : 공지사항 처리
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 11. 22.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11. 22.       lcy         최초 생성
 *  2019. 12. 20.       lcy         Layer pop(include->ajaxCallHtml) 후 처리
 * </pre>
 */
@Controller
public class NoticeController extends DefaultController {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "NoticeService")
	private NoticeService noticeService;
	
	@Resource(name = "FileService")
	private FileService fileService;
	/**
	* <pre>
	* 1. 개요 :  공지사항 리스트 조회
	* 2. 처리내용 : 공지사항 리스트 조회
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onGetList
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/NOTICE/getList")
	public Map<String,Object>  onGetList() throws Exception {
		
		List<Map<String,Object>> returnList = noticeService.getList(commandMap);
		
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", returnList );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :  공지사항 삭제
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 25.
	* @Method Name : onDelete
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/NOTICE/delete")
	public Map<String,Object> onDelete() throws Exception {
		List<Map<String, Object>> data = StringUtil.getListMapFromJsonStr(commandMap.get("data").toString());
		commandMap.put("data",data);
		int result = noticeService.delete(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result);
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :   등록 팝업 오픈 
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 12. 19.
	* @Method Name : onInsertPop
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/USR/NOTICE/insertPop")
	public ModelAndView onInsertPop() throws Exception {
		/************** 프로그램 로직 **************/
		
		/************** 프로그램 로직 **************/
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/CIS/CIS1140P0";
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	}
	/**
	* <pre>
	* 1. 개요 :  공지사항 등록  
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onInsert
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/NOTICE/insert")
	public Map<String,Object> onInsert() throws Exception {
		int result = noticeService.insert(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	/**
	* <pre>
	* 1. 개요 :  공지사항 팝업조회  
	* 2. 처리내용 : 공지사항,첨부파일 조회
	* </pre>
	* @Date : 2019. 11. 22.
	* @Method Name : onGet
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/USR/NOTICE/viewPop")
	public ModelAndView onViewPop() throws Exception {
		/************** 프로그램 로직 **************/
		Map<String,Object> result = noticeService.get(commandMap); //공지사항 조회
		commandMap.put("id",StringUtil.noNull( result.get("attach_file_no")).split(",") );
		List<Map<String,Object>> fileResult = (List<Map<String,Object>>)fileService.getFileList(commandMap); //파일
		
		/************** 프로그램 로직 **************/
		
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/CIS/CIS1140P1";
		mav.setViewName(resultURL);
		mav.addObject("result",result);
		mav.addObject("fileResult",fileResult);
		/************** ModelView 로직 **************/
		return mav;
	}
	/**
	* <pre>
	* 1. 개요 :   공지사항 업데이트 팝업 조회
	* 2. 처리내용 :
	* </pre>
	* @Date : 2019. 12. 20.
	* @Method Name : onUpdPop
	* @return
	* @throws Exception
	*/
	@RequestMapping(value = "/USR/NOTICE/updatePop")
	public ModelAndView onUpdPop() throws Exception {
		/************** 프로그램 로직 **************/
		Map<String,Object> result = noticeService.get(commandMap); //공지사항 조회
		commandMap.put("id",StringUtil.noNull( result.get("attach_file_no")).split(",") );
		List<Map<String,Object>> fileResult = (List<Map<String,Object>>)fileService.getFileList(commandMap); //파일
		
		/************** 프로그램 로직 **************/
		
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/CIS/CIS1140P2";
		mav.setViewName(resultURL);
		mav.addObject("result",result);
		mav.addObject("fileResult",fileResult);
		/************** ModelView 로직 **************/
		return mav;
	}
	/**
	* <pre> 
	* 1. 개요 :  공지사항 변경    
	* 2. 처리내용 : 공지사항 변경 
	* </pre>
	* @Date : 2019. 11. 25.
	* @Method Name : onUpdate
	* @return
	* @throws Exception
	*/
	@ResponseBody
	@RequestMapping(value = "/USR/NOTICE/update")
	public Map<String,Object> onUpdate() throws Exception {
		int result = noticeService.update(commandMap);
		Map<String,Object> returnMap = new HashMap<String, Object>();
		returnMap.put("result", result );
		return returnMap;
	};
	
}

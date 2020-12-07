package kr.co.common.vwr;

import kr.co.common.com.controller.DefaultController;
import kr.co.common.com.utils.StringUtil;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 7.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 7.       lcy         최초 생성
 *  2019. 10. 30.      lcy         경로 및 이름 수정
 * </pre>
 */
@Controller
public class VwrController extends DefaultController{
	
	@RequestMapping(value = "/NVWR/{web_url1}/{web_url2}")
	public ModelAndView onPageNVWR2( @PathVariable String web_url1,@PathVariable String web_url2) throws Exception {
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		
		String resultURL = "/NVWR/"+web_url1+"/"+web_url2;
		mav.addObject("MENU_URL" , web_url2);
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	};
	@RequestMapping(value = "/VWR/{web_url1}/{web_url2}")
	public ModelAndView onPageVWR2( @PathVariable String web_url1,@PathVariable String web_url2) throws Exception {
		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/VWR/"+web_url1+"/"+web_url2;
		
		mav.addObject("MENU_URL" , web_url2);
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	};
};



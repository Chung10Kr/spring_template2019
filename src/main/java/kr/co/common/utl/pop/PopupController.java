package kr.co.common.utl.pop;




import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class PopupController{

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@RequestMapping(value = "/POP/{web_url1}/{web_url2}")
	public ModelAndView setPop( @PathVariable String web_url1,@PathVariable String web_url2) throws Exception {
		/************** 프로그램 로직 **************/
		
		/************** 프로그램 로직 **************/

		/************** ModelView 로직 **************/
		// return Model 정보 생성
		ModelAndView mav = new ModelAndView();
		String resultURL = "/NVWR/"+web_url1+"/"+web_url2+"";
		mav.setViewName(resultURL);
		/************** ModelView 로직 **************/
		return mav;
	}
	
}

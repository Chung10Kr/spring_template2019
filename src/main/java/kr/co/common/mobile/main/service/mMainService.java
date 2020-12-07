package kr.co.common.mobile.main.service;

import java.util.List;
import java.util.Map;


/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 11. 5.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11. 5.       lcy         최초 생성
 * </pre>
 */
public interface mMainService {
	
	public Map<String, Object> getMember(Map<String, Object> param) throws Exception;
}

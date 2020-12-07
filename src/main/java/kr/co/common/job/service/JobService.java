package kr.co.common.job.service;

import java.util.List;
import java.util.Map;

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
 * </pre>
 */
public interface JobService {
	
	public List<Map<String,Object>> getList(Map<String, Object> input) throws Exception;
	public Map<String,Object> get(Map<String, Object> input) throws Exception;
	public Integer insert(Map<String, Object> input) throws Exception;
	public Integer update(Map<String, Object> input) throws Exception;
	public Integer delete(Map<String, Object> input) throws Exception;
	
}

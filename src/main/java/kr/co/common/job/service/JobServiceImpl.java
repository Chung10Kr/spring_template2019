package kr.co.common.job.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;



import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;










import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

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
@Service("JobService")
public class JobServiceImpl extends EgovAbstractServiceImpl implements JobService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	@Override
	public List<Map<String,Object>> getList(Map<String, Object> input) throws Exception {
		List<Map<String, Object>> resultList = commonMapper.getList(input);
		return resultList;
	}

	@Override
	public Map<String,Object> get(Map<String, Object> input) throws Exception {
		Map<String, Object> result = commonMapper.get(input);
		return result;
	}

	@Override
	public Integer insert(Map<String, Object> input) throws Exception {
		int result = (Integer) commonMapper.insert(input);
		return result;
	}

	@Override
	public Integer update(Map<String, Object> input) throws Exception {
		int result = (Integer) commonMapper.update(input);
		return result;
	}

	@Override
	public Integer delete(Map<String, Object> input) throws Exception {
		int result = (Integer) commonMapper.delete(input);
		return result;
	}


}

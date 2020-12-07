package kr.co.common.utl.codeUtil.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;







import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("CodeUtilService")
public class CodeUtilServiceImpl extends EgovAbstractServiceImpl implements CodeUtilService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "codeUtilMapper.";
	
	/**
	 * <pre>
	 * 내용 : 코드 불러오기
	 * </pre>
	 * @Method Name : getCodeList
	 * @param param : CODE_UPPER_NO
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getCodelist(Map<String, Object> param){
		param.put("mapper_id", namespace + "getCodeList");
		List<Map<String, Object>> resultList = commonMapper.getList(param);
		return resultList;
	}
	/**
	 * <pre>
	 * 내용 : 다국어 및 코드 불러오기
	 * </pre>
	 * @Method Name : getCodeList
	 * @param param : CODE_UPPER_NO
	 * @return
	 */
	@Override
	public List<Map<String, Object>> getCaptionAndCodeList(Map<String, Object> param){
		param.put("mapper_id", namespace + "getCaptionAndCodeList");
		List<Map<String, Object>> resultList = commonMapper.getList(param);
		return resultList;
	}
}

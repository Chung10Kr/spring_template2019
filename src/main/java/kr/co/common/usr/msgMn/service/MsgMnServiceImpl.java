package kr.co.common.usr.msgMn.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.common.com.mapper.CommonMapper;
import kr.co.common.com.utils.StringUtil;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("MsgMnService")
public class MsgMnServiceImpl extends EgovAbstractServiceImpl implements MsgMnService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "msgMnMapper.";


	
	@Override
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	};
	@Override
	public List<Map<String, Object>> getLang(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getLang");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	};
	
	@Override
	public Integer insert(HttpServletRequest request,Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "insert");
		
		String[] array_MinorCd = request.getParameterValues("minor_cds");
		String[] array_LangDesc = request.getParameterValues("lang_descs");
		int result = 0;
		for(int i=0 ; i < array_MinorCd.length ; i++){
			param.put("lang", array_MinorCd[i]);
			param.put("lang_desc", array_LangDesc[i]);
			result = (Integer) commonMapper.insert(param);
		};
		return result;
	};
	@Override
	public Integer update(Map<String, Object> param) throws Exception {
		/*data 추출 후 commandMap 과 통합*/
		Map<String,Object> paramMap = StringUtil.getMapFromJsonStr(param.get("data").toString() );
		paramMap.putAll(param);
		/*data 추출 후 commandMap 과 통합*/
		paramMap.put("mapper_id", namespace + "update");
		int result = (Integer) commonMapper.update(paramMap);
		return result;
	};
	
	
}

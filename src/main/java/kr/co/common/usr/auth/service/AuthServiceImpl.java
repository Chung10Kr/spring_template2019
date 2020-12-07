package kr.co.common.usr.auth.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;
import kr.co.common.com.utils.StringUtil;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("AuthService")
public class AuthServiceImpl extends EgovAbstractServiceImpl implements AuthService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "authMapper.";


	
	@Override
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	};
	@Override
	public List<Map<String, Object>> getAuthList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getAuthList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	};
	@Override
	public Integer deleteAuth(Map<String,Object> param) throws Exception{
		param.put("mapper_id", namespace + "deleteAuth");
		int result = commonMapper.deleteOne(param);
		return result;
	}
	@Override
	public Integer updateAuth(Map<String,Object> param) throws Exception{
		
		
		/*data 추출 후 commandMap 과 통합*/
		Map<String,Object> paramMap = StringUtil.getMapFromJsonStr(param.get("data").toString() );
		paramMap.putAll(param);
		/*data 추출 후 commandMap 과 통합*/

		
		/*기존의 데이터 삭제*/
		deleteAuth(paramMap);
		
		paramMap.put("mapper_id", namespace + "insertAuth");
		String[] authList = { "perm_re","perm_sa","perm_use","perm_de","perm_ad" };
		int result = 0;
		for(int i=0; i< authList.length; i++){
			if( !StringUtil.noNull(paramMap.get(authList[i])).equals("0") ){
				paramMap.put("authCode", paramMap.get(authList[i]));
				commonMapper.update(paramMap);
			};
		};
		
		return result;
	}
	
	
}

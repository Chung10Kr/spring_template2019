package kr.co.common.usr.auth.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;
import kr.co.common.com.utils.StringUtil;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("RoleAuthService")
public class RoleAuthServiceImpl extends EgovAbstractServiceImpl implements RoleAuthService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "roleAuthMapper.";


	
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
		
		
		int result = 0;
		/*data 추출 후 commandMap 과 통합*/
		Map<String,Object> paramMap = StringUtil.getMapFromJsonStr(param.get("data").toString() );
		paramMap.putAll(param);
		/*data 추출 후 commandMap 과 통합*/

		
		/*기존의 데이터 삭제*/
		String roleAuth=StringUtil.noNull(paramMap.get("role_auth"));
		if(roleAuth.equals("Y")){
			//권한부여
			paramMap.put("mapper_id", namespace + "insertAuth");
			commonMapper.insert(paramMap);
			
		}else{
			//권한삭제
			deleteAuth(paramMap);
		}
		
		

		
		return result;
	}
	
	
}

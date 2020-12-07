package kr.co.common.usr.auth.service;

import java.util.List;
import java.util.Map;

public interface AuthService {
	

	
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> getAuthList(Map<String, Object> param) throws Exception;
	public Integer deleteAuth(Map<String,Object> param) throws Exception;
	public Integer updateAuth(Map<String,Object> param) throws Exception;
	
}

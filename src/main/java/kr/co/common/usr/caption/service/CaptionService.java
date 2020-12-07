package kr.co.common.usr.caption.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface CaptionService {
	


	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception;
	public List<Map<String, Object>> getLang(Map<String, Object> param) throws Exception ;
	public Integer insert(HttpServletRequest request,Map<String, Object> input) throws Exception;
	public Integer update(Map<String, Object> input) throws Exception;
		
}

package kr.co.common.usr.menu.service;

import java.util.List;
import java.util.Map;

public interface MenuService {
	

	/**
	 * top 메뉴 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getTopMenuList(Map<String, Object> param) throws Exception;
	
	/**
	 * left 메뉴 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getLeftMenuList(Map<String, Object> param) throws Exception;
	
	
}

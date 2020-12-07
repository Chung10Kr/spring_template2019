package kr.co.common.usr.menu.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("MenuService")
public class MenuServiceImpl extends EgovAbstractServiceImpl implements MenuService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "menuMapper.";


	/**
	 * top 메뉴 조회
	 */
	@Override
	public List<Map<String, Object>> getTopMenuList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getTopMenuList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	}
	/**
	 * left 메뉴 조회
	 */
	@Override
	public List<Map<String, Object>> getLeftMenuList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getLeftMenuList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	}
	


}

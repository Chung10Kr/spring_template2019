package kr.co.common.usr.notice.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("NoticeService")
public class NoticeServiceImpl extends EgovAbstractServiceImpl implements NoticeService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "noticeMapper.";


	/**
	 * 공지사항 리스트 조회
	 */
	@Override
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getList");
		List<Map<String, Object>> result = commonMapper.getList(param);
		return result;
	};
	/**
	 * 공지사항 조회
	 */
	@Override
	public Map<String, Object> get(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "get");
		Map<String, Object> result = commonMapper.get(param);
		return result;
	};
	/**
	 * 공지사항 등록
	 */
	@Override
	public Integer insert(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "insert");
		int result = (Integer) commonMapper.insert(param);
		return result;
	};
	/**
	 * 공지사항 변경
	 */
	@Override
	public Integer update(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "update");
		int result = (Integer) commonMapper.update(param);
		return result;
	};
	/**
	 * 공지사항 삭제
	 */
	@Override
	public Integer delete(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "delete");
		int result = (Integer) commonMapper.update(param);
		return result;
	};
	
}

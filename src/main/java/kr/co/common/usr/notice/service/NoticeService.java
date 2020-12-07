package kr.co.common.usr.notice.service;

import java.util.List;
import java.util.Map;

public interface NoticeService {
	

	/**
	 * 공지사항 리스트 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception;
	/**
	 * 공지사항 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> get(Map<String, Object> param) throws Exception;
	/**
	 * 공지사항 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insert(Map<String, Object> input) throws Exception;
	/**
	 * 공지사항 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer update(Map<String, Object> input) throws Exception;
	/**
	 * 공지사항 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer delete(Map<String, Object> param) throws Exception ;	
}

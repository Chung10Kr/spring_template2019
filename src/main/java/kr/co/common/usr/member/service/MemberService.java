package kr.co.common.usr.member.service;

import java.util.List;
import java.util.Map;

public interface MemberService {
	

	/**
	 * 회원관리 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public List<Map<String, Object>> getList(Map<String, Object> param) throws Exception;
	/**
	 * 회원관리 조회
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> get(Map<String, Object> param) throws Exception;
	/**
	 * 회원관리 등록
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer insert(Map<String, Object> input) throws Exception;
	/**
	 * 회원관리 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer update(Map<String, Object> input) throws Exception;
	/**
	 * 회원관리 삭제
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer delete(Map<String, Object> param) throws Exception ;	
	/**
	 * 비밀번호, 테마 변경
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public Integer updatePwd(Map<String, Object> input) throws Exception;
}

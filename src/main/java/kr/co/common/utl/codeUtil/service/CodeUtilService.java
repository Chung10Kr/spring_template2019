package kr.co.common.utl.codeUtil.service;

import java.util.List;
import java.util.Map;

public interface CodeUtilService {
	
	
	/**
	 * <pre>
	 * 1. 개요 : 년도 콤보박스용 리스트를 출력
	 * 2. 처리내용 : 년도 콤보박스용 리스트를 출력
	 * </pre>
	 * @Method Name : getComboYear
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> getCodelist(Map<String, Object> param);
	/**
	 * <pre>
	 * 1. 개요 : View내 다국어 및 콤보 바인딩 리스트를 출력
	 * 2. 처리내용 : View내 다국어 및 콤보 바인딩 리스트를 출력
	 * </pre>
	 * @Method Name : getCaptionAndCodeList
	 * @param param
	 * @return
	 */
	public List<Map<String, Object>> getCaptionAndCodeList(Map<String, Object> param);
}

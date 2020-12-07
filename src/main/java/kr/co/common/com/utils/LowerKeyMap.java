package kr.co.common.com.utils;

import org.apache.commons.collections.map.ListOrderedMap;
import org.apache.commons.lang.StringUtils;
 
/**
 * 설 명 :   Postgresql return Key값 소문자->대문자로 변경
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 11.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 11.       lcy         최초 생성
 * </pre>
 */
public class LowerKeyMap extends ListOrderedMap {
    /** serialVersionUID */
    private static final long serialVersionUID = -7700790403928325865L;
 
    /**
     * key 에 대하여 소문자로 변환하여 super.put
     * (ListOrderedMap) 을 호출한다.
     * @param key
     *        - '_' 가 포함된 변수명
     * @param value
     *        - 명시된 key 에 대한 값 (변경 없음)
     * @return previous value associated with specified
     *         key, or null if there was no mapping for
     *         key
     */
    public Object put(Object key, Object value) {
        return super.put(StringUtils.lowerCase((String) key), value);
    }
}


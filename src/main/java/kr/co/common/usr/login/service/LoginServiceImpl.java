package kr.co.common.usr.login.service;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;





import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 설 명 :
 * @author 개발팀  Lee_chung_ryeol
 * @since 2019. 10. 7.
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 10. 7.       lcy         최초 생성
 * </pre>
 */
@Service("LoginService")
public class LoginServiceImpl extends EgovAbstractServiceImpl implements LoginService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "loginMapper.";
	
	@Override
	public Map<String, Object> getMember(Map<String, Object> param) throws Exception{
		param.put("mapper_id", namespace + "getMember");
		Map<String, Object> result = commonMapper.get(param);
		return result;
	}
}

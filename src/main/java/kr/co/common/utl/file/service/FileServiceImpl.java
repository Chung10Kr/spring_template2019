package kr.co.common.utl.file.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import kr.co.common.com.controller.CommonController;
import kr.co.common.com.mapper.CommonMapper;

import org.springframework.stereotype.Service;










import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("FileService")
public class FileServiceImpl extends EgovAbstractServiceImpl implements FileService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;

	private String namespace = "fileMapper.";
	
	/* 
	 * 파일 SEQ 조회
	 */
	@Override
	public Map<String,Object> fileSeq() throws Exception {
		Map<String, Object> param =  new HashMap<String, Object>();
		param.put("mapper_id", namespace + "fileSeq");
		Map<String,Object> result = (Map<String,Object>) commonMapper.get(param);
		return result;
	}
	/* 
	 * 파일 등록
	 */
	@Override
	public Integer insert(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "fileInsert");
		int result = (Integer) commonMapper.insert(param);
		return result;
	}
	@Override
	public Map<String,Object> getFile(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getFile");
		Map<String,Object> result = (Map<String,Object>) commonMapper.get(param);
		return result;
	}
	/* 
	 * 파일 리스트 조회
	 */
	@Override
	public List<Map<String,Object>> getFileList(Map<String, Object> param) throws Exception {
		param.put("mapper_id", namespace + "getFileList");
		List<Map<String,Object>> result = (List<Map<String,Object>>) commonMapper.getList(param);
		return result;
	}
}

package kr.co.common.utl.file.service;

import java.util.List;
import java.util.Map;

public interface FileService {
	
	public Map<String,Object> fileSeq() throws Exception ;
	public Integer insert(Map<String, Object> param) throws Exception;
	public Map<String,Object> getFile(Map<String, Object> param) throws Exception;
	public List<Map<String,Object>> getFileList(Map<String, Object> param) throws Exception ;
}

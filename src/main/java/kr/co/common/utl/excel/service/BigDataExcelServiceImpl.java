package kr.co.common.utl.excel.service;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.com.mapper.CommonMapper;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

@Service("bigDataExcelService")
public class BigDataExcelServiceImpl extends EgovAbstractServiceImpl implements BigDataExcelService {

	@Resource(name = "CommonMapper")
	private CommonMapper commonMapper;


	/**
	 * 대용량 엑셀 다운로드 공통
	 */
	@Override
	public SXSSFWorkbook getBigDataExcelDown(HttpServletRequest request, Map<String, Object> param) throws Exception {
		
		SXSSFWorkbook resultList = commonMapper.getBigDataExcelProc(request, param);
		return resultList;
	}
	
	/**
	 * 통합 조회 엑셀 다운로드 공통
	 */
	@Override
	public SXSSFWorkbook getTotSearchDataExcelDown(HttpServletRequest request, Map<String, Object> param) throws Exception {

		SXSSFWorkbook resultList = commonMapper.getBigDataExcelProc(request, param);
		return resultList;
	}

	

	/**
	 * 대용량 엑셀 다운로드 공통(Multy Sheet)
	 */
	@Override
	public SXSSFWorkbook getBigDataExcelDown(String templateUrl, Map<String, Object> ... paramMap) throws Exception {
		for (int i = 0; i < paramMap.length; i++) {
			if(StringUtil.noNull(paramMap[i].get("qNs")).equals("")){
				paramMap[i].put("mId", StringUtil.noNull(paramMap[i].get("qId")));	
			}
		}
		SXSSFWorkbook resultList = commonMapper.getBigDataExcelProc(templateUrl, paramMap);
		return resultList;
	}
}

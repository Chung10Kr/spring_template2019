package kr.co.common.utl.excel.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;

public interface BigDataExcelService {
	
	/**
	 * 대용량 엑셀 다운로드 공통
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public SXSSFWorkbook getBigDataExcelDown(HttpServletRequest request, Map<String,Object> param) throws Exception;
	
	/**
	 * 통합 조회 엑셀 다운로드 공통
	 * @param request
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public SXSSFWorkbook getTotSearchDataExcelDown(HttpServletRequest request, Map<String, Object> param) throws Exception;
	
	/**
	 * 대용량 엑셀 다운로드 공통(Multy Sheet)
	 * @param templateUrl
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	public SXSSFWorkbook getBigDataExcelDown(String templateUrl, Map<String, Object> ... paramMap) throws Exception;
}

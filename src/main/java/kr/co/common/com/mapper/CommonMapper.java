package kr.co.common.com.mapper;


import java.io.File;
import java.io.FileInputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.utl.excel.mapper.BigDataExcelResultHandler;
import kr.co.common.utl.excel.view.BigDataExcelUtil;
import kr.co.common.utl.excel.view.ExcelConstants;

import org.apache.poi.xssf.streaming.*;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 공용 Mapper 클래스
 * 
 * @author bang
 *
 */
@Repository("CommonMapper")
public class CommonMapper extends EgovAbstractMapper {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	
/**
	 * 리스트 조회
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public List<Map<String, Object>> getList(Map<String, Object> param) {
		return selectList(mapperId(param), getInData(param) );
	}

	/**
	 * 카운트
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 * 
	 */
	public int getCount(Map<String, Object> param) {
		return selectOne(mapperId(param), getInData(param));
	}

	/**
	 * 상세 조회
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public Map<String, Object> get(Map<String, Object> param) throws Exception {
		return selectOne(mapperId(param), getInData(param));
	}

	/**
	 * 상세 조회
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public Object getObject(Map<String, Object> param) throws Exception {
		return selectOne(mapperId(param), getInData(param));
	}

	/**
	 * 등록
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public Object insert(Map<String, Object> param) throws Exception {
		return insert(mapperId(param), getInData(param) );
	}

	/**
	 * 수정
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public int update(Map<String, Object> param) throws Exception {
		return update(mapperId(param), getInData(param));
	}

	/**
	 * 삭제
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public int delete(Map<String, Object> param) throws Exception {
		return delete(mapperId(param), getInDataArray(param) );
	}
	/**
	 * 그리드 외 단행 삭제
	 * 
	 * @param Map
	 * @exception Exception
	 *                Exception
	 */
	public int deleteOne(Map<String, Object> param) throws Exception {
		return delete(mapperId(param), getInData(param) );
	}
	/**
	 * mapperId 등록
	 * 
	 * @param param
	 * @return
	 */
	public String mapperId(Map<String, Object> param) {
		String mId = StringUtil.noNull(param.get("mapper_id"));
		return mId;
	}
	/**
	 * Indate 등록
	 * 
	 * @param param
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> getInData(Map<String, Object> param) {
		Map<String, Object> data = (Map<String, Object>) param.get("in_data");
		if(data == null){
			data = param;
		};
		return data;
	};
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getInDataArray(Map<String, Object> param) {
		List<Map<String, Object>> data = (List<Map<String, Object>>) param.get("in_data");
		return data;
	};
	
	public SXSSFWorkbook getBigDataExcelProc(String templateUrl, Map<String, Object> ... paramMap) throws Exception {
		int rownum = 0;
		int celnum = 0;
		XSSFWorkbook xb = new XSSFWorkbook(new FileInputStream(new File(templateUrl)));// 엑셀 2007이상인경우 읽기,쓰기 가능
		Map<String, XSSFCellStyle> styles = BigDataExcelUtil.createStyles(xb);// 스타일들 저장
		SXSSFWorkbook wb = new SXSSFWorkbook(xb);// 대용량 엑셀파일용 쓰기만 가능
		SXSSFSheet sheet = null;
		BigDataExcelResultHandler resultHandler = null;
		for (int i = 0; i < paramMap.length; i++) {
			rownum = StringUtil.toInt(paramMap[i].get(ExcelConstants.ROWNUM), 0);
			celnum = StringUtil.toInt(paramMap[i].get(ExcelConstants.CELNUM), 0);
			sheet = (SXSSFSheet) wb.getSheetAt(i);
			
			resultHandler = new BigDataExcelResultHandler(sheet, styles, rownum, celnum);
			getSqlSession().select(mapperId(paramMap[i]), paramMap[i], resultHandler);
		}
		return wb;
	}
	/**
	 * 대용량 엑셀 변환 - out of memory 발생 방지
	 * 
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public SXSSFWorkbook getBigDataExcelProc(HttpServletRequest request, Map<String, Object> param) throws Exception {
		
				
		String templateURL = StringUtil.noNull(param.get(ExcelConstants.TEMPLATE_URL));
		int rownum = StringUtil.toInt(param.get(ExcelConstants.ROWNUM), 0);
		int celnum = StringUtil.toInt(param.get(ExcelConstants.CELNUM), 0);

		XSSFWorkbook xb = new XSSFWorkbook(new FileInputStream(new File(templateURL)));// 엑셀 2007이상인경우 읽기,쓰기 가능
		Map<String, XSSFCellStyle> styles = BigDataExcelUtil.createStyles(xb);// 스타일들 저장

		SXSSFWorkbook wb = new SXSSFWorkbook(xb);// 대용량 엑셀파일용 쓰기만 가능
		SXSSFSheet sheet = (SXSSFSheet) wb.getSheetAt(0);
		BigDataExcelResultHandler resultHandler = new BigDataExcelResultHandler(sheet, styles, rownum, celnum);
		getSqlSession().select(mapperId(param), param, resultHandler);

		return wb;

	}
};

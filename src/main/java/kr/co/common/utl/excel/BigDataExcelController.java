package kr.co.common.utl.excel;

import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.common.com.controller.DefaultController;
import kr.co.common.com.utils.EgovDateUtil;
import kr.co.common.com.utils.EgovWebUtil;
import kr.co.common.com.utils.StringUtil;
import kr.co.common.utl.excel.service.BigDataExcelService;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import org.springframework.web.util.WebUtils;

import kr.co.common.utl.excel.view.ExcelConstants;
import kr.co.common.utl.excel.view.BigDataExcelView;
import kr.co.common.utl.excel.view.BigDataExcelUtil;

/**
 * 설 명 : 대용량 엑셀 관련 컨트롤러
 * @author 개발팀 Bang-ji-hwan
 * @since 2013. 8. 31
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자              수정내용
 *  -------       --------    ---------------------------
 *  2019. 11.04     lcy                최초생성
 * </pre>
 */
@Controller
public class BigDataExcelController extends DefaultController {

	@Resource(name = "bigDataExcelService")
	private BigDataExcelService bigDataExcel;


	/**
	 * 기본 템플릿 폴더 : /excel/bigData
	 * 기본 쿼리 모음 파일 : bigDataExcel_mapper.xml
	 * 
	 * 파라미터 필수
	 * tFileNm : 엑셀 템플릿 파일명(ex: member)
	 * dFielNm : 다운로드 파일명(ex: 회원목록)
	 * qId     : 쿼리 ID /mapper/cms/bigDataExcel/bigDataExcel_mapper.xml파일에 작성한 쿼리 ID 값
	 * qNs 	   : 다른 쿼리  xml 파일 사용시 namesapce 값
	 * sR : 시작 로우(0부터 시작)
	 * sC : 시작 셀(0부터 시작)
	 * 
	 * 대용량 엑셀 다운로드 공통
	 * ex) 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/UTL/EXCEL/download")
	public ModelAndView getBigDataExcelDown(HttpServletRequest request, HttpServletResponse response, @RequestParam Map<String, Object> commandMap) throws Exception {
		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		//필수 파라미터 세팅
		String tFileNm  = StringUtil.noNull(commandMap.get("tFileNm"));
		String dFielNm  = StringUtil.noNull(commandMap.get("dFielNm"));
		int sR  = StringUtil.toInt(commandMap.get("sR"));
		int sC  = StringUtil.toInt(commandMap.get("sC"));
		if(tFileNm.equals("") || dFielNm.equals("")){
			return getErrorModel(ERROR_ALERT_AND_BACK, "파라미터가 부족합니다.");
		}
		
		String templateURL = WebUtils.getRealPath(request.getSession().getServletContext(), "/resources/excel/template/" + tFileNm +".xlsx");
		
		commandMap.put(ExcelConstants.TEMPLATE_URL, templateURL);
		commandMap.put(ExcelConstants.ROWNUM, sR);
		commandMap.put(ExcelConstants.CELNUM, sC);
		
		SXSSFWorkbook swb = bigDataExcel.getBigDataExcelDown(request, commandMap);
		ModelAndView modelAndView = new ModelAndView(BigDataExcelView.NAME);
		
		modelAndView.addObject(ExcelConstants.DOWN_FILE_NM, dFielNm +"_"+ EgovDateUtil.getCurrentDate("yyyyMMdd") + ".xlsx");
		modelAndView.addObject(ExcelConstants.SWB, swb);

		return modelAndView;
	}
	
	
	/**
	 * 화면에 대용량 엑셀 다운로드 공통(/cms/bigDataExcelDown)으로 표출된
	 * 데이터를 재다운로드 받을경우 사용
	 * 
	 * [파라미터 필수]
	 * celName : 엑셀 셀명(cel_1, cel_2, cel_3, ...)을 파라미터로 전달 ( 구분자는 쉼표   , )
	 * tFilePath : 엑셀 템플릿 파일 경로
	 *      예) /excel/bigData/abcd (Secure code?)
	 * dFielNm : 다운로드 파일명(ex: 회원목록)
	 * sR : 시작 로우(0부터 시작)
	 * sC : 시작 셀(0부터 시작)
	 * 셀명에 해당하는 INPUT 데이타를 전달 : Array
	 * 
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cms/htmlDataExcelDown")
	public ModelAndView getHtmlDataExcelDown2(HttpServletRequest request) throws Exception {
		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		//필수 파라미터 세팅
		String tFilePath  = StringUtil.noNull(commandMap.get("tFilePath"));//Secure Code
		String dFielNm  = StringUtil.noNull(commandMap.get("dFielNm"));
		String celName =  StringUtil.noNull(commandMap.get("celName")); 
		
		if(tFilePath.equals("") || dFielNm.equals("") || celName.equals("")){
			return getErrorModel(ERROR_ALERT_AND_BACK, "파라미터가 부족합니다.");
		}
		String[] arrCelName = celName.split(",");
		int sR  = 0;
		int sC  = 0;//시작셀
		int tC  = arrCelName.length;//셀총수
		SXSSFWorkbook wb = null;
		FileInputStream fs = null;
		try {
			sR  = StringUtil.toInt(commandMap.get("sR"));
			sC  = StringUtil.toInt(commandMap.get("sC"));//시작셀
			String templateURL = WebUtils.getRealPath(request.getSession().getServletContext(), tFilePath +".xlsx");
			fs = new FileInputStream(new File(templateURL));
			XSSFWorkbook xb = new XSSFWorkbook(fs);// 엑셀 2007이상인경우 읽기,쓰기 가능
			Map<String, XSSFCellStyle> styles = BigDataExcelUtil.createStyles(xb);// 스타일들 저장
			
			wb = new SXSSFWorkbook(xb);// 대용량 엑셀파일용 쓰기만 가능
			SXSSFSheet sheet = (SXSSFSheet) wb.getSheetAt(0);
			int nTrCnt = request.getParameterValues(arrCelName[0]).length;
			
			Row row = null;
			for( int trStart = 0;  trStart < nTrCnt; trStart++) {
				int nCellStart = sC;
				row = sheet.createRow(sR++);
				for( int tdStart = 0; tdStart < tC; tdStart++) {
					Cell cel = row.createCell(nCellStart++);
					cel.setCellStyle(styles.get("defaultSytle"));
					BigDataExcelUtil.setCellValue(cel, request.getParameterValues(arrCelName[tdStart])[trStart], "String");
				}
			}
		} catch(NullPointerException ne) {
			return getErrorModel(ERROR_ALERT_AND_BACK, "파라미터가 부족합니다.");
		} catch(Exception e) {
			return getErrorModel(ERROR_ALERT_AND_BACK, "파라미터가 부족합니다.");
		}finally {
			if(fs != null) fs.close();
		}
		
		ModelAndView modelAndView = new ModelAndView(BigDataExcelView.NAME);
		modelAndView.addObject(ExcelConstants.DOWN_FILE_NM, dFielNm +"_"+ EgovDateUtil.getCurrentDate("yyyyMMdd") + ".xlsx");
		modelAndView.addObject(ExcelConstants.SWB, wb);
		return modelAndView;
	}
}

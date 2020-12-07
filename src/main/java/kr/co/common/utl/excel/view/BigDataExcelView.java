package kr.co.common.utl.excel.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.com.utils.EgovWebUtil;

import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.view.AbstractView;



public class BigDataExcelView extends AbstractView {
	
	/** View 명 */
	public static final String NAME = "bigDataExcelView";

	/** 컨텐트 타입을 엑셀형식으로 설정한다. */
	public BigDataExcelView() {
		this.setContentType("application/x-msexcel");
	}
	
	/**
	 *
	 * 대용량 엑셀 파일 다운로드
	 * @author Bang
	 * b8545@naver.com
	 * 
	 * 엑셀파일로 렌더링한다.
	 * 기본 엑셀양식을 사용
	 * 헤더 부분은 기본양식엑셀파일에 저장하여 사용한다. 
	 * templateURL  : 텟플릿 파일 위치  (필수)
	 * downFileNm   : 다운로드 파일명 (필수)
	 * list         : 목록 배열 (필수)
	 * rownum       : 엑셀 데이터 첫로우 위치 (필수)
	 */
	@Override
	protected void renderMergedOutputModel(@SuppressWarnings("unchecked") Map model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		response.setContentType(this.getContentType());
		// 다운로드파일명
		String downFileNm = StringUtil.noNull(model.get(ExcelConstants.DOWN_FILE_NM));

		SXSSFWorkbook sw = (SXSSFWorkbook) model.get(ExcelConstants.SWB);

		response.setHeader("Content-Transfer-Encoding", "binary");
		EgovWebUtil.setDisposition(downFileNm, request, response);
		sw.write(response.getOutputStream());
	}
  
}

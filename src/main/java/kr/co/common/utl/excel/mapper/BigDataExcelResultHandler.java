package kr.co.common.utl.excel.mapper;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import kr.co.common.com.utils.StringUtil;
import kr.co.common.utl.excel.view.BigDataExcelUtil;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;


public class BigDataExcelResultHandler implements ResultHandler {

	private SXSSFSheet sheet;
	private Map<String, XSSFCellStyle> styles;
	private int rownum;
	private int celnum;

	public BigDataExcelResultHandler(SXSSFSheet sheet, Map<String, XSSFCellStyle> styles, int rownum, int celnum) {
		super();
		this.sheet = sheet;
		this.styles = styles;
		this.rownum = rownum;
		this.celnum = celnum;
	}

	@Override
	public void handleResult(ResultContext context) {
		if (context.getResultObject() instanceof Map) {
			/*HashMap<String,Object> map = (HashMap<String, Object>) context.getResultObject();
			LinkedHashMap<String, Object> excelMap = new LinkedHashMap<String, Object>( map );*/
			
			LinkedHashMap<String, Object> excelMap = (LinkedHashMap<String, Object>) context.getResultObject();
			Row row = null;
			row = sheet.createRow(rownum);
			Iterator<String> keyData = excelMap.keySet().iterator();
			int j = celnum;
			while (keyData.hasNext()) {
				String key = StringUtil.noNull(keyData.next());
				String value = StringUtil.noNull(excelMap.get(key));

				Cell cel = row.createCell(j);
				cel.setCellStyle(styles.get("defaultSytle"));
				//임시
				if (key.equals("WAST_NO")) {
					BigDataExcelUtil.setCellValue(cel, value, "integer");
				} else {
					BigDataExcelUtil.setCellValue(cel, value, "String");
				}
				j++;
			}
			rownum++;
		}

	}

}

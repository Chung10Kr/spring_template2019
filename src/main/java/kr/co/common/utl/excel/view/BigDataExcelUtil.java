package kr.co.common.utl.excel.view;

import java.util.HashMap;
import java.util.Map;

import kr.co.common.com.utils.StringUtil;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.RichTextString;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFDataFormat;
import org.apache.poi.xssf.usermodel.XSSFFont;
import org.apache.poi.xssf.usermodel.XSSFRichTextString;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * 대용량 엑셀 파일 다운로드 유틸
 * @author Bang
 * b8545@naver.com
 */
public class BigDataExcelUtil {

  /**
   * Excel Cell값 세팅
   * @param cell
   * @param value
   * @param valueType
   */
  public static void setCellValue(Cell cell, Object value, String valueType) {
    String celVal = StringUtil.noNull(value);
    String sValType = valueType.toLowerCase();
    if (celVal == null || (celVal != null && celVal.equals(""))) {
      cell.setCellValue((RichTextString) new XSSFRichTextString(""));
    } else if ("integer".equals(sValType)) {
      cell.setCellType(Cell.CELL_TYPE_NUMERIC);
      cell.setCellValue(new Double(new String(celVal.toString())));
    } else if ("string".equals(sValType)) {
      cell.setCellType(Cell.CELL_TYPE_STRING);
      cell.setCellValue((RichTextString) new XSSFRichTextString(celVal));
    }
  }
 
  /**
   * Cell단위 스타일들
   * @param wb
   * @return
   */
  public static Map<String, XSSFCellStyle> createStyles(XSSFWorkbook wb) {
    
    Map<String, XSSFCellStyle> styles = new HashMap<String, XSSFCellStyle>();
    XSSFDataFormat fmt = wb.createDataFormat();
    
    // 기본 스타일
    XSSFCellStyle defaultSytle = wb.createCellStyle();
    defaultSytle.setBorderRight(XSSFCellStyle.BORDER_THIN); // 테두리 설정
    defaultSytle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
    defaultSytle.setBorderTop(XSSFCellStyle.BORDER_THIN);
    defaultSytle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
    defaultSytle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
    defaultSytle.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
    styles.put("defaultSytle", defaultSytle);
    
    // 아래 스타일은 상황에 맞게 적절히 수정하던지 추가해서 사용한다.
    XSSFCellStyle style1 = wb.createCellStyle();
    style1.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
    style1.setDataFormat(fmt.getFormat("0.0%"));
    styles.put("percent", style1);
    
    XSSFCellStyle style2 = wb.createCellStyle();
    style2.setAlignment(XSSFCellStyle.ALIGN_CENTER);
    style2.setDataFormat(fmt.getFormat("0.0X"));
    styles.put("coeff", style2);
    
    XSSFCellStyle style3 = wb.createCellStyle();
    style3.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
    style3.setDataFormat(fmt.getFormat("$#,##0.00"));
    styles.put("currency", style3);
    
    XSSFCellStyle style4 = wb.createCellStyle();
    style4.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
    style4.setDataFormat(fmt.getFormat("mmm dd"));
    styles.put("date", style4);
    
    XSSFCellStyle number = wb.createCellStyle();
    number.setBorderRight(XSSFCellStyle.BORDER_THIN); // 테두리 설정
    number.setBorderLeft(XSSFCellStyle.BORDER_THIN);
    number.setBorderTop(XSSFCellStyle.BORDER_THIN);
    number.setBorderBottom(XSSFCellStyle.BORDER_THIN);
    number.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
    number.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
    number.setDataFormat(fmt.getFormat("#,##0.0#####################"));
    styles.put("number", number);
    
    XSSFCellStyle number2 = wb.createCellStyle();
    number2.setBorderRight(XSSFCellStyle.BORDER_THIN); // 테두리 설정
    number2.setBorderLeft(XSSFCellStyle.BORDER_THIN);
    number2.setBorderTop(XSSFCellStyle.BORDER_THIN);
    number2.setBorderBottom(XSSFCellStyle.BORDER_THIN);
    number2.setAlignment(XSSFCellStyle.ALIGN_RIGHT);
    number2.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
    styles.put("number2", number2);
    
    
    XSSFCellStyle style5 = wb.createCellStyle();
    XSSFFont headerFont = wb.createFont();
    headerFont.setBold(true);
    style5.setFillForegroundColor(IndexedColors.PALE_BLUE.getIndex());
    style5.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
    style5.setFont(headerFont);
    style5.setBorderRight(XSSFCellStyle.BORDER_THIN); // 테두리 설정
    style5.setBorderLeft(XSSFCellStyle.BORDER_THIN);
    style5.setBorderTop(XSSFCellStyle.BORDER_THIN);
    style5.setBorderBottom(XSSFCellStyle.BORDER_THIN);
    style5.setAlignment(XSSFCellStyle.ALIGN_CENTER);
    style5.setVerticalAlignment(XSSFCellStyle.VERTICAL_CENTER);
    style5.setWrapText(true); 
    styles.put("header", style5);
    
    return styles;
  }
  
}

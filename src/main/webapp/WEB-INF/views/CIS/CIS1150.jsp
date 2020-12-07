<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script type="text/javascript">
/****************************************
 * Script 전역 변수 선언
 ****************************************/
//---------------------------------------
//1. 사용자 변수 선언
//  1) Grid가 다수인 경우 grid+숫자(순차증가) 형식으로 선언 ex) grid, grid2, grid3
//  
//---------------------------------------
var grid1 ;

//---------------------------------------
//2. Grid Colums 정보
//1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns, columns2 columns3
//---------------------------------------
var columns =
[
  {header:'idn',name:'idn',minWidth:100},
  {header:'comp_cd',name:'comp_cd',minWidth:100},
  {header:'comp_nm',name:'comp_nm',minWidth:100},
  {header:'plant_cd',name:'plant_cd',minWidth:100},
  {header:'plant_nm',name:'plant_nm',minWidth:100},
  {header:'biz_comp_cd',name:'biz_comp_cd',minWidth:100},
  {header:'biz_comp_nm',name:'biz_comp_nm',minWidth:100},
  {header:'bar_cd',name:'bar_cd',minWidth:100},
  {header:'trs_cd',name:'trs_cd',minWidth:100},
  {header:'trs_date',name:'trs_date',minWidth:100},
  {header:'trs_by',name:'trs_by',minWidth:100},
  {header:'trs_by_nm',name:'trs_by_nm',minWidth:100},
  {header:'fr_strg_loc',name:'fr_strg_loc',minWidth:100},
  {header:'fr_strg_loc_nm',name:'fr_strg_loc_nm',minWidth:100},
  {header:'fr_ld_loc',name:'fr_ld_loc',minWidth:100},
  {header:'to_strg_loc',name:'to_strg_loc',minWidth:100},
  {header:'to_strg_loc_nm',name:'to_strg_loc_nm',minWidth:100},
  {header:'to_ld_loc',name:'to_ld_loc',minWidth:100},
  {header:'qty',name:'qty',minWidth:100},
  {header:'proc_qty',name:'proc_qty',minWidth:100},
  {header:'trg_ctrl',name:'trg_ctrl',minWidth:100},
  {header:'pre_qty',name:'pre_qty',minWidth:100},
  {header:'wc_cd',name:'wc_cd',minWidth:100},
  {header:'par_bar_cd',name:'par_bar_cd',minWidth:100},
  {header:'st_div',name:'st_div',minWidth:100},
  {header:'part_no',name:'part_no',minWidth:100},
  {header:'part_nm',name:'part_nm',minWidth:100},
  {header:'ref_part_no',name:'ref_part_no',minWidth:100},
  {header:'fr_erp_strg_loc',name:'fr_erp_strg_loc',minWidth:100},
  {header:'to_erp_strg_loc',name:'to_erp_strg_loc',minWidth:100},
  {header:'rmk',name:'rmk',minWidth:100},
  {header:'trs_ymd',name:'trs_ymd',minWidth:100}
];
var options={
		rowNum:'Y'
}
/****************************************
 * 3. 화면 초기정보
 *    1) 조회조건 초기화, 그리드 초기화, default, focus
 *    2) 언어데이터 패치, code 데이터 패치
 ****************************************/
$(function () {
	
	var initParams = {
			   columns:[columns],
			   search: ["#searchForm .searchTable"],
			   priv: "<c:out value="${menuMap.priv}"/>"
	};
	G_INIT.init(initParams);
	
	grid1 = G_CMP.getGrid("grid1",columns,"",options);
});

/****************************************
 * 4. 공통 함수
 ****************************************/
//---------------------------------------
//1) 조회
//---------------------------------------
function fnSelect() {
	/*Form Check*/	
	var frm = document.searchForm;
	if (!gfnValidate(frm))return;
	/*Form Check*/
	frm.mapper_id.value="CIS1150.getList"
	
	var url = "/JOB/CIS1150/getList";
	var sendData= $("#searchForm").serialize();
	var sucessFunc = function(data) {
 		G_CMP.setData( grid1,data.result );
 	};
 	 
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
//---------------------------------------
//2) 추가
//---------------------------------------
function fnOpenLayerPop() {
	return false;
};
//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate(data){
	return false;
};
//---------------------------------------
//4) 삭제
//---------------------------------------
function fnDelete() {
	return false;
};
//---------------------------------------
//4) 엑셀 다운로드
//---------------------------------------
function fnExcelDown(){
	return false;
};

/****************************************
 * 사용자 정의 함수
 * -> 형식은 자유롭게 
 * -> 단 fnSelect, fnInsert, fnDelete, fnUpdate , fnExcelDown 중복 불가
 ****************************************/
</script>

<!-- 수정,삭제 From -->
<form id="editForm" name="editForm">
	<input type="hidden" name="data" /> <!-- 수정된 데이터 -->
	<input type="hidden" name="mapper_id"/>
</form>

<div id="searchArea" class="searchArea H50">

	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
		<%-- Select Parameter--%>
		<input type="hidden" name="mapper_id"/>
		<%-- Select Parameter--%>
	 
		<table class="searchTable">
			<caption>바코드 처리 이력 검색조건</caption>
		    <colgroup>
		        <col style="width: 15%;" />
		        <col/>
		    </colgroup>
			<tbody>
				<tr>
					<th>bar_cd</th>
					<td><input type="text" name="bar_cd" title="바코드" class="checkNull entrKey W300" value="141324J1801210001"></td>
					
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

<div id="layerPopArea"/> 



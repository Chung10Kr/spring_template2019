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
  {header:'comp_cd',name:'comp_cd'},
  {header:'part_no',name:'part_no'},
  {header:'part_nm',name:'part_nm'},
  {header:'std_part_no',name:'std_part_no'},
  {header:'std_part_nm',name:'std_part_nm'},
  {header:'proc_cd',name:'proc_cd'},
  {header:'proc_cd_nm',name:'proc_cd_nm'},
  {header:'proc_ord',name:'proc_ord'},
  {header:'mdl_cd',name:'mdl_cd'}
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
	
	fnSelect();
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
	frm.mapper_id.value="CIS2027.getList"
	
	var url = "/JOB/CIS2027/getList";
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
			<caption>공용공정라우트관리</caption>
		    <colgroup>
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col style="width: 12%;" />
		        <col/>
		    </colgroup>
			<tbody>
				<tr>
					<th>part_no</th>
					<td><input type="text" name="part_no" title="" class="entrKey" value=""></td>
					<th>proc_cd</th>
					<td><input type="text" name="proc_cd" title="" class="entrKey" value=""></td>
					<th>proc_cd_nm</th>
					<td><input type="text" name="proc_cd_nm" title="" class="entrKey" value=""></td>
					<th>mdl_cd</th>
					<td><input type="text" name="mdl_cd" title="" class="entrKey" value=""></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

<div id="layerPopArea"/> 



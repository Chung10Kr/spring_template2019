<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script type="text/javascript">
/****************************************
 * Script 전역 변수 선언
 ****************************************/
//---------------------------------------
//1. 사용자 변수 선언
//  1) Grid가 다수인 경우 grid+숫자(순차증가) 형식으로 선언 ex) grid1, grid2, grid3
//  
//---------------------------------------
var grid1;
//---------------------------------------
//2. Grid Colums 정보
//1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns, columns2 columns3
//---------------------------------------
var columns1 =
[
	{header:'user_id',name:'user_id'},
	{header:'user_nm',name:'user_nm',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'user_pwd',name:'user_pwd',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'pm_id',name:'pm_id',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'pm_pwd',name:'pm_pwd',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'emp_no',name:'emp_no',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'use_yn',name:'use_yn',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'comp_cd',name:'comp_cd',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'biz_comp_cd',name:'biz_comp_cd',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'plant_cd',name:'plant_cd',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'wb_cd',name:'wb_cd',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'biz_comp_fg',name:'biz_comp_fg',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'dept_cd',name:'dept_cd',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header:'rmk',name:'rmk',editor:{type:'text'}, ChgFunc: "fnUpdate" },
	{header:'create_by',name:'create_by'},
	{header:'create_date',name:'create_date'},
	{header:'update_by',name:'update_by'},
	{header:'update_date',name:'update_date'}
];

/****************************************
 * 3. 화면 초기정보
 *    1) 조회조건 초기화, 그리드 초기화, default, focus
 *    2) 언어데이터 패치, code 데이터 패치
 ****************************************/
$(function () {
	var initParams = {
			   columns:[columns1],
			   search: ["#searchForm .searchTable"],
			   priv: "<c:out value="${menuMap.priv}"/>"
	};
	G_INIT.init(initParams);
	
	var option={
			rowNum : 'Y', 
	};
	grid1 = G_CMP.getGrid("grid1",columns1,"",option);
	
	/*초기 조회*/
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
	
	frm.mapper_id.value="CIS1060.getList";
	
	var url = "/JOB/CIS1060/getList";
	var sendData= $("#searchForm").serialize();

	var sucessFunc = function(data) {
 		G_CMP.setData( grid1, data.result );
 	};
 	 
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
//---------------------------------------
//2) 추가
//---------------------------------------
function fnOpenLayerPop() {
	var url = "/POP/CIS/CIS1060P0"; 
    var params = {
    		
    };
    var sucessFunc = function(data) {
        $("#layerPopArea").html("");
        $("#layerPopArea").html(data);
    };
    G_AJAX.ajaxCallHtml(url, params, sucessFunc);
};
//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate(data) {
	var frm = document.editForm;
	frm.mapper_id.value="CIS1060.update";
    frm.data.value= JSON.stringify( grid1.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/JOB/CIS1060/update";
 	var sucessFunc = function(data) {
 	};
 	/* G_AJAX.ajaxCall(url , sendData , sucessFunc ); */
}
//---------------------------------------
//4) 삭제
//---------------------------------------
function fnDelete() {

	if (!confirm('삭제하시겠습니까?')){
		return false;
	}; 
	
	var frm = document.editForm;
	var checkedData = grid1.getCheckedRows();
	
	if(G_COMM.gfnCheckNull(checkedData) == ""){
		alert("삭제 데이터를 선택해 주세요");
		return false;
	};
	frm.mapper_id.value="CIS1060.delete";
	frm.data.value=JSON.stringify( checkedData ) ;
	var sendData = $("#editForm").serialize();

	var url = "/JOB/CIS1060/delete";
 	var sucessFunc = function(data) {
 		fnSelect();
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
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

<form id="editForm" name="editForm">
	<input type="hidden" name="mapper_id"/>
	<input type="hidden" name="data" /> <!-- 수정된 데이터 -->
</form>
<div id="searchArea" class="searchArea H80">
	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
	<%-- Select Parameter--%>
	<input type="hidden" name="mapper_id"/>
	<%-- Select Parameter--%>
    
		<table class="searchTable">
			<caption>Test 검색조건</caption>
		    <colgroup>
		    	<col class="H15">
		    	<col class="H15">
		    	<col class="H15">
		    	<col class="H15">
		    	<col class="H15">
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>comp_cd</th>
					<td><select type="text" name="comp_cd" select-type="-ALL-" class=""/></td>
					<th>user_id</th>
					<td><input type="text" name="user_id" class="entrKey" ></td>
					<th>user_nm</th>
					<td colspan="3"><input type="text" name="user_nm" class="entrKey W300" ></td>
				</tr>
				<tr>
					<th>biz_comp_fg</th>
					<td><select type="text" name="biz_comp_fg" select-type="-ALL-"  class=""/></td>
					<th>use_yn</th>
					<td colspan="3"><select type="text" name="use_yn" select-type="-ALL-" class="W300"/></td>	
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

<div id="layerPopArea"/>
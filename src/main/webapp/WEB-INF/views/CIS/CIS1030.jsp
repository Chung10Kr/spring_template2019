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
var grid2;
//---------------------------------------
//2. Grid Colums 정보
//1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns, columns2 columns3
//---------------------------------------

var columns1 =
[
	{header: 'system_id',name: 'system_id'},
	{header: 'major_cd',name: 'major_cd'},
	{header: 'major_nm',name: 'major_nm',editor:{type:'text'}, ChgFunc: "fnUpdate"},
	{header: 'cd_kind',name: 'cd_kind',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header: 'cd_type',name: 'cd_type',editor:{type:'select'}, ChgFunc: "fnUpdate" }, 
	{header: 'use_yn',name: 'use_yn',editor:{type:'select'}, ChgFunc: "fnUpdate" },
	{header: 'rmk',name: 'rmk',editor:{type:'text'}, ChgFunc: "fnUpdate" }
];

var columns2 =
[
	{header: 'minor_cd',name: 'minor_cd',},
	{header: 'minor_nm',name: 'minor_nm',editor:{type:'text'},ChgFunc:"fnUpdate2"},
	{header: 'rmk',name: 'rmk',editor:{type:'text'},ChgFunc:"fnUpdate2"},
	{header: 'sort_no',name: 'sort_no',editor:{type:'text'},ChgFunc:"fnUpdate2"},
	{header: 'use_yn',name: 'use_yn',editor:{type:'select'},ChgFunc:"fnUpdate2"}
];

/****************************************
 * 3. 화면 초기정보
 *    1) 조회조건 초기화, 그리드 초기화, default, focus
 *    2) 언어데이터 패치, code 데이터 패치
 ****************************************/
$(function () {
	var initParams = {
			   columns:[columns1 , columns2],
			   search: ["#searchForm .searchTable"],
			   priv: "<c:out value="${menuMap.priv}"/>"
	};
	G_INIT.init(initParams);
	
	var option={
			rowNum : 'Y', 
	};
	grid1 = G_CMP.getGrid("grid1",columns1,"",option);
	grid2 = G_CMP.getGrid("grid2",columns2,"",option);
	
	/*초기 조회*/
	fnSelect();

	//click 이벤트
	G_CMP.event(grid1,"click",function(data) {
		var target = data.columnName;
		
		/*특정 컬럼 클릭 이벤트*/
		var clickCol = ['_number','system_id','major_cd']
		if(G_COMM.gfnCheckNull(grid1.getRow(data.rowKey).major_cd) != ""){
			if( $.inArray(target,clickCol) != -1){
			   fnSelect2( grid1.getRow(data.rowKey) );
			};
		};
			
		 
	});
    
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
	
	frm.mapper_id.value="CIS1030.getMajorList";
	
	var url = "/JOB/CIS1030/getList";
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
	var url = "/POP/CIS/CIS1030P0"; 
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
	frm.mapper_id.value="CIS1030.updateMajor";
    frm.data.value= JSON.stringify( grid1.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/JOB/CIS1030/update";
 	var sucessFunc = function(data) {
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
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
//---------------------------------------
//5) 조회2 minor Code 조회
//---------------------------------------
function fnSelect2(obj) {
	
	var frm = document.searchForm2;
	
	if(obj != undefined){
		frm.system_id.value=obj.system_id;
		frm.major_cd.value=obj.major_cd;	
	};
	frm.mapper_id.value="CIS1030.getMinorList";
	var url = "/JOB/CIS1030/getList";
	var sendData= $("#searchForm2").serialize();
	var sucessFunc = function(data) {
		G_CMP.setData( grid2, data.result );
	};
	G_AJAX.ajaxCall(url , sendData , sucessFunc );
};
//---------------------------------------
//5) 추가 팝업 minor Code 추가 팝업
//---------------------------------------
function fnOpenLayerPop1() {
	if( G_COMM.gfnCheckNull($("#vSystemId").val()) == ""){
		return false;
	};
	var url = "/POP/CIS/CIS1030P1"; 
    var params = {
    		
    };
    var sucessFunc = function(data) {
        $("#layerPopArea").html("");
        $("#layerPopArea").html(data);
        
	    var frm = document.searchForm2;
		var frmMinor = document.popForm;
	    frmMinor.system_id.value=frm.system_id.value;
		frmMinor.major_cd.value=frm.major_cd.value;
    };
    G_AJAX.ajaxCallHtml(url, params, sucessFunc);

};
//---------------------------------------
//6) 수정2
//---------------------------------------
function fnUpdate2(data) {
	var frm = document.editForm;
	frm.mapper_id.value="CIS1030.updateMinor";
    frm.data.value= JSON.stringify( grid2.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/JOB/CIS1030/update";
	var sucessFunc = function(data) {
		
	};
	G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
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
<div id="searchArea" class="searchArea H50">
	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
	<%-- Select Parameter--%>
	<input type="hidden" name="mapper_id"/>
	<%-- Select Parameter--%>
	 
	<%-- Excel Download Parameter--%>
    <input type="hidden" name="tFileNm"/>
    <input type="hidden" name="dFielNm"/>
    <input type="hidden" name="sR"/>
    <input type="hidden" name="sC"/>
    <%-- Excel Download Parameter--%>
    
		<table class="searchTable">
			<caption>Test 검색조건</caption>
		    <colgroup>
		    	<col class="H10p"/>
		    	<col class="H15p"/>
		    	<col class="H10p"/>
		    	<col class="H15p"/>
		    	<col class="H10p"/>
		    	<col class="H15p"/>
		    	<col class="H10p"/>
		    	<col />
		    </colgroup>
			<tbody>
				<tr>
					<th>system_id</th>
					<td><select name="system_id" select-type="-ALL-" title="시스템ID"></select></td>
					<th>major_cd</th>
					<td><input type="text" name="major_cd" class="notHangulOnly entrKey" maxlength="20" title="코드 "></td>
					<th>major_nm</th>
					<td><input type="text" name="major_nm" class="entrKey" maxlength="20" title="코드명"></td>
					<th>use_yn</th>
					<td><select name="use_yn" select-type="-ALL-" title="사용여부"></select></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H40p W100p" id="grid1"></div>
	<div class="searchArea H60p PdL0 PdR0">
		<div class="fr H50 MgB5">
	      <div class="btn-group mr-2 ${theme}_ChArea">
	      	<html:buttonAuth gubun="add" script="fnOpenLayerPop1();return false;" title="등록" classNm="${theme}_ChBtn W80"/>
	      </div>
	      
	      	<form id="searchForm2" name="searchForm2">
				<%-- Select Parameter--%>
				<input type="hidden" name="mapper_id"/>
				<input type="hidden" name="major_cd"/>
				<input type="hidden" name="system_id" id="vSystemId"/>
				<%-- Select Parameter--%>
			</form>
	      
    	</div>
    	<div class="W100p H90p" id="grid2"></div>
	</div>
</div>

<div id="layerPopArea"/>
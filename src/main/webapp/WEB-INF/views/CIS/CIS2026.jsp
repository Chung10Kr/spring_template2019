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
	{header: 'part_no',name: 'part_no'},
	{header: 'part_nm',name: 'part_nm'},
	{header: 'mdl_cd',name: 'mdl_cd'}
];

var columns2 =
[
	{header:'comp_cd',name:'comp_cd'},
	{header:'part_no',name:'part_no'},
	{header:'part_nm',name:'part_nm'},
	{header:'proc_cd',name:'proc_cd'},
	{header:'proc_cd_nm',name:'proc_cd_nm'},
	{header:'proc_ord',name:'proc_ord'},
	{header:'std_sub_part_no',name:'std_sub_part_no'},
	{header:'sub_part_nm',name:'sub_part_nm'},
	{header:'out_proc_yn',name:'out_proc_yn'},
	{header:'biz_comp_cd',name:'biz_comp_cd'},
	{header:'biz_comp_nm',name:'biz_comp_nm'},
	{header:'trnkey_yn',name:'trnkey_yn'},
	{header:'prd_rgstr_yn',name:'prd_rgstr_yn'},
	{header:'chk_yn',name:'chk_yn'},
	{header:'insp_yn',name:'insp_yn'},
	{header:'drct_dlvy_yn',name:'drct_dlvy_yn'},
	{header:'use_yn',name:'use_yn'},
	{header:'proc_ord_no',name:'proc_ord_no'},
	{header:'wc_cd',name:'wc_cd'},
	{header:'wc_nm',name:'wc_nm'}
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
		var clickCol = ['_number','part_no','part_nm','mdl_cd']
		if(G_COMM.gfnCheckNull(grid1.getRow(data.rowKey).part_no) != ""){
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
	
	frm.mapper_id.value="CIS2026.getList";
	
	var url = "/JOB/CIS2026/getList";
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
	return false;
};
//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate(data) {
	return false;
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
function fnSelect2(obj) {
	
	var frm = document.searchForm2;
	
	if(obj != undefined){
		frm.part_no.value=obj.part_no;
	};
	frm.mapper_id.value="CIS2026.getList2";
	var url = "/JOB/CIS2026/getList";
	var sendData= $("#searchForm2").serialize();
	var sucessFunc = function(data) {
		G_CMP.setData( grid2, data.result );
	};
	G_AJAX.ajaxCall(url , sendData , sucessFunc );
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
		    	<col class="H20p">
		    	<col class="H30p">
		    	<col class="H20p">
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>part_no</th>
					<td><input type="text" name="part_no" class="entrKey" value="" title="품번"></td>
					<th>mdl_cd</th>
					<td><input type="text" name="mdl_cd" class="notHangulOnly entrKey" value="" title="모델코드"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W40p fl" id="grid1"></div>
	<form id="searchForm2" name="searchForm2">
		<%-- Select Parameter--%>
		<input type="hidden" name="mapper_id"/>
		<input type="hidden" name="part_no"/>
		<%-- Select Parameter--%>
	</form>
   	<div class="H100p W60p fr" id="grid2"></div>
</div>

<div id="layerPopArea"/>
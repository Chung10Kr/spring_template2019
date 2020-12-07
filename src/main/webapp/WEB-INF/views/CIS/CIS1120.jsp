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
	{header: 'user_id',name: 'user_id'},
	{header: 'user_nm',name: 'user_nm'},
	{header: 'dept_cd',name: 'dept_cd'}
];

var columns2 =
[
	{header: 'role_auth',name:'role_auth',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"},
	{header: 'role_cd',name: 'role_cd' ,  filter: {type: 'text'} },
	{header: 'role_nm',name: 'role_nm' , }
	
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
		var clickCol = ['_number','user_id','user_nm','dept_cd']
		if(G_COMM.gfnCheckNull(grid1.getRow(data.rowKey).user_id) != ""){
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
	
	var url = "/USR/RAUTH/getList";
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
	var frm = document.editForm;
    frm.data.value= JSON.stringify( grid2.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/USR/RAUTH/updateRole";
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
		frm.user_id.value=obj.user_id;
		frm.comp_cd.value=obj.comp_cd;	
	};
	var url = "/USR/RAUTH/getAuthList";
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
	<input type="hidden" name="data" /> <!-- 수정된 데이터 -->
</form>
<div id="searchArea" class="searchArea H50">
	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
	<%-- Select Parameter--%>
	<%-- Select Parameter--%>
	 
	<%-- Excel Download Parameter--%>
    <input type="hidden" name="tFileNm"/>
    <input type="hidden" name="dFielNm"/>
    <input type="hidden" name="sR"/>
    <input type="hidden" name="sC"/>
    <%-- Excel Download Parameter--%>
    
		<table class="searchTable">
			<caption>사용자별 롤관리 검색조건</caption>
		    <colgroup>
		    	<col class="H20p">
		    	<col class="H30p">
		    	<col class="H20p">
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>user_id</th>
					<td><input type="text" name="user_id" class="entrKey" title=""></td>
					<th>user_nm</th>
					<td><input type="text" name="user_nm" class="entrKey" title=""></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W40p fl" id="grid1"></div>
   	<div class="H100p W60p fr" id="grid2"></div>
</div>
<form id="searchForm2" name="searchForm2">
	<%-- Select Parameter--%>
	<input type="hidden" name="user_id"/>
	<input type="hidden" name="comp_cd"/>
	<%-- Select Parameter--%>
</form>

<div id="layerPopArea"/>
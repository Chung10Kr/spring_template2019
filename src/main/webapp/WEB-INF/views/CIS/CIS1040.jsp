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
  {header: 'menu_nm',name: 'menu_nm',editor:{type:'text'}, ChgFunc: "fnUpdate",minWidth:200},
  {header: 'system_id',name: 'system_id'},
  {header: 'menu_id',name: 'menu_id'},
  {header: 'parent_menu_id',name: 'parent_menu_id',type:{type:'text'} , ChgFunc: "fnUpdate" },
  {header: 'menu_url',name: 'menu_url',editor:{type:'text'} , ChgFunc: "fnUpdate"},
  {header: 'disp_yn',name: 'disp_yn',editor:{type:'select'}, ChgFunc: "fnUpdate" },
  {header: 'use_yn',name: 'use_yn',editor:{type:'select'} , ChgFunc: "fnUpdate" },
  {header: 'sort_no',name: 'sort_no',editor:{type:'text'} , ChgFunc: "fnUpdate" }

  
];
var options={
		treeCheck : "Y",treeTarget:"menu_nm"
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
	
	//달력 셋팅 ->시작일~종료일 
    G_COMM.gfnInitDatePicker1Two();
	
	grid1 = G_CMP.getGrid("grid1",columns,"",options);
	
	/*초기 조회*/
	fnSelect();
	
	/*Tree grid expand collapse start*/
	G_CMP.event(grid1,'expand', (ev) => {
	      const {rowKey} = ev;
	      const descendantRows = grid1.getDescendantRows(rowKey);
	      if (!descendantRows.length) {
	    	  grid1.appendRow({name: 'dynamic loading data',_children: [ {name: 'leaf row'},{name: 'internal row',_children: []} ]
	        }, { parentRowKey: rowKey });
	      };});
	G_CMP.event(grid1,'collapse', (ev) => {
	      const {rowKey} = ev;
	      const descendantRows = grid1.getDescendantRows(rowKey);
	    });
	/*Tree grid expand collapse end*/
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
	
	frm.mapper_id.value="CIS1040.getList";
	var url = "/JOB/CIS1040/getList";
	
	var sendData= $("#searchForm").serialize();

	var sucessFunc = function(data) {
		console.log( typeof( data.result ) );
		console.log( data.result );
 		G_CMP.setData( grid1,  G_COMM.setTreeData(data.result,false)  );
 	};
 	 
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
//---------------------------------------
//2) 추가
//---------------------------------------
function fnOpenLayerPop() {
	var url = "/POP/CIS/CIS1040P0"; 
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
function fnUpdate(data){
	selectTreeKey=data; //Tree 구조 필수구문
	
	var frm = document.editForm;
	frm.mapper_id.value="CIS1040.updateMenu";
    frm.data.value= JSON.stringify( grid1.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/JOB/CIS1040/update";
	var rowKey = data
 	var sucessFunc = function(data) {
		fnSelect();
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
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
			<caption>Test 검색조건</caption>
		    <colgroup>
		        <col style="width: 10%;" />
		        <col style="width: 15%;" />
		        <col style="width: 10%;" />
		        <col style="width: 15%;" />
		        <col style="width: 10%;" />
		        <col style="width: 15%;" />
		        <col style="width: 10%;" />
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>system_id</th>
					<td><select type="text" name="system_id" select-type="-ALL-"class=""></select>
					<th>menu_nm</th>
					<td><input type="text" name="menu_nm" class="entrKey"></td>
					<th>menu_id</th>
					<td><input type="text" name="menu_id" class="entrKey"></td>
					<th>use_yn</th>
					<td><select type="text" name="use_yn" select-type="-ALL-"class=""></select>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

<div id="layerPopArea"/> 



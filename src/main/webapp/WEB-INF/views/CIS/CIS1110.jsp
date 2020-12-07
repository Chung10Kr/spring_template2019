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
var grid2 ; 
//---------------------------------------
//2. Grid Colums 정보
//1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns, columns2 columns3
//---------------------------------------
var columns1 =
[
  {header: 'role_cd',name: 'role_cd'},
  {header: 'role_nm',name: 'role_nm'},
];
var columns2 =
	[

	  {header: 'menu_id',name: 'menu_id'},
	  {header: 'menu_nm',name: 'menu_nm'},
	  {header: 'perm_use',name: 'perm_use',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"}, //권한여부 'U'
	  {header: 'perm_ad',name: 'perm_ad',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"},   //등록권한 'A'
	  {header: 'perm_re',name: 'perm_re',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"},   //읽기권한 'R'
	  {header: 'perm_de',name: 'perm_de',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"},   //삭제권한 'D'
	  {header: 'perm_sa',name: 'perm_sa',editor: {type: 'checkbox'}, ChgFunc: "fnUpdate"},   //수정권한 'S'
	];
var option1={
}
var option2={
		treeCheck : "Y",treeTarget : "menu_id"
}

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
	
	//달력 셋팅 ->시작일~종료일 
    G_COMM.gfnInitDatePicker1Two();
	
	grid1 = G_CMP.getGrid("grid1",columns1,"",option1);
	grid2 = G_CMP.getGrid("grid2",columns2,"",option2);
	
	/*초기 조회*/
	fnAuthSelect();
    
	//click 이벤트
	G_CMP.event(grid1,"click",function(data) {
		var target = data.columnName;
		
		/*특정 컬럼 클릭 이벤트*/
		var clickCol = ['_number','role_cd','role_nm']
		if(G_COMM.gfnCheckNull(grid1.getRow(data.rowKey)) != ""){
			if( $.inArray(target,clickCol) != -1){
			   fnSelect( grid1.getRow(data.rowKey) );
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
function fnAuthSelect() {
	/*Form Check*/	
	var frm = document.searchForm;
	if (!gfnValidate(frm))return;
	/*Form Check*/
	
	var url = "/USR/AUTH/getList";
	
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
	G_COMM.openLayerPop("0");
};
//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate(data) {
	selectTreeKey=data;
	var frm = document.editForm;
    frm.data.value= JSON.stringify( grid2.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/USR/AUTH/updateAuth";
 	var sucessFunc = function(data) {
 		fnSelect();
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
//권한 조회
function fnSelect(obj) {
	
	var frm = document.searchForm;

	if(obj != undefined){
		frm.role_cd.value=obj.role_cd;
	};
	
	var url = "/USR/AUTH/getAuthList";
	var sendData= $("#searchForm").serialize();
	var sucessFunc = function(data) {
		G_CMP.setData( grid2,  G_COMM.setTreeData(data.result , false)  );
	};
	G_AJAX.ajaxCall(url , sendData , sucessFunc );
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
</form>

<div id="searchArea" class="searchArea H50 ">

	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
	<%-- Select Parameter--%>
	<input type="hidden" name="role_cd"/>
	<%-- Select Parameter--%>
	 
		<table class="searchTable">
			<caption>Test 검색조건</caption>
		    <colgroup>
		        <col style="width: 85%;" />
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>menu_nm</th>
					<td><input type="text" name="menu_nm" class="entrKey"></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W30p fl" id="grid1"></div>
	<div class="H100p W70p fr" id="grid2"></div>
</div>

 



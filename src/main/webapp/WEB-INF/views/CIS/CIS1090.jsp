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
var grid1;

//---------------------------------------
//2. Grid Colums 정보
//1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns, columns2 columns3
//---------------------------------------
var columns=
[
  {header: 'role_cd' ,name: 'role_cd'},
  {header: 'role_nm' ,name: 'role_nm'	,editor:{type:'text'} 	,ChgFunc:'fnUpdate' },
  {header: 'rmk'	 ,name: 'rmk'		,editor:{type:'text'} 	,ChgFunc:'fnUpdate' },
  {header: 'use_flag',name: 'use_flag'	,editor:{type:'select'} ,ChgFunc:'fnUpdate' },
  {header: 'create_date',name:'create_date'},
  {header: 'create_by'  ,name:'create_by'  },
  {header: 'update_date',name:'update_date'},
  {header: 'update_by'	,name:'update_by'  }
];
var options={
		rowNum : 'Y'
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
	
	frm.mapper_id.value="CIS1090.getList";
	var url = "/JOB/CIS1090/getList";
	
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
	var url = "/POP/CIS/CIS1090P0"; 
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
	frm.mapper_id.value="CIS1090.update";
    frm.data.value= JSON.stringify( grid1.getRow(data) );
	var sendData = $("#editForm").serialize();
	var url = "/JOB/CIS1090/update";
 	var sucessFunc = function(data) {
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
		        <col style="width: 15%;" />
		        <col style="width: 15%;" />
		        <col style="width: 15%;" />
		        <col style="width: 15%;" />
		        <col style="width: 15%;" />
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>role_cd</th>
					<td><input type="text" name="role_cd" class="entrKey"></td>
					<th>role_nm</th>
					<td>
						<input type="text" name="role_nm" class="entrKey" />
					</td>
					<th>use_flag</th>
					<td><select name="use_flag" select-type="-ALL-" title=""></select></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

 
<div id="layerPopArea"/>



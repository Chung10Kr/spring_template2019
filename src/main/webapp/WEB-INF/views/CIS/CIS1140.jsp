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
  {header: 'title',name: 'title'},
  {header: 'create_by',name: 'create_by'},
  {header: 'create_date',name: 'create_date'}
];
//perPage , treeChek , rowNum , rowCheckbox
var option={
		rowNum : 'Y',
		rowCheckbox:'Y'
};

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

	grid1 = G_CMP.getGrid("grid1",columns,"",option);
	
	/*초기 조회*/
	fnSelect();
    
	//click 이벤트
	G_CMP.event(grid1,"click",function(data) {
		var target = data.columnName;
		if(G_COMM.gfnCheckNull(grid1.getRow(data.rowKey).seq) != ""){
			if( target != "_checked"){
				 // checkbox 클릭 이동 방지
				fnView( grid1.getRow(data.rowKey).seq );	
			}
		}
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
	
	var url = "/USR/NOTICE/getList";
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
	var url = "/USR/NOTICE/insertPop"; 
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
	return false;
};
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
	
	frm.data.value=JSON.stringify( checkedData ) ;
	var sendData = $("#editForm").serialize();

	var url = "/USR/NOTICE/delete";
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
function fnView(seq){
	var url = "/USR/NOTICE/viewPop"; 
    var params = {
    		seq:seq
    };
    var sucessFunc = function(data) {
        $("#layerPopArea").html("");
        $("#layerPopArea").html(data);
    };
    G_AJAX.ajaxCallHtml(url, params, sucessFunc);
}
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

<div id="searchArea" class="searchArea H40">

	<!-- 검색 및 엑셀다운로드 From -->
	<form id="searchForm" name="searchForm" class="searchForm">
	
	<%-- Select Parameter--%>
	<input type="hidden" name="mapper_id"/>
	<%-- Select Parameter--%>
    
		<table class="searchTable">
			<caption>Test 검색조건</caption>
		    <colgroup>
		        <col style="width: 5%;" />
		        <col style="width: 10%;" />
		        <col style="width: 5%;" />
		        <col style="width: 10%;" />
		        <col style="width: 5%;" />
		        <col style="width: 10%;" />
		        <col style="width: 5%;" />
		        <col />
		    </colgroup>
			<tbody>
				<tr>
					<th>title</th>
					<td><input type="text" name="title" class=""></td>
					<th>create_by</th>
					<td>
						<input type="text" size="10" name="create_by" class="" />
					</td>
					<th>create_date</th>
					<td>
					<input type="text" size="10" class="W40p" name="startDay" id="startDay" title="시작일" /> 
            		~
            		<input type="text" size="10" class="W40p" name="endDay" id="endDay" title="종료일" />
					</td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<div id="gridArea">
	<div class="H100p W100p" id="grid1"></div>
</div>

<div id="layerPopArea"/>
<%-- <jsp:include page="CIS1140P0.jsp"></jsp:include><!-- 등록폼 -->
<jsp:include page="CIS1140P1.jsp"></jsp:include><!-- 조회폼 -->
<jsp:include page="CIS1140P2.jsp"></jsp:include><!-- 수정--> --%>


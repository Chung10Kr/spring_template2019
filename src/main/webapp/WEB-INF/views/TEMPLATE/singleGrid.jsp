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
  {
    header: 'name',
    name: 'name',
   	editor: 'text',
    onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }
  },
  {
    header: 'age',
    name: 'age',
	editor: 'text',
	onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }
  },
  {
	    header: 'birth',
	    name: 'birth',
		editor: {
			type: 'datePicker',
			options: {
				format: 'yyyy-MM-dd',
			}
		},
		onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }
		
  },
  {
 	 header: 'gender',
     name: 'gender',
	 editor: 'text',
	 onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }, 
	 formatter: 'listItemText',
	 editor: {
         type: 'select'
     }
  },
  {
    header: 'createuser',
    name: 'createuser'
  },
  {
    header: 'createdate',
    name: 'createdate'
  },
  {
    header: 'updateuser',
    name: 'updateuser'
  },
  {
    header: 'updatedate',
    name: 'updatedate'
  }
];

/****************************************
 * 3. 화면 초기정보
 *    1) 조회조건 초기화, 그리드 초기화, default, focus
 *    2) 언어데이터 패치, code 데이터 패치
 ****************************************/
$(function () {
	
	var initParams = {
			   columns:[columns],
			   search: ["#searchForm .searchTable"]
	};
	G_INIT.init(initParams);
	
	//달력 셋팅 ->시작일~종료일 
    G_COMM.gfnInitDatePicker1Two();
	
	grid1 = G_CMP.getGrid("grid1",columns,"",10);
	
	/*초기 조회*/
	fnSelect();

	//click 이벤트
	G_CMP.event(grid1,"click",function(data) {
		console.log(grid1.getRow(data.rowKey));
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
	
	frm.mapper_id.value="TEMPLATEGRIDSINGLE.getList";
	
	var url = "/JOB/TEMPLATEGRIDSINGLE/getList";
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
	G_COMM.openLayerPop();
};
//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate(data) {
	
	var frm = document.editForm;
	
	frm.mapper_id.value="TEMPLATEGRIDSINGLE.update";
    frm.data.value= JSON.stringify(data);
	
	var sendData = $("#editForm").serialize();
	var url = "/JOB/TEMPLATEGRIDSINGLE/update";
 	var sucessFunc = function(data) {
 		frm.reset();
 		fnSelect();
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
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
	
	frm.mapper_id.value="TEMPLATEGRIDSINGLE.delete";
	frm.data.value=JSON.stringify( checkedData ) ;
	var sendData = $("#editForm").serialize();

	var url = "/JOB/TEMPLATEGRIDSINGLE/delete";
 	var sucessFunc = function(data) {
 		frm.reset();
 		fnSelect();
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
};
//---------------------------------------
//4) 엑셀 다운로드
//---------------------------------------
function fnExcelDown(){
	var frm = document.searchForm;
	
	frm.mapper_id.value="TEMPLATEGRIDSINGLE.getExcel";
	frm.tFileNm.value="TEMPLATEGRIDSINGLE";
	frm.dFielNm.value="testExcel";
	frm.sR.value="3";
	frm.sC.value="0";
	
	G_COMM.excelDownLoad( '/UTL/EXCEL/download',"searchForm");
};
/****************************************
 * 사용자 정의 함수
 * -> 형식은 자유롭게 
 * -> 단 fnSelect, fnInsert, fnDelete, fnUpdate , fnExcelDown 중복 불가
 ****************************************/
</script>

<!-- 수정,삭제 From -->
<form id="editForm" name="editForm">
	<input type="hidden" name="mapper_id" />
	<input type="hidden" name="data" /> <!-- 수정된 데이터 -->
</form>

<div id="searchArea" class="H50">

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
		        <col style="width: 5%;" />
		        <col style="width: 10%;" />
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
					<th>컬럼 갯수</th>
					<td><input type="text" name="data_limit" class="intCheck checkNull entrKey" value="100" title="조회 데이터 갯수"></td>
					<th>name</th>
					<td><input type="text" name="name" class="entrKey"></td>
					<th>age</th>
					<td>
						<input type="text" size="10" class="W80p entrKey intCheck" name="age"/>
					</td>
					<th>gender</th>
					<td><select id="gender" name="gender" class="gender" class="select" select-type="-ALL-" ></select></td>
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

<jsp:include page="TEMPLATEGRIDSINGLEP1.jsp"></jsp:include>


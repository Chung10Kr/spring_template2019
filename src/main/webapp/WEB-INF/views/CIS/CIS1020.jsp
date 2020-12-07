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
//  1) Grid가 다수인 경우 columns+숫자(순차증가) 형식으로 선언 - ex) columns1, columns2 columns3
//---------------------------------------
var columns1 = [
    {header:'system_id', name:'system_id', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'major_cd', name:'major_cd', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'major_nm', name:'major_nm', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'cd_kind', name:'cd_kind', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'cd_type', name:'cd_type', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'rmk', name:'rmk', align:'left', editor:'text', 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }},
    {header:'use_yn', name:'use_yn', align:'left', editor:{type:'select'}, 
     onAfterChange: function(data){fnUpdate(grid1.getRow(data.rowKey)); }
    }
];

var rowHeaders1=[{type: 'rowNum'},{type: 'checkbox' }];

/****************************************
 * 3. 화면 초기정보
 *    1) 조회조건 초기화, 그리드 초기화, default, focus
 *    2) 언어데이터 패치, code 데이터 패치
 ****************************************/
$(function () {
	
	
	
    //조회조건, Grid Column 다국어 및 공통코드 바인딩 처리
    var initParams = {
        columns:[columns1],
        search:["#searchForm .searchTable"]
    };
    
    G_INIT.init(initParams);
    
    //달력 셋팅 ->시작일~종료일 
    /* G_COMM.gfnInitDatePicker1Two(); */
    
    //달력 셋팅
    /* G_COMM.gfnSetDatePickerTwo($("#test_date")); */
    
    //그리드 생성
    grid1 = G_CMP.getGrid("grid1",columns1,"",10,rowHeaders1);

    //초기 조회
    fnSelect();
});

/****************************************
 * 4. 공통 함수
 ****************************************/
//---------------------------------------
//1) 조회
//---------------------------------------
function fnSelect() {
    var frm = document.searchForm;
    if (!gfnValidate(frm)) return;
    
    frm.mapper_id.value="CIS1020.getList";
    
    var url = "/JOB/CIS1020/getList";
    
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
    G_COMM.openLayerPop('0');
}

//---------------------------------------
//3) 수정
//---------------------------------------
function fnUpdate() {
    var frm = document.editForm;
    
    frm.mapper_id.value="CIS1020.update";
    frm.data.value= JSON.stringify(data);
    
    var sendData = $("#editForm").serialize();
    var url = "/JOB/CIS1020/update";
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
    
    frm.mapper_id.value="CIS1020.delete";
    frm.data.value=JSON.stringify( checkedData ) ;
    var sendData = $("#editForm").serialize();

    var url = "/JOB/CIS1020/delete";
    var sucessFunc = function(data) {
        frm.reset();
        fnSelect();
    };
    G_AJAX.ajaxCall(url , sendData , sucessFunc );
}

//---------------------------------------
//5) 엑셀 다운로드
//---------------------------------------
function fnExcelDown(){
    
    var frm = document.searchForm;
    
    frm.mapper_id.value="CIS1020.getExcel";
    frm.tFileNm.value="CIS1020";
    frm.dFielNm.value="testExcel";
    frm.sR.value="3";
    frm.sC.value="0";
    
    G_COMM.excelDownLoad( '/UTL/EXCEL/download',"searchForm");
}
/****************************************
 * 사용자 정의 함수
 * -> 형식은 자유롭게 
 * -> 단 fnAdd, fnGetList, fnSave, fnDel 중복 불가
 ****************************************/  
 
</script>

<!-- 수정,삭제 From -->
<form id="editForm" name="editForm">
    <input type="hidden" name="mapper_id" />
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
            <caption>검색조건</caption>
            <colgroup>
                <col style='width: 8%;' />
                <col style='width: 10%;' />
                <col style='width: 8%;' />
                <col />
            </colgroup>
            <tbody>
                <tr>
                    <th>시스템 ID</th>
                    <td><input type='text' id='system_id' name='system_id'></td>
                    <th>상위코드명</th>
                    <td><input type='text' id='major_nm' name='major_nm' class="W20p"></td>
                </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="gridArea">
    <div class="H100p W100p grid" id="grid1"></div>
</div>
<jsp:include page='CIS1020P0.jsp'></jsp:include>
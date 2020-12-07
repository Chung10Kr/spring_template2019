<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<jsp:include page="TEMPLATEPopupCUD.jsp"></jsp:include>

<script type="text/javascript">
	//<![CDATA
	/****************************************
	 * Script 전역 변수 선언
	 ****************************************/
	//---------------------------------------
	//0. View 정보
	//---------------------------------------
	var pgmId = "GridSingleNoEdit";
	//---------------------------------------
	//1. Grid 객체 선언
	//  1) Grid가 다수인 경우 grid+숫자(순차증가) 
	//     형식으로 선언 
	//---------------------------------------
	var grid;
	var grid2;

	//---------------------------------------
	//2. Grid Colums 정보
	//  1) Grid가 다수인 경우 columns+숫자(순차증가) 
	//     형식으로 선언
	//---------------------------------------
	var columns = [ 
	{
		header : 'major_cd',
		name : 'major_cd',
		width : 'auto',
		filter : {
			type : 'text',
			showApplyBtn : true,
			showClearBtn : true
		},
		click : function() {
			alert();
		}
	},

	{
		header : 'major_nm',
		name : 'major_nm',
		width : 'auto',
		filter : {
			type : 'text',
			showApplyBtn : true,
			showClearBtn : true
		},
		editor : 'text',
		onAfterChange : function(data) {
			fnUpdate(grid.getRow(data.rowKey));
		}
	},

	{
		header : 'use_yn',
		name : 'use_yn',
		align : 'center',
		filter : 'select',
		width : 'auto',
		onAfterChange : function(data) {
			fnUpdate(grid.getRow(data.rowKey));
		},
		editor : {
			type : 'select',
			options : {
				listItems : [ {
					text : 'Y',
					value : 'Y'
				}, {
					text : 'N',
					value : 'N'
				} ]
			}
		}
	}, 
	{
        header : '',
        name : '',
        width : '500'
    }
	];

	var columns2 = [ 
	{
		header : 'major_cd',
		name : 'major_cd'
	},

	{
		header : 'major_nm',
		name : 'major_nm'
	},

	{
		header : 'minor_cd',
		name : 'minor_cd'
	},

	{
		header : 'minor_nm',
		name : 'minor_nm',
		editor : 'text',
		onAfterChange : function(data) {
			fnUpdate(grid.getRow(data.rowKey));
		}
	},

	{
		header : 'use_yn',
		name : 'use_yn',
		onAfterChange : function(data) {
			fnUpdate(grid.getRow(data.rowKey));
		},
		editor : {
			type : 'select',
			options : {
				listItems : [ {
					text : 'Y',
					value : 'Y'
				}, {
					text : 'N',
					value : 'N'
				} ]
			}
		}
	} ];
	/****************************************
	 * 초기화
	 ****************************************/
	$(function() {
		//select box 설정
		G_COMM.setComboBoxList("", "use_yn", {CODEGROUP:2});

		//그리드 호출
		grid = G_CMP.getGrid("grid", columns, '', 5);
		grid2 = G_CMP.getGrid("grid2", columns2, '', 5);
		
		//click 이벤트
	    G_CMP.event(grid,"click",function(data) {
	    	console.log(data);
	    	if(data.targetType == "cell" && data.columnName =="major_cd")
	    		fnSelect_Detail(grid.getRow(data.rowKey));
	    });

	});

	/****************************************
	 * 공통 함수
	 ****************************************/
	//---------------------------------------
	//1. 조회
	//  1) sendData 속성 중 controller, service는 사용자 정의 건이 있는 경우에만 추가
	//---------------------------------------
	function fnSelect() {
        /*Form Check*/  
        var frm = document.searchForm;
        if (!gfnValidate(frm))return;
        /*Form Check*/
        
        frm.mapper_id.value="griddouble.getList";
        
        var url = "/JOB/TEMPLATEGRIDDOUBLE/getList";
        var sendData= $("#searchForm").serialize();
        console.log(sendData);
        var sucessFunc = function(data) {
            G_CMP.setData( grid, data.result );
        };
         
        G_AJAX.ajaxCall(url , sendData , sucessFunc );
	}

	function fnSelect_Detail(data) {
		/*Form Check*/  
        var frm = document.editForm;
        frm.mapper_id.value="griddouble.getList2";
        frm.data.value= JSON.stringify(data);
        
        var url = "/JOB/TEMPLATEGRIDDOUBLE/getList";
        var sendData= $("#editForm").serialize();
        console.log(sendData);
        var sucessFunc = function(data) {
            G_CMP.setData( grid2, data.result );
        };
         
        G_AJAX.ajaxCall(url , sendData , sucessFunc );
	}

	function fnInsert(_pageNo) {
		document.getElementById("FormReg").reset();
		G_COMM.openLayerPop();
	}

	function fnUpdate(data) {
		var sendData = JSON.stringify({
			service_id : "u01",
			in_data : data,
			mapper_id : "cisa0010.u01",
			bind_comp : "firstGrid",
			service : "dwService",
			method : "update"
		});
		var url = "<c:url value='/dwController'/>";
		var sucessFunc = function(data) {
			fnSelect();
		}
		G_AJAX.ajaxCall(url, sendData, sucessFunc);
	}

	/****************************************
	 * 사용자 정의 함수
	 * -> 형식은 자유롭게 
	 * -> 단 fnAdd, fnGetList, fnSave, fnDel 중복 불가
	 ****************************************/
	// fired mouse event
	
	    
	//]]>
</script>
<!-- 수정,삭제 From -->
<form id="editForm" name="editForm">
    <input type="hidden" name="mapper_id" />
    <input type="hidden" name="data" /> <!-- 수정된 데이터 -->
</form>
<div id="searchArea" class="H50">
	<form id="searchForm" name="searchForm" class="searchForm"  style="border:1px solid #f7f7f7;>
	
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
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>상위코드명</th>
					<td><input type="text" name="major_nm" class="entrKey" ></td>
					<th>사용유무</th>
					<td><select name="use_yn" class="use_yn"></select></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<div id="gridArea" class="H90p">

	<!-- 그리드 TOP BOTTOM  -->
	<div class="H40p W100p" id="grid"></div>
	
	<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
	    <h1 class="h2"></h1>
	    <div class="btn-toolbar mb-2 mb-md-0">
            <div class="btn-group mr-2">
			    <button class="btn btn-sm btn-outline-secondary W80" type="button" onclick="fnOpenLayerPop();" style=" margin:5px;">추가</button>
			    <button class="btn btn-sm btn-outline-secondary W80" type="button" onclick="fnDelete();" style=" margin:5px;">삭제</button>
			    <button class="btn btn-sm btn-outline-secondary W80 xls" type="button" onclick="fnExcelDown();" style=" margin:5px;"></button>
            </div>
        </div>
	</div>
	  
	<div class="H40p W100p" id="grid2"></div>

	<!-- 그리드 LEFT RIGHT  -->
<!-- 	    <div class="H100p W40p fl" id="grid"></div> -->
<!-- 	    <div class="H100p W60p fr" id="grid2"></div> -->
</div>


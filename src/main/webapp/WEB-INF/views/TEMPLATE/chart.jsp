<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>

<div id="searchArea" class="H15p">
    <form id="SearchForm" name="SearchForm" class="searchForm">
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
                    <th>조회 데이터 갯수
                    </th>
                    <td><input type="text" id="data_limit" name="data_limit" class="intCheck checkNull entrKey" title="조회 데이터 갯수"></td>
                    <th>text</th>
                    <td><input type="text" id="test_text" name="test_text"></td>
                    <th>select</th>
                    <td><select id="test_select" name="test_select" class="select" ></select></td>
                    <th>date2</th>
                    <td>
                    <input type="text" size="10" class="W45p" name="startDay" id="startDay" title="시작일" /> 
                    ~
                    <input type="text" size="10" class="W45p" name="endDay" id="endDay" title="종료일" />
                    </td>
                </tr>
                <tr>
                    <th>date1</th>
                    <td>
                        <input type="text" size="10" class="W80p" name="test_date" id="test_date"/>
                    </td>
                    <th>select2</th>
                    <td>
                        <html:selectList name='select2' optionValues='|N|Y' optionNames='-전체-|아니요|예' defaultValue="" selectedValue='' title="" script='class="W95p"' />
                    </td>
                    <th>textarea</th>
                    <td colspan="3">
                        <textarea id="test_textarea" name="test_textarea" rows="1" cols="1"></textarea>
                    </td>
                </tr>
            </tbody>
        </table>
    </form>
</div>
<div id="gridArea" class="H85p">
    <div class="H100p W100p" id="grid1"></div>
</div>
<%-- 
<jsp:include page="CIS2130_registForm.jsp"></jsp:include> --%>

<script type="text/javascript">
//그리드 호출
var grid1 ;

//그리드 설정
var columns =
[
  {
    header: 'code_nm',
    name: 'code_nm',
    editor: 'text'
  },
  {
    header: 'code',
    name: 'code',
    editor: 'text',
  }
];
$(function () {
    //달력 셋팅 ->시작일~종료일 
    G_COMM.gfnInitDatePicker1Two(); 
    //달력 셋팅
    G_COMM.gfnSetDatePicker1Two($("#test_date"));
    
    //select box 설정
    G_COMM.setComboBoxList("A","test_select" ,{CODEGROUP:6}); 
    
    grid1 = G_CMP.getGrid("grid1",columns,"",10);
    

});
/*
 1. Service ID(select, insert, update, delete)
 2. Bind Data(Search Condition, Grid Data)
 3. Mapper ID
 4. Bind Component(Grid, Combo, Date, ...)
 5. Service Servlet and Method
 6. 
 */
function fnSelect() {
    /*Form Check*/  
    var frm = $("#SearchForm");
    if (!gfnValidate(frm))return;
    /*Form Check*/
    
    var url = "<c:url value='/dwController'/>";
    var sendData = JSON.stringify({
            service_id:"s01",
            in_data:$("#SearchForm").serializeObject(),
            mapper_id:"cisa2130.s01",
            bind_comp:"firstGrid",
            service:"dwService",
            method:"select"
    });
    var sucessFunc = function(data) {
        G_CMP.setData( grid1, data.out_data );
    };
     
    G_AJAX.ajaxCall(url , sendData , sucessFunc );
}
function fnInsert(_pageNo) {
    G_COMM.openLayerPop();
    
}
function fnUpdate(_pageNo) {
    G_COMM.gfnPopup("/empty/CIS/CIS1020","1000","800");

}
function fnDelete(_pageNo) {
    
    var sendData = JSON.stringify({
            service_id:"d01",
            in_data:[{a:"1",b:"4"},{a:"2",b:"5"}],
            mapper_id:"cisa2130.d01",
            bind_comp:"firstGrid",
            service:"dwService",
            method:"delete"
    });
    var url = "<c:url value='/dwController'/>";
    var sucessFunc = function(data) {
    }
    G_AJAX.ajaxCall(url , sendData , sucessFunc )
};
</script>

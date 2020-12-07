<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<script type="text/javascript">
$(function () {
	G_COMM.openLayerPop();
	var initParams = {
            search: ["#insertForm .popTable"]
	 };
	 G_INIT.init(initParams);
	 
});
function popInsert(){
	var frm = document.insertForm;
	if (!gfnValidate(frm))return;
	
	frm.mapper_id.value="CIS1040.insertMenu";
	var url = "/JOB/CIS1040/insert";
	
	var sendData = $("#insertForm").serialize();
	
 	var sucessFunc = function(data) {
 		G_COMM.popupClose();
 		fnSelect();
 	};
 	var errorFun = function(data){
 		alert("데이터를 확인해주세요.");
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc , errorFun );
};
//닫기
</script>

<!--Popup Start -->
<div class="layer">
 	<!-- 팝업뜰때 배경 -->
    <div class="mask"></div>
    
    <!--Popup content Start -->
    <div id="layerbox" class="layerpop W530 H450">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false;" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="insertForm" id="insertForm">
		     		
		     		<input type="hidden" name="mapper_id"/>
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col class="H20p" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>system_id</th>
		     					<td> 
		     						<select name="system_id" class="checkNull" select-type="-select-" title="시스템ID"></select>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>parent_menu_id</th>
		     					<td> 
		     						<input type="text" name="parent_menu_id" class="parent_menu_id" title="부모 메뉴 ID"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>menu_nm</th>
		     					<td> 
		     						<input type="text" name="menu_nm" class="checkNull" title="메뉴명" ></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>menu_id</th>
		     					<td> 
		     						<input type="text" name="menu_id" class="notHangulOnly checkNull" title="메뉴 ID"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>menu_url</th>
		     					<td> 
		     						<input type="text" name="menu_url" class="notHangulOnly checkNull" title="메뉴 URL" placeholder="System_Id/Menu_Id" ></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>disp_yn</th>
		     					<td> 
		     						<!-- <select name="disp_yn" class="checkNull" select-type="-select-" title="메뉴표시"></select> -->
		     						<input type="text" name="disp_yn" class="" value="Y"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>use_yn</th>
		     					<td> 
		     						<select name="use_yn" class="checkNull" select-type="-select-" title="사용여부" ></select>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>sort_no</th>
		     					<td> 
		     						<input type="text" name="sort_no" class="checkNull intCheck" title="정렬순서"></input>
		     					</td>
		     				</tr>
		     			</tbody>
		     		 </table>
		     		 <div class="AR MgT10 MgB50">
				        <button class="Tbtn W80" type="button" onclick="popInsert();return false">저장</button>
				     </div>
		     	</form>
		     	<!-- 등록 From -->  
        </div>
        </article>
    </div>
</div>
<!--Popup End -->


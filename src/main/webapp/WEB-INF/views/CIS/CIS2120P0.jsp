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
	
	frm.mapper_id.value="CIS2120.insert";
	var url = "/JOB/CIS2120/insert";
	
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
    <div id="layerbox" class="layerpop W530 H280">
        <article class="layerpop_area">
        <div class="title"> 등록 </div>
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
		     					<th><span class="iCheck"/>comp_cd</th>
		     					<td> 
		     						<select select-type='-All-' name="comp_cd" class="checkNull"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>mdl_cd</th>
		     					<td> 
		     						<input type="text" name="mdl_cd" class="checkNull"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>mdl_nm</th>
		     					<td> 
		     						<input type="text" name="mdl_nm" class="checkNull"></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>use_yn</th>
		     					<td> 
		     						<select select-type='-All-' name="use_yn" class="checkNull"></input>
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


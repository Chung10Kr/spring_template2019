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
	
	frm.mapper_id.value="CIS1090.insert";
	
	var url = "/JOB/CIS1090/insert";
	var sendData = $("#insertForm").serialize();
	
 	var sucessFunc = function(data) {
 		G_COMM.popupClose();
 		fnSelect();
 	};
 	 
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
};
</script>

<!--Popup Start -->
<div id="layer" class="layer">
 	<!-- 팝업뜰때 배경 -->
    <div class="mask"></div>
    
    <!--Popup content Start -->
    <div id="layerbox" class="layerpop W350 H270">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="insertForm" id="insertForm">
		     		
		     		<input type="hidden" name="mapper_id"/>
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col style="width: 20%;" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>role_cd</th>
		     					<td>
		     						<input type="text" name="role_cd" class="notHangulOnly checkNull" title="" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>role_nm</th>
		     					<td>
		     						<input type="text" name="role_nm" class="checkNull" title="" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>rmk</th>
		     					<td>
		     						<input type="text" name="rmk" class="" title="" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>use_flag</th>
		     					<td> 
		     						<select name="use_flag" class="checkNull" select-type="-select-" title=""></select>
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


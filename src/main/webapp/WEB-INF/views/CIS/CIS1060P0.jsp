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
	
	frm.mapper_id.value="CIS1060.insert";
	var url = "/CIS/CIS1060/insert";
	
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
    <div id="layerbox" class="layerpop W700 H410">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false;" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="insertForm" id="insertForm">
		     		
		     		<input type="hidden" name="mapper_id"/>
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col style="width: 15%;" />
		     				<col style="width: 35%;" />
		     				<col style="width: 15%;" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     					<tr>
		     						<th><span class="iCheck"/>user_id</th>
		     						<td>
		     							<input type="text" name="user_id" class="checkNull" title=""/>
		     						</td>
		     						<th><span class="iCheck"/>user_pwd</th>
		     						<td>
		     							<input type="text" name="user_pwd" class="checkNull" title=""/>
		     						</td>
		     						
		     					</tr>
		     					
		     					<tr>
		     						<th><span class="iCheck"/>biz_comp_cd</th>
		     						<td>
		     							<input type="text" name="emp_no" class="checkNull" title=""/>
		     						</td>
		     						<th><span class="iCheck"/>user_nm</th>
		     						<td>
		     							<input type="text" name="user_nm" class="checkNull" title=""/>
		     						</td>
		     					</tr>
		     					<tr>
		     						<th><span class="iCheck"/>biz_comp_fg</th>
		     						<td>
		     							<select select-type="-select-" name="biz_comp_fg" class="checkNull" title=""/>
		     						</td>
		     						<th><span class="iCheck"/>comp_cd</th>
		     						<td>
		     							<select select-type="-select-" name="comp_cd" class="checkNull" title=""/>
		     						</td>
		     					</tr>
		     					<tr>
		     						<th>biz_comp_cd</th>
		     						<td>
		     							<select select-type="-select-" name="biz_comp_cd" class="" title=""/>
		     						</td>
		     						
		     						<th>plant_cd</th>
		     						<td>
		     							<select select-type="-select-" name="plant_cd" class="" title=""/>
		     						</td>
		     					</tr>
		     					<tr>
		     						<th>wb_cd</th>
		     						<td>
		     							<select select-type="-select-" name="wb_cd" class="" title=""/>
		     						</td>
		     						<th><span class="iCheck"/>use_yn</th>
		     						<td>
		     							<select select-type="-select-" name="use_yn" class="checkNull" title=""/>
		     						</td>
		     					</tr>
		     					<tr>
		     						<th>pm_id</th>
		     						<td>
		     							<input type="text" name="pm_id" class="" title=""/>
		     						</td>
		     						<th>pm_pwd</th>
		     						<td>
		     							<input type="text" name="pm_pwd" class="" title=""/>
		     						</td>
		     					</tr>
		     					<tr>
		     						<th>dept_cd</th>
		     						<td>
		     							<select select-type="-select-" name="dept_cd" class="" title=""/>
		     						</td>
		     					    <th>rmk</th>
		     						<td>
		     							<input type="text" name="rmk" class="" title=""/>
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


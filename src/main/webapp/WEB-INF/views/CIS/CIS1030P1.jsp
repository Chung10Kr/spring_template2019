<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<script type="text/javascript">
$(function () {
	G_COMM.openLayerPop();
	var initParams = {
            search: ["#popForm .popTable"]
	 };
	 G_INIT.init(initParams);
});
function popInsert(){
	var frm = document.popForm;
	if (!gfnValidate(frm))return;
	
	frm.mapper_id.value="CIS1030.insertMinor";
	var url = "/JOB/CIS1030/insert";
	var sendData = $("#popForm").serialize();
	
 	var sucessFunc = function(data) {
 		G_COMM.popupClose();
 		fnSelect2();
 	};
	var errorFun = function(data){
 		alert("데이터를 확인해주세요.");
 	};
 	G_AJAX.ajaxCall(url , sendData , sucessFunc , errorFun );
};

</script>

<!--Popup Start -->
<div class="layer">
 	<!-- 팝업뜰때 배경 -->
    <div class="mask"></div>
    
    <!--Popup content Start -->
    <div id="layerbox" class="layerpop W530 H360">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false;" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="popForm" id="popForm">
		     		
		     		<input type="hidden" name="mapper_id"/> <!-- mapper_id -->
		     		<input type="hidden" name="use_yn" value="Y"/> <!-- 사용여부 -->
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col class="H20p" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th>system_id</th>
		     					<td> 
		     						<input name="system_id" class="checkNull" readonly="readonly" title="시스템ID"/>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>major_cd</th>
		     					<td>
		     						<input type="text" name="major_cd" class="checkNull" readonly="readonly" title="상위코드" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>minor_cd</th>
		     					<td>
		     						<input type="text" name="minor_cd" class="notHangulOnly checkNull" title="코드 값" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>minor_nm</th>
		     					<td>
		     						<input type="text" name="minor_nm" class="checkNull" title="코드 명" maxlength="50" />
		     					</td>
		     				</tr>
		     				
		     				<tr>
		     					<th><span class="iCheck"/>sort_no</th>
		     					<td>
		     						<input type="text" name="sort_no" class="checkNull intCheck" title="정렬순서" maxlength="50" />
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>rmk</th>
		     					<td>
		     						<input type="text" name="rmk" class="" title="비고" maxlength="50" />
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


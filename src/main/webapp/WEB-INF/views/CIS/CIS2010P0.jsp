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
	
	frm.mapper_id.value="CIS2010.insert";
	var url = "/JOB/CIS2010/insert";
	
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
    <div id="layerbox" class="layerpop W530 H440">
        <article class="layerpop_area">
        <div class="title"> 회사관리 등록 </div>
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
		     						<input type="text" name="comp_cd" class="notHangulOnly checkNull" title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>comp_nm</th>
		     					<td> 
		     						<input type="text" name="comp_nm" class="checkNull" title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>addr</th>
		     					<td> 
		     						<input type="text" name="addr"title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>corp_regt_num</th>
		     					<td> 
		     						<input type="text" name="corp_regt_num"title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>ceo_nm</th>
		     					<td> 
		     						<input type="text" name="ceo_nm"title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>biz_typ</th>
		     					<td> 
		     						<input type="text" name="biz_typ"title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>biz_kind</th>
		     					<td> 
		     						<input type="text" name="biz_kind"title=""></input>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>rmk</th>
		     					<td> 
		     						<input type="text" name="rmk"title=""></input>
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


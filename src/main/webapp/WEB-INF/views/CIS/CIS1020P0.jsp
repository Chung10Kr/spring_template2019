<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<script type="text/javascript">
$(function () {
	G_COMM.setPopColumns(columns1);
	
	var initParams = {
            search: ["#insertForm .popTable"]
	 };
	 G_INIT.init(initParams);
	 G_COMM.gfnSetDatePicker1Two($("#birth"));
});
function popInsert(){
	
	var frm = document.insertForm;
	if (!gfnValidate(frm))return;
	
	frm.mapper_id.value="CIS1020.insert";
	
	var url = "/JOB/CIS2130/insert";
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
    <div id="layerbox" class="layerpop W300">
        <article class="layerpop_area">
        <div class="title"> 등록 </div>
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
		     			  <!-- 
		     				<tr>
		     					<th>name</th>
		     					<td> <input type="text" name="name" class="checkNull" title="이름" maxlength="10" />  </td>
		     				</tr>
		     				<tr>
		     					<th>age</th>
		     					<td> <input type="text" name="age" class="checkNull intCheck" title="나이" maxlength="3" />  </td>
		     				</tr>
		     				<tr>
		     					<th>birth</th>
		     					<td> <input id="birth" type="text" size="10" class="W90p checkNull" readonly="readonly" name="birth" title="생일" /> </td>
		     				</tr>
		     				<tr>
		     					<th>gender</th>
		     					<td><select name="gender" class="checkNull" title="성별" select-type="-select-" ></select></td>
		     				</tr>
		     				-->
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


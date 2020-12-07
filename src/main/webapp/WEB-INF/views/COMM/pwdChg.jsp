<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script>
$(function () {
	var initParams = {
			   search: ["#updateForm .popTable"]
	};
	G_INIT.init(initParams);
});
//팝업 종료
function closePop(){
	window.close();
}
function popUpdate(){
	var frm = document.updateForm;
	
	if (!gfnValidate(frm))return;
	
	var url = "/USR/MEMBER/updatePwd";
	var sendData = $("#updateForm").serialize();
	
 	var sucessFunc = function(data) {
 		alert("테마 변경시 다시 로그인 해주세요.");
 		closePop();
 	};
 	 
 	G_AJAX.ajaxCall(url , sendData , sucessFunc );
};
</script>

 <!--Popup content Start -->
    <div id="layerbox" class="layerpop W100P H221">
        <article class="layerpop_area">
        <div class="title"> 회원 정보 변경 </div>
        <a href="" onclick="closePop();return false" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="updateForm" id="updateForm">
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col class="H20p" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>theme</th>
		     					<td> 
		     						<select name="cis_theme" class="checkNull" 
		     						 selected-data='<c:out value="${result.theme}"/>'
		     						 select-type="-SELECT-" title="테마"></select>
		     						
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>user_pwd</th>
		     					<td>
		     						<input type="text" name="user_pwd" class="" title="비밀번호" maxlength="50" />
		     					</td>
		     				</tr>
		     			</tbody>
		     		 </table>
		     		 <div class="AR MgT10 MgB20">
				        <button class="Tbtn W80 fc" type="button" onclick="popUpdate();return false">저장</button>
				     </div>
		     	</form>
		     	<!-- 등록 From -->  
        </div>
        
	



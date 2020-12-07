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
	uploadFile();
	
	var url = "/USR/NOTICE/insert"; 
	var params= $("#insertForm").serialize();
	
    var sucessFunc = function(data) {
    	G_COMM.popupClose();
    	fnSelect();
    };
    G_AJAX.ajaxCall(url, params, sucessFunc);
};
//닫기
</script>

<!--Popup Start -->
<div class="layer">
 	<!-- 팝업뜰때 배경 -->
    <div class="mask"></div>
    
    <!--Popup content Start -->
    <div id="layerbox" class="layerpop W530 H640">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false;" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="insertForm" id="insertForm">
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col style="width: 15%;" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>title</th>
		     					<td><input type="text" class="checkNull" maxlength="30" name="title"></td>
		     				</tr>
		     				<tr class="H150">
		     					<th>첨부파일 </th>
		     					<td class="VT">
							        <input type="hidden" id="fileSeq" name="attach_file_no"> 
							        <div class="fileTable W100p H50">
							        	<div class="dropZone"> Drag & Drop</div>
							            <div class="fileZone scroll_auto H100"></div>
							        </div>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>content</th>
		     					<td>
		     					 <textarea rows="20" cols="20" class="checkNull" title="내용" name="content"></textarea> 
		     					</td>
		     				</tr>
		     			</tbody>
		     		 </table>
		     		 <div class="AR MgT0 MgB0">
		     		    <button class="${theme}_ChBtn Tbtn W80" type="button" onclick="popInsert();return false">저장</button>
				     </div>
		     	</form>
		     	<!-- 등록 From -->  
        </div>
        </article>
    </div>
</div>
<!--Popup End -->


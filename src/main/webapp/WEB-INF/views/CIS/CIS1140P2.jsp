<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<script type="text/javascript">
$(function () {
	G_COMM.openLayerPop();
	var initParams = {
            search: ["#updateForm .popTable"]
	 };
	 G_INIT.init(initParams);
});
function popUpdate(){
	uploadFile();
	/*기존의 File에 Add Start*/
	var new_seqs= $("#fileSeq").val();
	var basic_seq=[];
	for(var i=0; i<$(".basic_seq").length ; i++){
		basic_seq.push($(".basic_seq:eq("+i+")").val());
	}
	$("#basicSeq").val( basic_seq);
	$("#fileSeq").val(new_seqs+","+$("#basicSeq").val());
	/*기존의 File에 Add End*/
	
	
	var url = "/USR/NOTICE/update"; 
    var params= $("#updateForm").serialize();
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
		     	<form name="updateForm" id="updateForm">
		     		<input type="hidden" name="seq" value="<c:out value="${result.seq}"/>"/>
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col style="width: 15%;" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>title</th>
		     					<td> <input type="text" name="title" class="checkNull" title="제목" maxlength="50" value="<c:out value="${result.title}"/>" />  </td>
		     				</tr>
		     				<tr class="H150">
		     					<th>첨부파일 </th>
		     					<td class="VT">
							        <input type="hidden" id="fileSeq" name="attach_file_no">
							        <input type="hidden" id="basicSeq" name="basicSeq"> <!-- 변경시 필요 --> 
							        <div class="fileTable W100p H50">
							        	<div class="dropZone"> Drag & Drop</div>
							            <div class="fileZone scroll_auto H100">
							            	<c:forEach var="eo" items="${fileResult}" varStatus="status">
			     								<div><c:out value="${eo.real_file_name}"/> &nbsp;
			     									<input type="hidden" class="basic_seq" value='<c:out value="${eo.id}"/>'>
			     								 	<a href='' onclick="deleteFileList(this);return false;" class=>삭제</a>
			     								</div>
											</c:forEach>
							            </div>
							        </div>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>content</th>
		     					<td>
		     					 <textarea rows="20" cols="20" class="checkNull" title="내용" name="content"><c:out value="${result.content}"/></textarea> 
		     					</td>
		     				</tr>
		     			</tbody>
		     		 </table>
		     		 <div class="AR MgT0 MgB0">
		     		    <button class="${theme}_ChBtn Tbtn W80" type="button" onclick="popUpdate();return false">저장</button>
				     </div>
		     	</form>
		     	<!-- 등록 From -->  
        </div>
        </article>
    </div>
</div>
<!--Popup End -->


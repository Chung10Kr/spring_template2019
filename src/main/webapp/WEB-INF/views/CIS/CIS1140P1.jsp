<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<script type="text/javascript">
$(function () {
	G_COMM.openLayerPop();
	var initParams = {search: ["#viewForm .popTable"] };
	G_INIT.init(initParams);
});
function popUpdate(){
	//조회후 update창 열기
 	var url = "/USR/NOTICE/updatePop"; 
 	var params= $("#viewForm").serialize();
    var sucessFunc = function(data) {
        $("#layerPopArea").html("");
        $("#layerPopArea").html(data);
    };
    G_AJAX.ajaxCallHtml(url, params, sucessFunc);
};
//닫기
</script>

<!--Popup Start -->
<div class="layer">
 	<!-- 팝업뜰때 배경 -->
    <div class="mask"></div>
    
    <!--Popup content Start -->
    <div id="layerbox" class="layerpop W530 H620">
        <article class="layerpop_area">
        <div class="title">  등록 </div>
        <a href="" onclick="G_COMM.popupClose();return false;" class="W40 layerpop_close" id="layerbox_close">닫기</a>
        <div class="content">
		        <!-- 등록 From -->
		     	<form name="viewForm" id="viewForm">
		     		<input type="hidden" name="seq" value="<c:out value="${result.seq}"/>"/>
		     		
		     		<table class="popTable">
		     			<colgroup>
		     				<col style="width: 15%;" />
		     				<col style="width: 35%;" />
		     				<col style="width: 15%;" />
		     				<col />
		     			</colgroup>
		     			<tbody>
		     				<tr>
		     					<th><span class="iCheck"/>title</th>
		     					<td colspan="3"> 
		     					<c:out value="${result.title}"/>  
		     					</td>
		     				</tr>
		     				<tr>
		     					<th>등록자</th>
		     					<td><c:out value="${result.creater}"/></td>
		     					<th>등록일자</th>
		     					<td><c:out value="${result.createdate}"/></td>
		     				</tr>
		     				<tr>
		     					<th>첨부파일</th>
		     					<td colspan="3" class="H80 scroll_auto">
		     						<div class="scroll_auto H80 ">
			     						<c:forEach var="eo" items="${fileResult}" varStatus="status">
			     								<a href="" onclick="fileDown('<c:out value="${eo.id}"/>');return false;"> <c:out value="${eo.real_file_name}"/> </a></br>
										</c:forEach>
									</div>
		     					</td>
		     				</tr>
		     				<tr>
		     					<th><span class="iCheck"/>content</th>
		     					<td colspan="3" class="H350">
		     					 <div class="H100p W100p scroll_auto"><c:out value="${result.content}"/></div>
		     					</td>
		     				</tr>
		     			</tbody>
		     		 </table>
		     		 <div class="AR MgT0 MgB0">
				        <button class="${theme}_ChBtn Tbtn W80" type="button" onclick="fnReport('/USR/REPORT/notice' , 'viewForm');return false">리포트</button>
				        
				        <c:if test="${result.updauth eq 'Y' }">
				        	<button class="${theme}_ChBtn Tbtn W80" type="button" onclick="popUpdate();return false">변경</button>
				        </c:if>
				        
				     </div>
		     	</form>
		     	<!-- 등록 From -->  
        </div>
        </article>
    </div>
</div>
<!--Popup End -->


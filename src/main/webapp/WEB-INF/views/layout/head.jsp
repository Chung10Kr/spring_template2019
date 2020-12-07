<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>

<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<script type="text/javascript" src="<c:url value='/resources/js/etc/jquery-1.11.3.min.js'/>"></script>
 
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.css">

<script type="text/javascript" src="https://cdn.rawgit.com/ax5ui/ax5ui-kernel/master/dist/ax5ui.all.min.js"></script> 

<!-- 설계문서 작업(화면 캡쳐)을 위한 한시적 운영 start-->
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
<!-- 설계문서 작업(화면 캡쳐)을 위한 한시적 운영 end-->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/com/common.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/com/BasicSet.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/com/print.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/theme/navy.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/theme/dark.css" />"/>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/jquery-ui-1.11.4.custom/jquery-ui.css" />"/>

<script type="text/javascript" src="<c:url value='/resources/js/etc/cmnReady.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/etc/xlsx.min.js'/>"></script>

<script type="text/javascript" src="<c:url value='/resources/js/etc/BrowserPrint.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/etc/barcodePrint.js'/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui-1.11.4.custom/jquery-ui.js" />"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/jquery-barcode.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/html2canvas.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/jspdf.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/jquery.blockUI.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/jquery.fileDownload.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/jquery.tablefix_1.0.0.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/file.js"/>"></script>

<!-- Toast Ui Start--> 
 
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/toast/css/tui-date-picker.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/toast/css/tui-grid.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/toast/css/checkbox.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/toast/css/tui-pagination.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/toast/css/tui-time-picker.css" />"/>
<script src="/resources/js/toast/js/tui-code-snippet.js"></script>
<script src="/resources/js/toast/js/tui-time-picker.js"></script>
<script src="/resources/js/toast/js/tui-date-picker.js"></script>
<script src="/resources/js/toast/js/preact.js"></script>
<script src="/resources/js/toast/js/tui-pagination.js"></script>
<script src="/resources/js/toast/js/tui-grid.js"></script>
<!-- Toast Ui End-->

<!-- fullcalendar Start -->
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/etc/fullcal/Core_main.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/etc/fullcal/Day_main.css" />"/>
<script src="/resources/js/etc/fullcal/Core_main.js"></script>
<script src="/resources/js/etc/fullcal/Day_main.js"></script>
<script src="/resources/js/etc/fullcal/Inter_main.js"></script>

<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/etc/fullcal/time_main.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/etc/fullcal/rest_main.css" />"/>
<script src="/resources/js/etc/fullcal/time_main.js"></script>
<script src="/resources/js/etc/fullcal/resc_main.js"></script>
<script src="/resources/js/etc/fullcal/rest_main.js"></script>
<!-- fullcalendar End -->


<script type="text/javascript" src="<c:url value='/resources/js/etc/jquery.serialize-object.min.js'/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/etc/class.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/hitec/ajax.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/hitec/cmp.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/hitec/comm.js"/>"></script> 
<script type="text/javascript" src="<c:url value="/resources/js/hitec/init.js"/>"></script>

<script type="text/javascript" src="<c:url value="/resources/js/shortcut/jquery.shortcut-0.1.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/js/shortcut/shortcut.js"/>"></script>


<title>세아전자</title>


<!-- 
Url 직접 변경시
1. 같은 대 메뉴상에서 변경시 -> MenuController.java
2. 다른 메뉴로 변경시 ->head.jsp
-->
<%
	String strReferer = request.getHeader("referer");
	if(strReferer == null){
%>
	<script>
		alert("직접 URL 변경은 제한됩니다.");
		document.location.href="/NVWR/COMM/main";
	</script>	
<%
	};
%>

    

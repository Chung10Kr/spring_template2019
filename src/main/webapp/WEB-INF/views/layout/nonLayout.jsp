<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<jsp:include page="head.jsp"></jsp:include>
<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false' >

<div class="H100p W100p ${theme}_Body" id="content_wrap">
	<tiles:insertAttribute name="body"/>
</div>
					
</body>
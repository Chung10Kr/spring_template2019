<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>


<jsp:include page="head.jsp"></jsp:include>
<body oncontextmenu='return false' onselectstart='return false' ondragstart='return false'>

	<div id="wrap" class="H100p">
		<div id="header" class="H60 W100p ${theme}_Top">
			<tiles:insertAttribute name="header"/>
		</div>
		<div id="container" class="W100p">
			<div id="nav" class="H100p W15p fl scrolly_auto scrollx_auto ${theme}_Nav">
			 	<tiles:insertAttribute name="nav" />
			</div>
			
			<div id="content" class="H100p W85p fr ${theme}_content">
				<div id="content_header" class="H50 W100p">
		   			<tiles:insertAttribute name="content_header"/>
				</div>
				<div id="content_body" class="W100p">
					<div class="H100p W100p ${theme}_Body" id="content_wrap">
			 			<tiles:insertAttribute name="body"/>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
    
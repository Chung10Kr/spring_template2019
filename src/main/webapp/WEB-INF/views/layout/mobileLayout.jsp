<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>



<link rel="stylesheet" type="text/css" href="<c:url value="/resources/mobile/css/common.css" />"/>
<link rel="stylesheet" type="text/css" href="<c:url value="/resources/mobile/css/style.css" />"/>

<jsp:include page="head.jsp"></jsp:include>



<body>

<div class="container_main bottm_interval">
	<div class="content">
		<main id="main">
			<div class="top opacity_div"></div>
			<div class="container">
				<div class="content">
					<div class="title_area">
						<div class="title">
							<a href="/MOBILE/MAIN/main">
							<p class="a_noLine">하이텍 정보 시스템</p>
							<img class="logo" src="/resources/mobile/img/hitec.PNG" alt="Hitec">
							</a>
						</div>
					</div>
					<tiles:insertAttribute name="body"/>
				</div>
			</div>
		</main>
	</div>
</div>
<div class="bottom_nav">
	
</div>
</body>
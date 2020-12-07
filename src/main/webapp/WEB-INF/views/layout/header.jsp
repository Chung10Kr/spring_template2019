<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>

<!-- 설계문서 작업(화면 캡쳐)을 위한 한시적 운영 Start-->
<a id="target" style="display: none"></a>
 <nav class="navbar navbar-expand-sm W100p">
  <a class="AC navbar-brand ${theme}_Ttitle W14p" href="/NVWR/COMM/main"> SEAH </a>
  <div class="collapse navbar-collapse W85p" id="navbarsExample03">
    <ul class="navbar-nav mr-auto">
    <c:forEach items="${TopMenuList}" var="SO" varStatus="st">
    	<c:set value="" var="classNm"/>
    	<c:if test="${LeftMenuList[0].system_id eq  SO.system_id}">
	    		<c:set value="${theme}_onTopMenu" var="classNm"/>
	    </c:if>
    	<li class="nav-item">
        	<a class="nav-link ${theme}_Tmenu ${classNm} " href="/USR/TMENU/<c:out value="${SO.system_id}"/>"> 
        		<c:out value="${SO.system_nm}"/>
        	</a>
      	</li>
    </c:forEach>
    </ul>
    <ul class="fr listnone navbar-nav">
    	<li class="AC ${theme}_Thello">
    		<b class="FW700">
    		 <a href="" class="${theme}_Thello a_noLine" onclick="G_COMM.gfnPopup('/USR/MEMBER/pwdChg', 430, 220, 1, 'pwdChgPopup');return false;">
    		 	<c:out value="${memberMap.user_nm}" />
    		 </a>
    		  </b> 님 반갑습니다.
    	</li>
    </ul>
    
    
    <html:buttonAuth gubun="cap" script="fnCapture('content','${MENU_NM}'); return false;" title="Capture" classNm="dis_no textClassBtn MgL13 ${theme}_Tbtn btn"/>
 	<script type="text/javascript">
 	$(document).ready(function(){
		var url = window.location.host;
		if(url.indexOf("localhost")!=-1){
			$(".textClassBtn").css("display","block");
		 };
 	})
 	</script>
    <button class="MgL13 ${theme}_Tbtn btn" id="logOut" onclick="G_COMM.logOut();return false;">Logout</button>
  </div>
</nav>





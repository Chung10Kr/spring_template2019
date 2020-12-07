<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script>
$(function () {
	
	 
	 /*left 초기 진입 첫메뉴 세팅*/
	 if($('.subLi').hasClass("${theme}_menuOnC")){
		$(".subLi.${theme}_menuOnC").parents(".topUl").children("span").siblings(".subLi").slideDown(500);
		$(".subLi.${theme}_menuOnC").parents(".topUl").addClass("${theme}_menuOnT");
		
	 };
	
	 $(".topUl>span").click(function(){
         var submenu = $(this).siblings(".subLi");
         
         // submenu 가 화면상에 보일때는 위로 보드랍게 접고 아니면 아래로 부드럽게 펼치기
         if( submenu.is(":visible") ){
             submenu.slideUp();
         }else{
             submenu.slideDown();
         }

     });
	 
	 theme = '${theme}'; //cmp.js 참조
});
</script>

<style>
.topUl span{cursor:pointer;}
.topUl .hide{display:none;}
</style>

  <div class="W100p nav">
        	<ul class="topUl ${theme}_ui W100p">
        	 <span class="fs30 ${theme}_Ntitle W100p FW1000"><c:out value="${LeftMenuList[0].menu_nm}"/></span> 
        		    <c:set var="pre_depth" value="0"/>
	    	    	<c:set var="depth" value="0"/>
			     <c:forEach items="${LeftMenuList}" var="SO" varStatus="st">
	    	    	<c:set var="pre_depth" value="${depth}"/>
	    	    	<c:set var="depth" value="${SO.menu_depth}"/>
	    	    	<c:set var="gap_depth" value="${pre_depth - depth}"/>
	    	    	<c:if test="${SO.system_id eq SO.parent_menu_id}">
		    	    	<c:if test="${gap_depth > 0}">
		    	    		<c:forEach var="depth_index" begin="1" end="${gap_depth}">
		    	    			</ul></il>
		    	    		</c:forEach>
		    	    	</c:if>
		    	    	  <li class="subLi hide W100p"><ul class="topUl ${theme}_ui">
		    	    		<span class=" ${theme}_Ntab W100p FW900 fs20"><c:out value="${SO.menu_nm}"/></span>
	    	    	</c:if>
	    	    	
	    	    	<c:if test="${ (SO.system_id ne SO.parent_menu_id) and (SO.parent_menu_id ne 'SYSTEM_ID') }">
	    	    	 	<c:set var="classNm" value=""/>
		    	    	<c:if test="${SO.menu_seq eq MENU_SEQ }"> 
	    	    			<c:set var="classNm" value="${theme}_menuOnC"/>   	 
	    	    		</c:if>
	    	    		<li class="W100p subLi hide ${classNm}">
	    	    			<a class="a_noLine W100p fs15 ${theme}_Nmenu FW700" href="<c:out value="${SO.menuurl}"/>" onload="">
		          				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${SO.menu_nm}"/>
		          			</a>
	    	    		</li>
	    	    		<c:set var="endYn" value="end"/>	
	    	    	</c:if>
	    	    		
	    	    	<c:if test="${st.last}" >
	    	    		<c:if test="${gap_depth > 0}">
	    	    			<c:forEach var="depth_index" begin="1" end="${gap_depth}">
		    	    			</ul></il>
		    	    		</c:forEach>
	    	    		</c:if>
    	    		</c:if>	
	    	    	
						    	    	 
			    </c:forEach>
        	</ul>  
  </div>
  
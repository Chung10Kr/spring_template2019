<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>



<div class="d-flex justify-content-between">
    <h1 class="h2 ${theme}_ChTitle"><c:out value="${MENU_NM}"/></h1>
    <div class="btn-toolbar mb-2 mb-md-0">
      <div class="btn-group mr-2 ${theme}_ChArea">
      	<html:buttonAuth gubun="add" script="fnOpenLayerPop();return false;" title="등록" classNm="${theme}_ChBtn W80"/>
      	<html:buttonAuth gubun="del" script="fnDelete();return false;" title="삭제" classNm="${theme}_ChBtn W80"/>
      	<html:buttonAuth gubun="read" script="fnSelect();return false;" title="조회" classNm="${theme}_ChBtn W80"/>
      	<html:buttonAuth gubun="excel" script="fnExcelDown();return false;" title="Excel" classNm="${theme}_ChBtn W80 ${theme}_xls"/>
      </div>
    </div>
</div>




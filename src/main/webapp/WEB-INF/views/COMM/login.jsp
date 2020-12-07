<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script>
$(function () {
	$("#passwd").keypress(function(e) {
		if('13' == e.keyCode){
			ckLogin();
		};
	});	
});


//로그인
function ckLogin() {
	
	if (G_COMM.gfnIdVal("userId")=="") {
      alert("아이디를 입력하세요");
      $("#userId").focus();
      return;
	};
	if (G_COMM.gfnIdVal("passwd")=="") {
	     alert("비밀번호를 입력하세요");
	     $("#passwd").focus();
	     return;
	};
	var frm = document.loginFrm;
	frm.action="/USR/LOGIN/check" ;
	frm.submit();
};

function ckMLogin() {
	
	if (G_COMM.gfnIdVal("userId")=="") {
      alert("아이디를 입력하세요");
      $("#userId").focus();
      return;
	};
	if (G_COMM.gfnIdVal("passwd")=="") {
	     alert("비밀번호를 입력하세요");
	     $("#passwd").focus();
	     return;
	};
	var frm = document.loginFrm;
	frm.action="/MOBILE/LOGIN/check" ;
	frm.submit();
};

window.onload = setup;
//barcode Test
</script>

<a href="" class="btn_login" title="TEST" onclick="ckMLogin();return false;">TEST</a>
<select id="selected_device" onchange='onDeviceSelected(this);return false;'></select> 
<input type="text" name="write_text" id="write_text" value=" ^XA ^MMT^PW719^LL0400^LS0^FS ^MMT^PW740^LL0400^LS-4^LT24^FS  ^SEE:UHANGUL.DAT^FS  ^CW1,E:KFONT3.FNT^CI28^FS  ^FT30,50^A1N,40,35^FH^FD생 산 전 표^FS  ^FT590,50^A1N,35,30^FH^FDAAA^FS ^FT45,105^A1N,30,30^FH^FD차 종^FS ^FT45,160^A1N,30,30^FH^FD품 번^FS ^FT45,215^A1N,30,30^FH^FD품 명^FS ^FT45,270^A1N,30,30^FH^FD수 량^FS ^FT320,105^A1N,30,30^FH^FD작업장^FS ^FT396,270^A1N,30,30^FH^FD생산일자^FS ^FT525,215^A1N,30,30^FH^FD합격^FS ^FT150,105^A1N,35,30^FH^FDAAA^FS  ^FT150,160^A1N,35,30^FH^FDAAA^FS  ^FT150,215^A1N,35,30^FH^FDAAA^FS  ^FT150,270^A1N,35,30^FH^FDAAA^FS  ^FT430,105^A1N,35,25^FH^FD  ^FS ^FT615,160^A1N,35,30^FH^FD ^FS ^FT530,270^A1N,35,30^FH^FDAAA^FS ^FT605,215^A1N,30,25^FH^FDAAA^FS ^BY2,2,67^FT80,361^BCN,,N,N ^FH^FD || C1.BAR_CD || ^FS ^FT80,385^A1N,25,25^FH^FDAAA^FS ^FO22,8^GB714,0,3^FS  ^FO22,394^GB714,0,3^FS ^FO22,8^GB0,386,3^FS ^FO732,8^GB0,386,3^FS ^FO30,287^GB688,0,3^FS ^FO30,231^GB688,0,2^FS ^FO30,175^GB688,0,3^FS ^FO394,231^GB0,56,3^FS ^FO518,175^GB0,112,3^FS  ^FO590,118^GB0,112,3^FS  ^FO414,64^GB0,57,3^FS    ^FO317,64^GB0,57,3^FS    ^FO715,64^GB0,226,3^FS   ^FO134,64^GB0,226,3^FS   ^FO30,64^GB0,226,3^FS    ^FO30,119^GB688,0,3^FS   ^FO30,64^GB688,0,3^FS    ^PQ1,0,1,Y  ^XZ ">
<input type="button" value="Write" onclick="writeToSelectedPrinter(document.getElementById('write_text').value)"><br/><br/>



<input type="hidden" name="resultMessage" id="resultMessage" value="<c:out value="${resultMessage}"/>"/>
<form name="loginFrm" id="loginFrm" method="post">
    <div id="login">
    	<div class="loginCont">
        	<dl class="loginForm">
        		<dd class="AC"><img src="/resources/img/com/seah.png"/></dd>
            	<dd><input type="text" placeholder="아이디" id="userId" name="userId" value="admin"/></dd>
                <dd><input type="password" placeholder="비밀번호" id="passwd" name="passwd" value="4"/></dd>
                <dd class="MgT20"><a href="" class="btn_login" title="로그인" onclick="ckLogin();return false;">로그인</a></dd>
            </dl>
        </div>
    </div>
</form>

    
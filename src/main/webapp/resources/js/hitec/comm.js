/**
 * 기타
 * 
 * 1.콤보 생성
 * 2.달력
 * 3.기타 util
 * 
 */
$(document).ready(function(){
	
	//onKeydown
	/*document.onkeydown=disablebutton;*/
	//onMouseDown
    /*document.onmousedown=disableclick;*/
    
    
});
function disableclick(e){
	
	//오른쪽 클릭
    if (e.button==2) {
    	alert("오른족 클릭은 제한 됩니다.");
        return false;
    };
};

function disablebutton(e){
	var url = window.location.host;
	
	/* F12 */
	if ( e.keyCode == 123 ) {
		if(url.indexOf("localhost")==-1){
			alert("F12는 제한 됩니다.");
			//localhost 접속 아닐경우
			e.preventDefault();
			e.returnValue = false;
		 };
    };
	
};



var G_COMM = {
		/**
		 * 함수 설명 : 코드성 콤보박스 생성 In Grid
		 * @param type  :  S:선택, A:전체,null:없음, 그외에는 표시값을 표시
		 * @param id  :  id
		 * @param params  :  파라미터
		 * @param async  :  동기/비동기 여부
		 * @param selVal  :  초기값 세팅 -  필요할 경우 사용
		 *  형식
		 *  [
				{ text: 'Man', value: 'm' },
				{ text: 'Woman', value: 'w' }
			]
		 */
		setComboGridList:function(param) {				
			  var url = "/UTL/CODE/getList";
			  var params = param;
			  
			  var str = [];
			  var sucessFunc = function(data) {
				  var list = data.list;
				  for (var i = 0; i < list.length; i++) {
					  str.push( { text: list[i].code_nm , value: list[i].code } );
				  };
			  };
			  G_AJAX.ajaxCall(url, params, sucessFunc, "", false);
			  
			  return str;
		},
		/**
		 * 함수 설명 : 코드성 콤보박스 생성
		 * @param type  :  S:선택, A:전체,null:없음, 그외에는 표시값을 표시
		 * @param id  :  id
		 * @param params  :  파라미터
		 * @param async  :  동기/비동기 여부
		 * @param selVal  :  초기값 세팅 -  필요할 경우 사용
		 */
		setComboBoxList:function(type, id, param, async, selVal) {
			var obj  = $("."+id);
			
				obj.html("");
				
			  var url = "/UTL/CODE/getList";
			  var params = param;
			  
			  var sucessFunc = function(data) {
			    var list = data.list;
			    if(type == "S"){
			    	G_COMM.AddOptionSelectBox(obj, '', false, '-선택-');	
			    }else if(type == "A"){
			    	G_COMM.AddOptionSelectBox(obj, '', false, '-전체-');
			    }else if(type != "" && type != undefined && type != null ){
			    	G_COMM.AddOptionSelectBox(obj, '', false, type);
			    }
			    
			    for (var i = 0; i < list.length; i++) {
			      var ck = false;
			      if(list[i].CODE == selVal) ck = true;
			      var codeNm = list[i].code_nm; 
			      if(codeNm == undefined) codeNm = list[i].code;
			      G_COMM.AddOptionSelectBox(obj, list[i].code, ck, codeNm);
			    }
			  };
			  G_AJAX.ajaxCall(url, params, sucessFunc, "", async);
		},
		/**
		 * selectBox 생성
		 * @param $element
		 * @param strValue
		 * @param bSelected
		 * @param strText
		 */
		AddOptionSelectBox : function($element, strValue, bSelected, strText){
			  if(bSelected){
				  $element.append('<option value="'+strValue+'" selected>'+strText+'</option>');
			  }else{
			    $element.append('<option value="'+strValue+'">'+strText+'</option>');
			  };
		},	
/************************************************* 달력 하나에 사용 되는 공통 함수 Begin *************************************************/			
			/**
			 * 함수 설명 : 달력(DatePicker1)적용 - 개별 날짜 사용시 사용
			 * @param obj  :  해당 객체
			 * @param dateformat  :  날짜형식
			 */
			gfnSetDatePicker1One:function (obj, dateformat) {
				if(dateformat == "" || dateformat == undefined){
					dateformat = 'yy-mm-dd';
				}
			    $( obj ).datepicker1({
			    	closeText: '닫기',
			    	prevText: '이전달',
			    	nextText: '다음달',
			    	currentText: '오늘',
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월' ],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					weekHeader: 'Wk',
					dateFormat: dateformat,   // 날짜형식 = 20130329
					autoSize: false,    // 자동리사이즈 (false 이면 상위 정의에 따름)
					changeMonth: true,   // 월변경 가능
					changeYear: true,   // 연변경 가능
					showMonthAterYear: true,  // 년 위에 월 표시
					showOn: 'both',    // 엘리먼트와 이미지 동시사용 (both, button)
					buttonImageOnly: true,   // 이미지 표시
					buttonText: '달력',   // 버튼 텍스트 표시
					buttonImage: '/resources/img/com/calendar.png',  // 이미지 주소
					showMonthAfterYear: true,
					showButtonPanel: true,
					onSelect: function(){ //날짜 선택시 호출되는 함수
						  $(this).removeClass("errInpt");
				        },
					//yearRange: 'c-99:c+99',  // 1990~2020년 까지
					//maxDate: '+6Y',    // 오늘 부터 6년 후까지만.  +0d 오늘 이전 날짜만 선택
					//minDate: '-30d'
				});
			},
/************************************************* 달력 하나에 사용 되는 공통 함수 end *************************************************/
/************************************************* 달력 기간에 사용 되는 공통 함수 Begin *************************************************/
			/**
			 * 함수 설명 : 기간 날짜 설정 간단하게 세팅하는 함수 input id는 고정으로 사용 startDay,endDay 
			 * @param obj  :  해당 객체
			 * @param dateformat  :  날짜형식
			 */
			gfnInitDatePicker1Two:function (){
				this.gfnSetDatePicker1Two($("#startDay"));
				this.gfnSetDatePicker1Two($("#endDay"));
			},
			/**
			 * 함수 설명 : 달력(DatePicker1)적용 - 시작날짜와 종료날짜 같이 사용할 경우 이함수사용
			 * @param obj  :  해당 객체
			 * @param dateformat  :  날짜형식
			 */
			gfnSetDatePicker1Two:function (obj, dateformat) {
				
				if(dateformat == "" || dateformat == undefined){
					dateformat = 'yy-mm-dd';
				}
			    $( obj ).datepicker1({
			    	closeText: '닫기',
			    	prevText: '이전달',
			    	nextText: '다음달',
			    	currentText: '오늘',
					monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월' ],
					dayNamesMin: ['일','월','화','수','목','금','토'],
					weekHeader: 'Wk',
					dateFormat: dateformat,   // 날짜형식 = 20130329
					autoSize: false,    // 자동리사이즈 (false 이면 상위 정의에 따름)
					changeMonth: true,   // 월변경 가능
					changeYear: true,   // 연변경 가능
					showMonthAterYear: true,  // 년 위에 월 표시
					showOn: 'both',    // 엘리먼트와 이미지 동시사용 (both, button)
					buttonImageOnly: true,   // 이미지 표시
					buttonText: '달력',   // 버튼 텍스트 표시
					buttonImage: '/resources/img/com/calendar.png',  // 이미지 주소
					showMonthAfterYear: true,
					showButtonPanel: true,
					onSelect: function(){ //날짜 선택시 호출되는 함수
					  $(this).removeClass("errInpt");
					  G_COMM.gfnSelectDPEvent($( obj ));
			        },
			        minDate : G_COMM.gfnSetDPMinDate($( obj )),
					maxDate : G_COMM.gfnSetDPMaxDate($( obj ))
					//yearRange: 'c-99:c+99',  // 1990~2020년 까지
					//maxDate: '+6Y',    // 오늘 부터 6년 후까지만.  +0d 오늘 이전 날짜만 선택
					//minDate: '-30d'
				});
			},
			//달력 선택시 min,max 값 재설정
			gfnSelectDPEvent:function (obj) {
				var id = $(obj).attr("id");
				if (id == "startDay") {
					$('#endDay').datepicker1("option", "minDate", $("#startDay").val());
				} else if (id == "endDay") {
					$('#startDay').datepicker1("option", "maxDate", $("#endDay").val());
				}
			},
			//시작날짜의 min날짜 설정
			gfnSetDPMinDate:function (obj) {
				var retVal = "";
				var id = $(obj).attr("id");
				if (id == "endDay") {
					retVal = $("#startDay").val();
				}
				return retVal;
			},
			//시작날짜의 max날짜 설정
			gfnSetDPMaxDate:function (obj) {
				var retVal = "";
				var id = $(obj).attr("id");
				if (id == "startDay") {
					retVal = $("#endDay").val();
				}
				return retVal;
			},
/************************************************* 달력 기간에 사용 되는 공통 함수 End *************************************************/
/************************************************* 편리하기 사용하기 위해 만든 공통 유틸 javascript Begin *************************************************/
			/**
			 * 함수 설명 : null값을 다른 문자열로 대체, 대체문자열이 없을 경우 공백으로 리턴
			 * @param data :  검사 데이터값(필수)
			 * @param chr  :  대체문자 
			 */
			gfnCheckNull:function (data , chr){
			    if(chr == null || chr == undefined) chr ='';
			    
			    if(data == null || data == undefined || data== 'null'|| data === ''){
			        return chr;
			    }else{
			        return data;
			    }   
			},
			/**
			 * 함수 설명 : null값을 '-' 바 형태의 문자열로 리턴
			 * @param data :  검사 데이터값(필수)
			 */
			gfnCheckNullToBar:function (data){
				return this.gfnCheckNull(data,'-');
			},

			/**
			* 체크된 항목들 값을 취합해서 리턴
			* @param itemName 체크박스명
			* @param delim    구분자
			*/
			gfnCheckBoxCheckedToString:function (itemName, delim){
				var obj = document.getElementsByName(itemName);
				var div = delim;
				if(div=="")
					div="|";
				var chkCnt=0;
				if(typeof(obj) == 'undefined'){
					return "";
				}
				var s="";
				var n=0;
				for(var i=0; i<obj.length; i++){
					if(obj[i].checked){
						if(n>0)
							s += div;
						s += obj[i].value;
						n++;
					}
				}
				return s;
			},

			/**
			* 특정이름의 멀티체크박스를 체크 또는 체크해제한다.
			* ex) <input type=checkbox name=IDS value='...'>
			*     <script language='javascript'>
			*		gfnToggleMultiChk(this.checked, 'IDS')
			*	   </script>
			*
			* @param bCheck    true|false(체크할 상태)
			* @param itemName  체크대상 체크박스이름
			*/
			gfnToggleMultiChk:function (bCheck, itemName){
				var obj = document.getElementsByName(itemName);
				if(typeof(obj) == 'undefined'){
					return;
				}

				for(var i=0; i<obj.length; i++){
					obj[i].checked = bCheck;
				}
			},

			/**
			* input 객체들 구분자로 문자열 반환
			* @param obj 해당 객체들 
			*/
			gfnObjToString:function (obj){
				var len = obj.length;
				var ele = obj;
				var str="";
				if(obj.length > 1){
					for(var i=0; i < len; i++){
						if (i > 0) {
							str += "|";
						}
						str += ele[i].value;
					}
				}else{
					str = obj.value;
				}
				return str;
			},
			gfnGetObjArrayKey:function(checked , keyNm){
				var result = new Array;
				for(var i=0;i<checked.length;i++){
					result.push( checked[i][keyNm] );
				}
				return result;
			},
			/**
			* 체크된 항목들 값을 취합해서 리턴
			* @param itemName 체크박스명
			* @param delim    구분자
			*/
			gfnMultiCheckedString:function (itemName, delim){
				var obj = document.getElementsByName(itemName);
				var div = delim;
				if(div=="" || div == undefined)
					div="|";
				var chkCnt=0;
				if(typeof(obj) == 'undefined'){
					return "";
				}
				var s="";
				var n=0;
				for(var i=0; i<obj.length; i++){
					if(obj[i].checked){
						if(n>0)
							s += div;
						s += obj[i].value;
						n++;
					}
				}
				return s;
			},

			gfntMultiNonCheckedString:function (itemName, delim){
				var obj = document.getElementsByName(itemName);
				var div = delim;
				if(div=="" || div == undefined)
					div="|";
				var chkCnt=0;
				if(typeof(obj) == 'undefined'){
					return "";
				}
				var s="";
				var n=0;
				for(var i=0; i<obj.length; i++){
					if(obj[i].checked){
						
					}else{
						if(n>0)
							s += div;
						s += obj[i].value;
						n++;
						
					}
				}
				return s;
			},


			/**
			* 팝업 오픈
			* @param url URL 
			* @param w 폭 
			* @param h 너비
			* @param s 스크롤바 여부 1, 'Y'이면 보여줌, 0, '', 'N'이면 숨김 
			*/
			gfnPopup:function (url,w,h,s,target){

				var l, t, objPopup;
				if(target == 'undefined' || target=='' || target==null) {
					var target='win1';
				}
				l = (screen.width-w)/2;
				t = (screen.height-h)/2;
				if(s==1 || s=="Y")
					objPopup  = window.open(url,target,'width='+w+',height='+h+',left='+l+',top='+t+',resizable=0,scrollbars=1');
				else if (s=="" || s==0 || s=="N" || !s || s=="0" )
					objPopup = window.open(url,target,'width='+w+',height='+h+',left='+l+',top='+t+',resizable=0,scrollbars=0,status=0');
				else
					objPopup = window.open(url,target,'width='+w+',height='+h+',left='+l+',top='+t+',resizable=1,menubar=1,toolbar=1,scrollbars=1,status=1');
				if (objPopup == null) {
					alert("차단된 팝업창을 허용해 주십시오.");
				}
				return objPopup;
			},


			/**
			* 쿠키값 세팅
			* @param cookieName 쿠키이릅 
			* @param value 쿠키값
			* @param exdays 만료일
			*/
			gfnSetCookie:function (cookieName, value, exdays){
			  if(value == undefined) value = "on";
			  if(exdays == undefined) exdays = 1;
			    var exdate = new Date();
			    exdate.setDate(exdate.getDate() + exdays);
			    var cookieValue = escape(value) + ((exdays==null) ? "" : "; path=/; expires=" + exdate.toGMTString());
			    document.cookie = cookieName + "=" + cookieValue;
			},

			/**
			* 쿠키값 삭제
			* @param cookieName 쿠키이릅 
			*/
			gfnDeleteCookie:function (cookieName){
			    var expireDate = new Date();
			    expireDate.setDate(expireDate.getDate() - 1);
			    document.cookie = cookieName + "= " + "; path=/; expires=" + expireDate.toGMTString();
			},

			/**
			* 쿠키값 가져오기
			* @param cookieName 쿠키이릅 
			*/
			gfnGetCookie:function (cookieName) {
			    cookieName = cookieName + '=';
			    var cookieData = document.cookie;
			    var start = cookieData.indexOf(cookieName);
			    var cookieValue = '';
			    if(start != -1){
			        start += cookieName.length;
			        var end = cookieData.indexOf(';', start);
			        if(end == -1)end = cookieData.length;
			        cookieValue = cookieData.substring(start, end);
			    }
			    return unescape(cookieValue);
			},

			/* 쿠키 사용 팝업 닫기 */
			gfnCloseWin:function (cookieName){
				gfnSetCookie(cookieName);
				self.close();
			},

			/* 쿠키 사용 레이어 팝업 닫기 */
			gfnCloseLayer:function (cookieName){
				gfnSetCookie(cookieName);
				$("#"+cookieName).hide();
				return false;
			},
			/*
			 * 검색기간 체크
			 * */
			gfnDayDifCheck:function (obj, obj2){
				var d1 = Number(obj.val().replace(/-/g, ''));
				var d2 = Number(obj2.val().replace(/-/g, ''));
				if (d2 - d1 < 0) {
					alert("기간설정이 잘못되었습니다.");
					obj.focus();
					return false;
				}
				return true;
			},

			gfnLeadingZeros:function (n, digits) {
				var zero = '';
				n = n.toString();

				if (n.length < digits) {
					for (i = 0; i < digits - n.length; i++)
						zero += '0';
				
				}
				return zero + n;
			},

			gfnCurYYYY:function (){
				var d = new Date();
				
				return this.gfnLeadingZeros(d.getFullYear(), 4);
			},

			gfnCurMM:function (){
				var d = new Date();
				
				return this.gfnLeadingZeros(d.getMonth() + 1, 2);
			},

			gfnCurDD:function (){
				var d = new Date();
				
				return this.gfnLeadingZeros(d.getDate(), 2);
			},

			gfnCurDate:function (){
				var d = new Date();
				
				var date = '';
				
				date += this.gfnLeadingZeros(d.getFullYear(), 4) + '-';
				date += this.gfnLeadingZeros(d.getMonth() + 1, 2) + '-';
				date += this.gfnLeadingZeros(d.getDate(), 2) + ' ';
				date += this.gfnLeadingZeros(d.getHours(), 2) + ':';
				date += this.gfnLeadingZeros(d.getMinutes(), 2) + ':';
				date += this.gfnLeadingZeros(d.getSeconds(), 2);

				return date;
			},
			gfnToday:function(){
				var today = new Date();
				var dd = today.getDate();
				var mm = today.getMonth()+1; //January is 0!
				var yyyy = today.getFullYear();

				if(dd<10) {
				    dd='0'+dd;
				} 

				if(mm<10) {
				    mm='0'+mm;
				} 

				today = yyyy+"-"+mm+'-'+dd;
				return today;
			},
			gfnIsDateCheck:function (str) {
				if  ( !/([0-9]{4})([0-9]{2})([0-9]{2})/.test(str) )  {
					//alert("날짜의 형식이 잘못 입력되었습니다.\n예) 1996-04-05");
					return false;
				}
				// 현재 날짜
				var toDay = new Date();
				
				var arrDate0 = str.substr(0,4);
				var arrDate1 = str.substr(4,2);
				var arrDate2 = str.substr(6,2);
				
				var maxDay = new Date(new Date(arrDate0, arrDate1, 1) - 86400000).getDate();
				
				if  ( arrDate0 == 0000 || arrDate0 > toDay.getFullYear() )  {
					//alert("잘못된 년도를 입력하였습니다.");
					return false;
				}
				if  ( arrDate1 == 00 || arrDate1 > 12  )  {
					//alert("잘못된 월을 입력하였습니다.");
					return false;
				}
				if  ( arrDate2 == 00 || arrDate2 > maxDay )  {
					//alert("잘못된 일을 입력하였습니다.");
					return false;
				}
				return true;
			},
/************************************************* 편리하기 사용하기 위해 만든 공통 유틸 javascript End *************************************************/
			
			
/************************************************* Jquery를 좀더 쉽게 사용하기 위해 만든 공통 함수 Begin *************************************************/
			/**
			 * 함수 설명 : selectBox 값을 리턴함
			 * @param ojbIdorNm  :  id 및 name값을 인자로 사용(필수)
			 */
			gfnIdVal:function (ojbId){
				var retVal = "";
				if(ojbId != undefined) retVal = $("#"+ojbId).val(); 
				return this.gfnCheckNull(retVal);
			},
			/**
			 * 함수 설명 : radio 값을 리턴함
			 * @param ojbNm  :  name값을 인자로 사용(필수)
			 */
			gfnRadioVal:function (ojbNm){
				var retVal = "";
				if(retVal == undefined) retVal = $("input:radio[name="+ojbNm+"]:checked").val();
				return this.gfnCheckNull(retVal);
			},
/************************************************* Jquery를 좀더 쉽게 사용하기 위해 만든 공통 함수 End *************************************************/
			logOut:function (){
				location.href='/USR/LOGIN/out';
			},
/************************************************* 레이어 팝업 Start *************************************************/
			wrapWindowByMask:function(){
			    //화면의 높이와 너비를 구한다.
			    var maskHeight = $(document).height(); 
			    var maskWidth = $(window).width();

			    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채운다.
			    $('.mask').css({
			        'width' : maskWidth,
			        'height' : maskHeight
			    });

			    //애니메이션 효과
			    $('.mask').fadeTo("slow", 0.5);
			},
			popupOpen:function() {
			    $('.layerpop').css("position", "fixed");
			    //영역 가운에데 레이어를 뛰우기 위해 위치 계산 
			    
			    $('.layerpop').css("top",(($(window).height() - $('.layerpop').outerHeight()) / 2) + $(window).scrollTop());
			    $('.layerpop').css("left",(($(window).width() - $('.layerpop').outerWidth()) / 2) + $(window).scrollLeft());
			    $('.layer').css("display", "block");
			},
			/*
			 * 
			 * num-> 닫을 팝업 순서
			 * formNm-> reset 할 form Name
			 * */
			popupClose:function(formNm) {
			    $("#layerPopArea").html("");
			},
			openLayerPop:function() {
			    this.popupOpen(); //레이어 팝업창 오픈 
			    this.wrapWindowByMask(); //화면 마스크 효과 
			},
			/*
			 * 
			 * popup 컬럼 셋팅
			 * 
			 * */
			setPopColumns:function(columns){
				for(idx in columns) {
					if (columns[idx].editor == undefined) continue;
					
					var thStr = '<th>' + columns[idx].header + '</th>';
					var type = columns[idx].editor.type == undefined ? columns[idx].editor : columns[idx].editor.type;
					var tdStr = '';
					var clsStr = '';
					if (columns[idx].validation != undefined) {
						if (columns[idx].validation.required) clsStr += clsStr == '' ? 'checkNull' : ' checkNull';
				        if (columns[idx].validation.dataType == 'number') clsStr += clsStr == '' ? 'intCheck' : ' intCheck';
					}
					if (type == 'text') {
						tdStr += '<td><input type="text" name="' + columns[idx].name + '" class="' + clsStr + '" title="' + columns[idx].header + '"/></td>';
					}
					else if (type == 'select') {
						tdStr += '<td><select name="' + columns[idx].name + '" class="' + clsStr + '" title="' + columns[idx].header + '" select-type="-select-" ></select></td>';
					}
					else if (type == 'datePicker') {
						tdStr += '<td><input id="' + columns[idx].name + '" type="text" size="10" class="W90p ' + clsStr + '" readonly="readonly" name="' + columns[idx].name + '" title="' + columns[idx].header + '" /> </td>';
					};
					$('.popTable tbody').append('<tr>' + thStr + tdStr + '</tr>');
				}
			},
/************************************************* 레이어 팝업 End *************************************************/
			excelDownLoad:function(url,formId){
				excelDown(url,formId);
			},
			
			
/************************************************* treeData Start *************************************************/			
			/*
			 * data.result -> 트리 데이터 형식으로 변환
			 * topValue -> 최상단 값
			 * */
			setTreeData:function(data , expanded , topValue){
				
				
				if(expanded == undefined){
					expanded = false;
				};
				if(topValue == undefined){
					topValue = "SYSTEM_ID";
				};
				
			    var orgData = data;

			    //var cloneData = JSON.parse(JSON.stringify(orgData));       //Deep copy
			    var cloneData = orgData.slice();                           //Shallow copy
			    cloneData.reverse();
			    var pMenuId, pMenu,  systemId ;
			   
			 	/*기본 select start*/
			   	var parent_list = [];
			   	var parent_ ;
			   	
			   	if(this.gfnCheckNull(selectTreeKey) != ''){
	            	
	            	if(orgData[selectTreeKey].parent_menu_id != topValue){
	            		
	            		parent_ = orgData[this.getFindIndex(orgData ,orgData[selectTreeKey].parent_id)];
	            		parent_list.push(parent_.this_id);
	            		
	            		if(parent_.parent_menu_id != topValue){
	            			do{
	            				parent_ = orgData[this.getFindIndex(orgData ,orgData[this.getFindIndex(orgData, parent_.this_id)].parent_id)];
	            				parent_list.push(parent_.this_id);
	            				if(parent_.parent_menu_id == topValue){
	            					break;
	            				};
	            			}while(parent_.parent_menu_id != topValue);
	            		};
	            	};
	            	selectTreeKey = null;
	            };
	            /*기본 select end*/
	            
	            
			   for (var idx in cloneData) {
			      pMenuId = cloneData[idx].parent_id;
			      systemId = cloneData[idx].this_id;
			      
				      if (pMenuId != '') {
				         pMenu = orgData[this.getFindIndex(orgData, pMenuId)];
				         
				         if(pMenu != undefined ){
					         if (!pMenu.hasOwnProperty('_attributes')) {
					            pMenu._attributes = {};
					            pMenu._attributes.expanded = expanded;
					           
					            if(parent_list.includes(pMenu.this_id)){
					            	pMenu._attributes.expanded = true;
					            };
					            
					         };
					         if (!pMenu.hasOwnProperty('_children')) pMenu._children = [];
					          pMenu._children.splice(0,0,orgData[this.getFindIndex(orgData, systemId)]);
					         orgData.splice(this.getFindIndex(orgData, systemId),1);
				         };
				      };
			   	};
			   	
			  
	            
	            
			   return orgData;
			},
			getFindIndex:function(data, systemId) {
				return data.findIndex(function(item){
					return (item.this_id == systemId);
					}
				);
			}
			/************************************************* treeData Start *************************************************/			
};

/**
 * 함수 설명 : 엑셀 다운로드 시 사용 - 다운로드 시간이 오래걸리는 경우 사용 (화면에 다운로드 중이라고 표시해줌)
 * @param formId  :  form id
 */
function excelDown(url ,formId){
	this.startDownBlockUi();
	var formObj = $("#"+formId);
	$.fileDownload(url,{
        httpMethod:'POST', 
        data: formObj.serialize()
       })
       .done(function (url) {
    	   stopBluckUi();
       })
       .fail(function (responseHtml, url) {
    	   this.stopBluckUi();
    	   alert("시스템 오류가 발생하였습니다.\n잠시후에 사용하시기 바랍니다.");
       });
}
/**
 * 함수 설명 : blockUi - 엑셀 다운로드용
 */
function startDownBlockUi(){
	startBlockUi("엑셀 다운로드 중입니다.....<br/>잠시만 기다려 주시기 바랍니다.");
};
/**
 * 함수 설명 : blockUi 종료
 */
function stopBluckUi(){
	$.unblockUI();
};
/**
 * 함수 설명 : blockUi - Ajax 조회용
 * @param msg  :  보여지는 메시지 글
 */

function startBlockUi(msg){
	if(msg == undefined) msg = '데이터 로딩중입니다.....<br/>잠시만 기다려 주시기 바랍니다.';
	$.blockUI({ message: msg,css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
        opacity: .5, 
        color: '#fff'
    } });
}
/*
 * 갭쳐
 * */
function fnCapture(objId , menuNm) {
	
    html2canvas(document.getElementById(objId)).then(function(canvas) {
        if (navigator.msSaveBlob) {
            var blob = canvas.msToBlob();
            return navigator.msSaveBlob(blob, menuNm);
        } else {
            var el = document.getElementById("target");
            el.href = canvas.toDataURL("image/jpeg");
            el.download = menuNm;
            el.click();
        };
        
    });
}
/*
 * 리포트 뷰어 열기
 * url , 폼네임
 * */
function fnReport(url , frmNm){
	
	G_COMM.gfnPopup('','800','850' , '0','reportViewer');
    var frm =document.getElementById(frmNm);
    frm.action = url;
    frm.target ="reportViewer";
    frm.method ="post";
    frm.submit();
}
/*
 * 리포트 액션
 * printNm->파일네임
 * */
function fnReportPrint(){
	$(".printBtn").hide();
	$(".printA4").addClass("H100p");
	window.print();//프린트
	$(".printA4").removeClass("H100p");
	$(".printBtn").show();
};

/*
 * 캡처->PDF저장
 * */
function fnCapPDF(objId , menuNm){
	
	html2canvas( document.getElementById(objId) , {
		  onrendered: function(canvas) {
		    // 캔버스를 이미지로 변환
		    var imgData = canvas.toDataURL('image/png');
		     
		    var imgWidth = 200; // 이미지 가로 길이(mm) A4 기준
		    var pageHeight = imgWidth * 1.414;  // 출력 페이지 세로 길이 계산 A4 기준
		    var imgHeight = canvas.height * imgWidth / canvas.width;
		    var heightLeft = imgHeight;
		     
		        var doc = new jsPDF('p', 'mm');
		        var position = 5;
		         
		        // 첫 페이지 출력
		        doc.addImage(imgData, 'PNG', 5, position, imgWidth, imgHeight);
		        heightLeft -= pageHeight;
		         
		        // 한 페이지 이상일 경우 루프 돌면서 출력
		        while (heightLeft >= 20) {
		          position = heightLeft - imgHeight;
		          doc.addPage();
		          doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
		          heightLeft -= pageHeight;
		        }
		        // 파일 저장
		        doc.save(menuNm+'.pdf');
		  }
		});
}
/*
 * 바코드 이미지 생성 
 * classNm->바코드 이미지 위치 클래스
 * value-> 값
 * w->width
 * h->height
 *  */
function setBarcode(classNm,value,w,h){
	
	if(classNm == undefined){
		classNm="barcode";
	};
	$("."+classNm).barcode(value, "code128",{barWidth:w, barHeight:h});
};

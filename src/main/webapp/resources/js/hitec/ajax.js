/**
 *  Data Transaction
 *  1.ajaxCall
 */
var ajaxCallHtmlCnt = 0;
var G_AJAX = {
		ajaxCall:function(url,params,sucessFun,errorFun, async){
			  
			  /*$("#viewLoading").show();*/
			  $.ajax({
				  	cache : false,
			        type: "POST",
			        url: url,
			        data: params,
			        async: async,
			        dataType: 'json',
			        contentType: "application/x-www-form-urlencoded; charset=UTF-8", // AJAX contentType
			        success: function(data){
			          //$("#viewLoading").hide();
			          if(data.errorCode != undefined && data.errorCode == '401'){
			                alert(data.message);
			                if(typeof(errorFun) == 'function') errorFun(data);
			                return;
			            }
			          if(data.message != undefined && data.message != ''){
			            alert(data.message);
			          }
			          if(typeof(sucessFun) == 'function') sucessFun(data);
			        }, 
			        error : function(xhr, status, error){
			          //$("#viewLoading").hide();
			            if(typeof(errorFun) == 'function'){
			            	errorFun(error);
			            }else{
			            	alert("시스템 오류가 발생하였습니다."+error);
			            };
			            return;
			        },
			        beforeSend : function(){
						startBlockUi("조회 중 입니다......<br/>잠시만 기다려 주시기 바랍니다.");
					},
					complete : function(){
						stopBluckUi();
					}
			    });
			},
			ajaxCallHtml:function(url,params,sucessFun,errorFun, async){
				ajaxCallHtmlCnt += 1;
			  if(async == undefined) async = true;
			  $.ajax({
				  	cache : false,
			        type: "POST",
			        url: url,
			        data: params,
			        async: async,
			        dataType: 'html',
			        contentType: "application/x-www-form-urlencoded; charset=UTF-8", // AJAX contentType
			        success: function(data){
			        	var result = data;
			        	try{
			        		result = JSON.parse(data);
			        	}catch(e){
			        		result = data;
			        	}
			        	
			          if(result.errorCode != undefined && result.errorCode == '401'){
			                alert(result.message);
			                location.href= "/web";
			                if(typeof(errorFun) == 'function') errorFun(result);
			                return;
			            }
			          if(result.message != undefined && result.message != ''){
			            alert(result.message);
			          }
			          if(typeof(sucessFun) == 'function') sucessFun(result);
			        }, 
			        error : function(xhr, status, error){
			            alert("시스템 오류가 발생하였습니다."+error);
			            if(typeof(errorFun) == 'function') errorFun();
			            return;
			        },
			        beforeSend : function(){
			        	startBlockUi();
					},
					complete : function(){
						ajaxCallHtmlCnt -= 1;
						//console.log("ajaxCallHtmlCnt : " + ajaxCallHtmlCnt);
						if(ajaxCallHtmlCnt == 0) stopBluckUi();
						//
					}
			    });
			}
			

};


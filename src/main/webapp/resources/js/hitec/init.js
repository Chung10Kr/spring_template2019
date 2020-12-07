


$(function () {
	
});

var G_INIT = {
	columns: undefined,
	search: undefined,
	priv:undefined,
    init: function(initParams) {
    	G_INIT.columns = initParams.columns;
    	G_INIT.search = initParams.search;
    	G_INIT.priv = initParams.priv;
    	
    	//0. View 내 바인드 대상 Get
    	//   0.1 다국어(조회조건, 그리드 컬럼 전부)    	//   0.2 코드 바인딩(select tag, 일단 select만)
    	var target = G_INIT.getInitTarget();
    	//1. 조회조건 및 그리드 용 다국어 및 Combo, Radio를 위한 데이터 조회
        var url = "/UTL/CODE/getCaptionAndCodeList";

    	var sendData = target;
    	var codeAndCap;
    	var sucessFunc = function(data) {
    	    codeAndCap = G_INIT.setSplitCodeAndCaption(data.list);
    	    G_INIT.setBindLang(codeAndCap.lang);
    	    G_INIT.setBindCode(codeAndCap.code);
    	};
    	G_AJAX.ajaxCall(url, sendData, sucessFunc,null,false);
    },
    getInitTarget: function() {
    	
    	//권한Check
    	if( G_INIT.priv != undefined ){
	    	if((G_INIT.priv).indexOf("S") == -1 ){
		    	for (var i in G_INIT.columns) {
		    		for (var j in G_INIT.columns[i]) {
		        	    if (G_INIT.columns[i][j].editor != undefined){
		        	    	G_INIT.columns[i][j].editor = false;
		        		};
		            };
		    	};
	    	};
    	};
    	
    	
    	  
    	
    	
    	var langs = [];
    	//1. 다국어
    	//조회조건 th 검색
    	for (var idx in G_INIT.search) {
    		$(G_INIT.search[idx] + " th").each(function() {
    	    	  if (!langs.includes($(this).html()))
    	    		    langs.push($(this).html());
    	    	});
    	}
    	
    	 
    	//그리드 컬럼
    	for (var i in G_INIT.columns) {
    		for (var j in G_INIT.columns[i]) {
                if (!langs.includes(G_INIT.columns[i][j].header))
               	   langs.push(G_INIT.columns[i][j].header);
            }
    	}
    	
    	//2. 코드
    	var codes = [];
    	//조회조건 select 검색
    	for(var idx in G_INIT.search) {
    		$(G_INIT.search[idx]+ " select").each(function() {
    	          if (!codes.includes($(this).attr("name")))
    	        	  codes.push($(this).attr("name"));
    	        });
    	}
        
    	
    	var editType = ['select' , 'checkbox' , 'radio'];
    	
    	for (var i in G_INIT.columns) {
    		for (var j in G_INIT.columns[i]) {
        	    if (G_INIT.columns[i][j].editor != undefined){
        	    	if( $.inArray( G_INIT.columns[i][j].editor.type ,editType) != -1){
        	    		if (!codes.includes(G_INIT.columns[i][j].header)) {
        	    			codes.push(G_INIT.columns[i][j].header);
        	    		};
        	    	};
        		};
            };
    	};
    	
    	for (var i in G_INIT.columns) {
    		for (var j in G_INIT.columns[i]) {
        	    if (G_INIT.columns[i][j].filter != undefined){
        	    	G_INIT.columns[i][j].filter.showApplyBtn = true;
        	    	G_INIT.columns[i][j].filter.showClearBtn = true;
        	    };
            };
    	};
    	
    	
    
    	var result = {};
    	result.LANG_BIND_COLS = langs.join();
    	result.CODE_BIND_COLS = codes.join();
    	return result;
    },
    setSplitCodeAndCaption: function(data) {
    	var result = {};
    	var lang = {};
    	var code = {};
    	var codeCategory;
    	var codeTmp;
    	for (var idx in data) {
    		if (data[idx].gb == "LANG") {
    			lang[data[idx].cd.toLowerCase()] = data[idx].cd_nm;
    		}
    		else {	
    			codeCategory = data[idx].category;
    			if (!code.hasOwnProperty(codeCategory)) {
    				code[codeCategory] = [];
    			}
    			codeTmp = {};
    			//Toast UI Grid Dependency(text, value)
    			codeTmp.value = data[idx].cd;
    			codeTmp.text = data[idx].cd_nm;
    			code[codeCategory].push(codeTmp);
    		}
    	}
    	result.lang = lang;
    	result.code = code;
    	return result;
    },
    setBindLang: function(data) {
    	for (var idx in G_INIT.search) {
    		$(G_INIT.search[idx] + " th").each(function() {
    	  	      $(this).html(data[$(this).html()]);
    	  	    });
    	}
    	
    	for (var i in G_INIT.columns) {
    		for (var j in G_INIT.columns[i]) {
    	      	   G_INIT.columns[i][j].header = data[G_INIT.columns[i][j].header];
    	        }
    	}
        
    },
    setBindCode: function(data) {
    	for (var idx in G_INIT.search) {
    		$(G_INIT.search[idx] + " select").each(function() {
        		var obj = $(this);
        		var searchCodeList = data[$(this).attr("name")];
        		
        		var selectType = G_COMM.gfnCheckNull(obj.attr("select-type"));

        		
        		if(selectType != ""){ //전체 , 선택
        			G_COMM.AddOptionSelectBox(obj, '', false, selectType );
        		}
        		var selectedValue = false; //selected 설정
        		for (var idx in searchCodeList) {
        			
        			if( G_COMM.gfnCheckNull(obj.attr("selected-data")) == searchCodeList[idx].value){
            			selectedValue = true;
            		}else{
            			selectedValue = false;	
            		};
            			
        			G_COMM.AddOptionSelectBox(obj, searchCodeList[idx].value, selectedValue, searchCodeList[idx].text);
        		}
        		
        	});
    	}
    	
    	
		
    	var editType = ['select' , 'checkbox' , 'radio'];
    	
    	for (var i in G_INIT.columns) {
    		for (var j in G_INIT.columns[i]) {
        		if (G_INIT.columns[i][j].editor != undefined ) {
        			
        	    	if( $.inArray( G_INIT.columns[i][j].editor.type ,editType) != -1){
	                	var options = {};
	                	options.listItems = data[G_INIT.columns[i][j].name];
	                	//TOAST UI Grid Dependency
	                	G_INIT.columns[i][j].formatter = "listItemText";
	                	//TOAST UI Grid Dependency
	                	G_INIT.columns[i][j].editor.options = options;
        			};
                };
            };
    	};
    }
};


/**
 * 단축키 세팅
 *  0 : 화면 확대 / 축소
 *  8: 로딩화면 on
 *  esc : 로당화면 off 
 */
$(document).ready(function() {
	$.shortcut({
		//0
        48 : function(){
        	gfnExpand();
        },
        //esc
        27 : function(){
        	//stopBluckUi()
        },
        //8
        56 : function(){
        	//startBlockUi()
        }
    });
});


/**
 * 화면 확대/축소 함수
 */
function gfnExpand(){
	
	if($("#nav").css("display") == 'none'){
		$("#nav").show();
		$("#header").show();
		$("#content").removeClass("W100p").addClass("W85p");
	}else{
		$("#nav").hide();
		$("#header").hide();
		$("#content").removeClass("W85p").addClass("W100p");
	};
	
	//이것을 동적으로 할수 있는 방법이 있을까??
	if(typeof(grid1) != 'undefined'){
		G_CMP.refreshLayout(grid1,"grid1");
	};
	if(typeof(grid2) != 'undefined'){
		G_CMP.refreshLayout(grid2,"grid2");
	};
	if(typeof(grid3) != 'undefined'){
		G_CMP.refreshLayout(grid3,"grid3");
	};
	
};

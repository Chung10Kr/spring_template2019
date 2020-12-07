/**
 * 외부 Commponent
 */
var theme = null; // nav.jsp 참조
var selectTreeKey =null;
var G_CMP = {
		
/*---------Grid---------*/
		refreshLayout:function(grid,gridNm){
			grid.refreshLayout(gridNm);
		},
		setData:function(grid,datas){
			grid.resetData(datas);
		},
		getGrid:function(gridNm,gridColumns,result_data,option) {
			
			//그리드 컬럼 Edit function 관리
			var funcList=[];
    		for (var j in gridColumns) {
                if(G_COMM.gfnCheckNull(gridColumns[j].editor) != ""){
                	funcNm = gridColumns[j].ChgFunc;
                	funcList.push(gridColumns[j]);
                	gridColumns[j].onAfterChange = function(data){
                		for(var f_i in funcList){
                			if(data.columnName == funcList[f_i].name){
                				eval( funcList[f_i].ChgFunc+"("+ data.rowKey +");");
                				break;
                			};
                		};
                    }; 
                } ;
	    	};
			
	    	
	    	/*
			 * grid Options
			 * 1. treeCheck: "Y",treeTarget:"menu_nm" -> Tree
			 * 2. perPage:10 -> Page 갯수
			 * 3. rowNum:'Y' -> rownum 표시
			 * 4. rowCheckbox:'Y' -> rowCheckbox checkbox
			 * */
	    	
	    	var gridOption = {} ;
	    	
	    	//페이징 옵션
	    	  gridOption.pageOptions = false;
	    	if(G_COMM.gfnCheckNull(option.perPage) != ''){
	    		gridOption.pageOptions={useClient: true , perPage: G_COMM.gfnCheckNull(option.perPage) } ;
	    	};
	    	
	    	//트리구조 옵션
		    gridOption.treeOption=false;
			if(G_COMM.gfnCheckNull(option.treeCheck) == "Y"){
				gridOption.treeOption = {name: option.treeTarget , useCascadingCheckbox: true};
			};
			
			//rowNum 번호 옵션
			var rowHeader = [];
			if(G_COMM.gfnCheckNull(option.rowNum) == "Y"){
				rowHeader.push( {type: 'rowNum'} );
			};
			//rowCheckbox 옵션
			if(G_COMM.gfnCheckNull(option.rowCheckbox) == "Y"){
				rowHeader.push( {type: 'checkbox'} );
			};
			gridOption.rowHeaders=G_COMM.gfnCheckNull(rowHeader, false);
			
			
			
	        return new G_GRID(gridNm,gridColumns,result_data,gridOption);
	    },
		event:function(grid,eventNm,callback){
			grid.onEvent(eventNm,callback);
		}
/*---------Grid---------*/
};
var label = ' <label for="all-checkbox" class="checkbox"><input type="checkbox" id="all-checkbox" class="hidden-input" name="" /><span class="custom-input"></span></label>';

var G_GRID = function(gridNm,gridColumns,result_data,gridOption) {

	this.grid = new tui.Grid({
	    el: document.getElementById(gridNm),
	    data: result_data,
	    
	    bodyHeight: ($("#" + gridNm).height() - 40),
	    scrollX: true,
	    scrollY: true,
	    
	    columns: gridColumns,
	    pageOptions: gridOption.pageOptions,
	    rowHeaders: gridOption.rowHeaders,
	    treeColumnOptions: gridOption.treeOption,
	    columnOptions: {
	        resizable: true
	    }
	});
	
	onTheme(theme);
	
};


/*그리드 테마 */
function onTheme(themeId) {
//https://nhn.github.io/tui.grid/latest/Grid#applyTheme 참조
	var option=null;

	if(themeId == "navy"){
		option = 
		 {
			cell: {
				normal:{
					text:'#000000'
				},
			    header: {
			      background: '#343a40',
			      text: '#FFFFFF'
			    },
			    rowHeader:{
			      background: '#343a40',
			    },
			    selectedHeader:{
			      background: '#FFFFFF',
			      text:'#343a40'
			    },
			    evenRow: {
			      background: '#f7f7f7'
			    }
			  }
		};
	}else if(themeId == "dark"){
		option = 
		 {
			cell: {
				normal:{
					text:'#FFFFFF'
				},
			    header:{
			      background: '#343a40',
			      text: '#FFFFFF'
			    },
			    rowHeader:{
			      background: '#343a40',
			      text:'#FFFFFF'
			    },
			    selectedHeader:{
			      background: '#FFFFFF',
			      text:'#FFFFFF'
			    },
			    oddRow:{
			      background: '#343a40',
			      text:'#FFFFFF'
			    },
			    evenRow:{
				  background: '#6e6e6e',
				  text:'#FFFFFF'
				},
				dummy:{
				  background: '#343a40'
				}
			  },
			scrollbar:{
				background: '#343a40'
			}
		};		
	};
	
	
	
	tui.Grid.applyTheme('striped',option);
};
/*그리도 refreshLayout*/
G_GRID.prototype.refreshLayout = function(gridNm) {
	  this.grid.refreshLayout();
	  this.grid.setBodyHeight(($("#" + gridNm).height() - 40));
};
/*그리드 이벤트 */
G_GRID.prototype.onEvent = function(eventNm,callback) {
	  this.grid.on(eventNm,callback);
};

/*그리도 조회 후 data show*/
G_GRID.prototype.resetData = function(datas) {
	  this.grid.resetData(datas);
};
/*
* Makes view ready to get keyboard input.
* ex) grid.activeFocus();
*/
G_GRID.prototype.activeFocus = function() {
    this.grid.activeFocus();
};

/*
* Adds the specified css class to cell element identified by the rowKey and className
* ex) grid.addCellClassName(0, 'city','my-text');
*/
G_GRID.prototype.addCellClassName = function(rowKey, columnName, className) {
    this.grid.addCellClassName(rowKey, columnName, className);
};

/*
* Adds the specified css class to all cell elements in the row identified by the rowKey
* ex) grid.addRowClassName(0, 'my-text');
*/
G_GRID.prototype.addRowClassName = function(rowKey, className) {
    this.grid.addRowClassName(rowKey, className);
};

/*
* Inserts the new row with specified data to the end of table.
* ex) 빈로우 그리드 마지막에 추가 => grid.appendRow({},{});
*     빈로우 그리드 첫줄에 추가 =>  grid.appendRow({},{at:0}});
*     데이터로우 그리드 마지막에 추가 grid.appendRow({id:"1",city:"1",country:"1"},{});
*     데이터로우 그리드 첫줄에 추가 및 포커스 grid.appendRow({id:"1",city:"1",country:"1"},{at:0,focus:true});
*/
G_GRID.prototype.appendRow = function(row, options) {
    this.grid.appendRow(row, options);
};
G_GRID.prototype.addRow = function() {
    this.grid.appendRow({}, {});
};
G_GRID.prototype.insertRow = function(rowKey) {
    this.grid.appendRow({}, {at:rowKey});
};

/*
* Removes focus from the focused cell.
* ex) grid.blur();
*/
G_GRID.prototype.blur = function() {
    this.grid.blur();
};

/*
* Checks the row identified by the specified rowKey.
* ex) grid.check();
*/
G_GRID.prototype.check = function(rowKey) {
    this.grid.check(rowKey);
};

/*
* Checks all rows.
* ex) grid.checkAll();
*/
G_GRID.prototype.checkAll = function() {
    this.grid.checkAll();
};

/*
* Removes all rows.
* ex) grid.clear();
*/
G_GRID.prototype.clear = function() {
    this.grid.clear();
};
/*
* Expands tree row
* ex) grid.collapse(0, true);
*/
G_GRID.prototype.collapse = function(rowKey, recursive) {
    this.grid.collapse(rowKey, recursive);
};
/*
* Collapses all tree row.
* ex) grid.collapseAll();
*/
G_GRID.prototype.collapseAll = function() {
    this.grid.collapseAll();
};
/*
* Copy to clipboard
* ex) grid.copyToClipboard();
*/
G_GRID.prototype.copyToClipboard = function() {
    this.grid.copyToClipboard();
};
/*
* Copy to clipboard
* ex) grid.copyToClipboard();
*/
G_GRID.prototype.copyToClipboard = function() {
    this.grid.copyToClipboard();
};
/*
* Destroys the instance.
* ex) grid.destroy();
*/
G_GRID.prototype.destroy = function() {
    this.grid.destroy();
};
/*
* Disables all rows.
* ex) grid.disable();
*/
G_GRID.prototype.disable = function() {
    this.grid.disable();
};
/*
* Disables the row identified by the rowkey.
* ex) grid.disableRow(0, true);
*/
G_GRID.prototype.disableRow = function(rowKey, withCheckbox) {
    this.grid.disableRow(rowKey, withCheckbox);
};
/*
* Disables the row identified by the specified rowKey to not be able to check.
* ex) grid.disableRowCheck(0);
*/
G_GRID.prototype.disableRowCheck = function(rowKey) {
    this.grid.disableRowCheck(rowKey);
};
/*
* Enables all rows.
* ex) grid.enable();
*/
G_GRID.prototype.enable = function() {
    this.grid.enable();
};
/*
* Enables the row identified by the rowKey.
* ex) grid.enableRow(0, true);
*/
G_GRID.prototype.enableRow = function(rowKey, withCheckbox) {
    this.grid.enableRow(rowKey, withCheckbox);
};
/*
* Enables the row identified by the rowKey to be able to check.
* ex) grid.enableRowCheck(0);
*/
G_GRID.prototype.enableRowCheck = function(rowKey) {
    this.grid.enableRowCheck(rowKey);
};
/*
* Expands tree row
* ex) grid.expand(0, true);
*/
G_GRID.prototype.expand = function(rowKey, recursive) {
    this.grid.expand(rowKey, recursive);
};
/*
* Expands tree row
* ex) grid.expandAll();
*/
G_GRID.prototype.expandAll = function() {
    this.grid.expandAll();
};
/*
* trigger filter
* ex) grid.filter('name', [{code: 'eq', value: 3}, {code: 'eq', value: 4}]);
*/
G_GRID.prototype.filter = function(columnName, state) {
    this.grid.filter(columnName, state);
};
/*
* Finds rows by conditions
* ex) grid.findRows({
    artist: 'Birdy',
    price: 10000
});
      grid.findRows((row) => {
    return (/b/ig.test(row.artist) && row.price > 10000);
});
*/
G_GRID.prototype.findRows = function(conditions) {
    return this.grid.findRows(conditions);
};
/*
* Sets the value of the cell identified by the specified rowKey and columnName and finish editing the cell.
* ex) grid.finishEditing(0, 'artist','aaa');
*/
G_GRID.prototype.finishEditing = function(rowKey, columnName, value) {
    this.grid.finishEditing(rowKey, columnName, value);
};
/*
* Sets the value of the cell identified by the specified rowKey and columnName and finish editing the cell.
* RETURNS:{ Boolean } - true if focused cell is changed
* ex) grid.focus(0, 'artist',true);
*/
G_GRID.prototype.focus = function(rowKey, columnName, setScroll) {
    return this.grid.focus(rowKey, columnName, setScroll);
};
/*
* Sets the value of the cell identified by the specified rowKey and columnName and finish editing the cell.
* RETURNS:{ Boolean } - true if success
* ex) grid.focusAt(0, 0, true,true);
*/
G_GRID.prototype.focusAt = function(rowIndex, columnIndex, isScrollable, setScroll) {
    return this.grid.focusAt(rowIndex, columnIndex, isScrollable, setScroll);
};
/*
* Gets the ancestors of the row which has the given row key.
* RETURNS:{ Boolean } - true if success
* ex) grid.getAncestorRows(0);
*/
G_GRID.prototype.getAncestorRows = function(rowKey) {
    return this.grid.getAncestorRows(rowKey);
};
/*
* Returns a list of the rowKey of checked rows.
* RETURNS:{ Array.<undefined> } - A list of the rowKey.
* ex) grid.getCheckedRowKeys();
*/
G_GRID.prototype.getCheckedRowKeys = function() {
    return this.grid.getCheckedRowKeys();
};
/*
* Returns a list of the checked rows.
* RETURNS:{ Array.<object> } - A list of the checked rows.
* ex) grid.getCheckedRows();
*/
G_GRID.prototype.getCheckedRows = function() {
    return this.grid.getCheckedRows();
};
/*
* Gets the children of the row which has the given row key.
* RETURNS:{ Array.<Object> } - the children rows
* ex) grid.getChildRows(0);
*/
G_GRID.prototype.getChildRows = function(rowKey) {
    return this.grid.getChildRows(rowKey);
};
/*
* Returns a list of the column model.
* RETURNS:{ Array } - A list of the column model.
* ex) grid.getColumns();
*/
G_GRID.prototype.getColumns = function() {
    return this.grid.getColumns();
};
/*
* Returns a list of all values in the specified column.
* RETURNS:{ Arraystring } - A List of all values in the specified column. (or JSON string of the list)
* ex) grid.getColumnValues('city');
*/
G_GRID.prototype.getColumnValues = function(columnName) {
    return this.grid.getColumnValues(columnName);
};
/*
* Returns a list of all rows.
* RETURNS:{ Array } - A list of all rows
* ex) grid.getData();
*/
G_GRID.prototype.getData = function() {
    return this.grid.getData();
};
/*
* Gets the depth of the row which has the given row key.
* RETURNS:{ number } - the depth
* ex) grid.getDepth(0);
*/
G_GRID.prototype.getDepth = function(rowKey) {
    return this.grid.getDepth(rowKey);
};
/*
* Gets the descendants of the row which has the given row key.
* RETURNS:{ Array.<Object> } - the descendant rows
* ex) grid.getDescendantRows(0);
*/
G_GRID.prototype.getDescendantRows = function(rowKey) {
    return this.grid.getDescendantRows(rowKey);
};
/*
* Returns the HTMLElement of the cell identified by the rowKey and columnName.
* RETURNS:{ HTMLElement } - The HTMLElement of the cell element
* ex) grid.getElement(0, 'city');
*/
G_GRID.prototype.getElement = function(rowKey, columnName) {
    return this.grid.getElement(rowKey, columnName);
};
/*
* get filter state
* RETURNS:{ Array.<FilterState> } - filter state
* ex) grid.getFilterState();
*/
G_GRID.prototype.getFilterState = function() {
    return this.grid.getFilterState();
};
/*
* Returns data of currently focused cell
* RETURNS:{ numberstring } - rowKey - The unique key of the row
* ex) grid.getFocusedCell();
*/
G_GRID.prototype.getFocusedCell = function() {
    return this.grid.getFocusedCell();
};
/*
* Returns the index of the column indentified by the column name
* RETURNS:{ number } - The index of the column
* ex) grid.getIndexOfColumn('city');
*/
G_GRID.prototype.getIndexOfColumn = function(columnName) {
    return this.grid.getIndexOfColumn(columnName);
};
/*
* Returns the index of the column indentified by the column name
* RETURNS:{ number } - The index of the row
* ex) grid.getIndexOfRow(0);
*/
G_GRID.prototype.getIndexOfRow = function(rowKey) {
    return this.grid.getIndexOfRow(rowKey);
};
/*
* Returns the object that contains the lists of changed data compared to the original data.
* The object has properties 'createdRows', 'updatedRows', 'deletedRows'.
* RETURNS:{ Object } - Object that contains the result list.
* ex) grid.getModifiedRows({rowKeyOnly:true});
*/
G_GRID.prototype.getModifiedRows = function(options) {
    return this.grid.getModifiedRows(options);
};
/*
* Returns an instance of tui.Pagination.
* RETURNS:{ tui.<Pagination> }
* ex) grid.getPagination();
*/
G_GRID.prototype.getPagination = function() {
    return this.grid.getPagination();
};
/*
* Gets the parent of the row which has the given row key.
* RETURNS:{ Object } - the parent row
* ex) grid.getParentRow(0);
*/
G_GRID.prototype.getParentRow = function(rowKey) {
    return this.grid.getParentRow(rowKey);
};
/*
* Returns the object that contains all values in the specified row.
* RETURNS:{ Object } - The object that contains all values in the row.
* ex) grid.getRow(0);
*/
G_GRID.prototype.getRow = function(rowKey) {
    return this.grid.getRow(rowKey);
};
/*
* Returns the object that contains all values in the row at specified index.
* RETURNS:{ Object } - The object that contains all values in the row.
* ex) grid.getRowAt(0);
*/
G_GRID.prototype.getRowAt = function(rowKey) {
    return this.grid.getRowAt(rowKey);
};
/*
* Returns the total number of the rows.
* RETURNS:{ number } - The total number of the rows
* ex) grid.getRowCount();
*/
G_GRID.prototype.getRowCount = function() {
    return this.grid.getRowCount();
};
/*
* Returns the rowspan data of the cell identified by the rowKey and columnName.
* RETURNS:{ Object } - Row span data
* ex) grid.getRowSpanData(0, 'city');
*/
G_GRID.prototype.getRowSpanData = function(rowKey, columnName) {
    return this.grid.getRowSpanData(rowKey, columnName);
};
/*
* Gets state of the sorted column in rows
* RETURNS:{ Object } - Sorted column's state
* ex) grid.getSortState();
*/
G_GRID.prototype.getSortState = function() {
    return this.grid.getSortState();
};
/*
* Returns the values of given column summary.
* If the column name is not specified, all values of available columns are returned.
* The shape of returning object looks like the example below.
* RETURNS:{ Object } =>
* {
    sum: 1000,
    avg: 200,
    max: 300,
    min: 50,
    cnt: 5
   }
* ex) grid.getSummaryValues('city'); grid.getSummaryValues();
*/
G_GRID.prototype.getSummaryValues = function(columnName) {
    return this.grid.getSummaryValues(columnName);
};
/*
* Returns the value of the cell identified by the rowKey and columnName.
* RETURNS:{ numberstring } - The value of the cell
* ex) grid.getValue(0, 'city', true);
*     isOriginal [ boolean ] It set to true, the original value will be return.
*/
G_GRID.prototype.getValue = function(rowKey, columnName, isOriginal) {
    return this.grid.getValue(rowKey, columnName, isOriginal);
};
/*
* Hides columns
* ex) grid.hideColumn('city', ?);
*/
G_GRID.prototype.hideColumn = function(columnName, arguments) {
    this.grid.hideColumn(columnName, arguments);
};
/*
* Returns true if there are at least one row modified.
* RETURNS:{ boolean } - True if there are at least one row modified.
* ex) grid.isModified();
*/
G_GRID.prototype.isModified = function() {
    return this.grid.isModified();
};

G_GRID.prototype.getModifiedRows = function(options) {
	return this.grid.getModifiedRows(options);
};

G_GRID.prototype.getRow = function(rowKey) {
	return this.grid.getRow(rowKey);
};

G_GRID.prototype.getRowAt = function(rowIdx) {
	return this.grid.getRowAt(rowIdx);
};

G_GRID.prototype.getRowCount = function() {
	return this.grid.getRowCount();
};

G_GRID.prototype.getColumnValues = function(columnName) {
	return this.grid.getColumnValues();
};

G_GRID.prototype.getCheckedRows = function() {
	return this.grid.getCheckedRows();
};

G_GRID.prototype.getCheckedRowKeys = function() {
	return this.grid.getCheckedRowKeys();
};

G_GRID.prototype.dblclick = function() {
	return this.grid.dblclick();
};

G_GRID.prototype.click = function() {
	return this.grid.click();
};

G_GRID.prototype.mousedown = function() {
	return this.grid.mousedown();
};

G_GRID.prototype.setColumns = function(columns) {
	return this.grid.setColumns(columns);
};

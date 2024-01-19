// 공통 unformatter
// link unformatter
function linkUnFormatter(cellVal, options, cell) {
	return $('a', cell).text();
}

// grid load error
function girdLoadError() {
	toast('데이터를 가져오는 도중 에러가 발생하였습니다.');
}

//grid load error
function gridLoadError() {
	toast('데이터를 가져오는 도중 에러가 발생하였습니다.');
}

// cell에 변경 사항이 일어났을때 check박스에 check
function checkWhenColumnUpdated(gridName, id) {
	if(!$("#jqg_"+gridName+'_'+id).is(":checked"))
		$("#"+gridName).jqGrid('setSelection', id);
}


// gird date type validation
function validateDate(val) {
	var datePattern = new RegExp(/[0-9]{4}\-[0-9]{2}\-[0-9]{2}/g);
	
	if(!datePattern.test(val)) {
		return [false, "YYYY-MM-DD 형식으로 입력하세요.",""];
	} 
	return [true, "", ""];
}

// grid multi save
function saveGridSelected(gridName, type, mode, url, msg, success, fail) {					
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
		
		if(selRows.length==0) {
			if(mode=='save') {
				toast('저장할 항목을 선택하세요.');
			} else if(mode=='delete') {
				toast('삭제할 항목을 선택하세요.');
			} else {
				toast('항목을 선택하세요.');
			}
			return;
		}
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	var modeMsg = '';
	var successMsg = '';
	var failMsg = '';
	
	if(mode=='save') {
		modeMsg = '선택된 항목을 저장하시겠습니까?';
		successMsg = '저장에 성공하였습니다.';
		failMsg = '저장에 실패하였습니다.';
	} else if(mode=='delete') {
		modeMsg = '선택된 항목을 삭제하시겠습니까?';
		successMsg = '삭제에 성공하였습니다.';
		failMsg = '삭제에 실패하였습니다.';
	} else if(mode=='custom') {
		modeMsg = msg;
		successMsg = success;
		failMsg = fail;
	}
	
	if(confirm(modeMsg)) {
			
		$("#"+gridName).setGridParam({cellEdit:false});
		var colModel = $("#"+gridName).getGridParam('colModel');
		var gridData = [];
		
		for(var i=0; i<selRows.length; i++) {
			var rowData = $("#"+gridName).getRowData(selRows[i]);

			for(var j=0; j<colModel.length; j++) {
				
				var colData = rowData[colModel[j].name];
				
				if((typeof colData != "undefined") &&
						( colData.toLowerCase().indexOf("<input") >= 0 
						  || colData.toLowerCase().indexOf("<select") >= 0
						  || colData.toLowerCase().indexOf("<textarea") >= 0
						)
				) {
					toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
					$("#"+gridName).setGridParam({cellEdit:true});
					return;
				}
			}
			
			gridData.push(rowData);
		}
		
		var jsonData = JSON.stringify(gridData);
		
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {					
					if(data.msg != '' && data.msg !== undefined) {
						toast(data.msg);
					} else {
						toast(successMsg);
					}	
				} else if(data.code == '-1'){
					toast(failMsg);
				}
				else {
					toast(data.msg);	
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
			},
			error: function(jqXHR, textStatus, errorThrown) {
				//toast(failMsg+ ' ' + textStatus.msg);
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}	

// grid multi save
function saveGridSelected2(gridName, type, mode, url, msg, success, fail) {					
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
		
		if(selRows.length==0) {
			if(mode=='save') {
				toast('저장할 항목을 선택하세요.');
			} else if(mode=='delete') {
				toast('삭제할 항목을 선택하세요.');
			} else {
				toast('항목을 선택하세요.');
			}
			return;
		}
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	var modeMsg = '';
	var successMsg = '';
	var failMsg = '';
	
	if(mode=='save') {
		modeMsg = '선택된 항목을 저장하시겠습니까?';
		successMsg = '저장에 성공하였습니다.';
		failMsg = '저장에 실패하였습니다.';
	} else if(mode=='delete') {
		modeMsg = '선택된 항목을 삭제하시겠습니까?';
		successMsg = '삭제에 성공하였습니다.';
		failMsg = '삭제에 실패하였습니다.';
	} else if(mode=='custom') {
		modeMsg = msg;
		successMsg = success;
		failMsg = fail;
	}
	
	if(confirm(modeMsg)) {
			
		$("#"+gridName).setGridParam({cellEdit:false});
		var colModel = $("#"+gridName).getGridParam('colModel');
		var gridData = [];
		
		for(var i=0; i<selRows.length; i++) {
			var rowData = $("#"+gridName).getRowData(selRows[i]);

			for(var j=0; j<colModel.length; j++) {
				
				var colData = rowData[colModel[j].name];
				
				if((typeof colData != "undefined") &&
						( colData.toLowerCase().indexOf("<input") >= 0 
						  || colData.toLowerCase().indexOf("<select") >= 0
						  || colData.toLowerCase().indexOf("<textarea") >= 0
						)
				) {
					toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
					$("#"+gridName).setGridParam({cellEdit:true});
					return;
				}
			}
			
			gridData.push(rowData);
		}
		
		var jsonData = JSON.stringify(gridData);
		
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {					
					toast(successMsg);
				} else {
					toast(failMsg);
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}	

// grid multi save
function saveGridSelectedContainer(gridName, type, mode, url, msg, success, fail) {					
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
		
		if(selRows.length==0) {
			if(mode=='save') {
				toast('컨테이너에 입고할 화물을 선택하세요.');
			} else if(mode=='delete') {
				toast('창고로 내릴 화물을 선택하세요.');
			} else {
				toast('항목을 선택하세요.');
			}
			return;
		}
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	var modeMsg = '';
	var successMsg = '';
	var failMsg = '';
	
	if(mode=='save') {
		modeMsg = '선택된 항목을 저장하시겠습니까?';
		successMsg = '저장에 성공하였습니다.';
		failMsg = '저장에 실패하였습니다.';
	} else if(mode=='delete') {
		modeMsg = '선택된 항목을 삭제하시겠습니까?';
		successMsg = '삭제에 성공하였습니다.';
		failMsg = '삭제에 실패하였습니다.';
	} else if(mode=='custom') {
		modeMsg = msg;
		successMsg = success;
		failMsg = fail;
	}
	
	if(confirm(modeMsg)) {
			
		$("#"+gridName).setGridParam({cellEdit:false});
		var colModel = $("#"+gridName).getGridParam('colModel');
		var gridData = [];
		
		for(var i=0; i<selRows.length; i++) {
			var rowData = $("#"+gridName).getRowData(selRows[i]);

			for(var j=0; j<colModel.length; j++) {
				
				var colData = rowData[colModel[j].name];
				
				if((typeof colData != "undefined") &&
						( colData.toLowerCase().indexOf("<input") >= 0 
						  || colData.toLowerCase().indexOf("<select") >= 0
						  || colData.toLowerCase().indexOf("<textarea") >= 0
						)
				) {
					toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
					$("#"+gridName).setGridParam({cellEdit:true});
					return;
				}
			}
			
			gridData.push(rowData);
		}
		
		var jsonData = JSON.stringify(gridData);
		
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code != '0') {					
					if(data.msg != '' && data.msg !== undefined) {
						toast(data.msg);
					} else {
						toast(successMsg);
					}	
				} else if(data.code == '-1'){
					toast(failMsg);
				}
				else {
					toast(data.msg);	
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
			},
			error: function(jqXHR, textStatus, errorThrown) {
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}	

function saveGridSelectedByPushLayer(gridName, type, mode, url, msg, success, fail) {					
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
		
		if(selRows.length==0) {
			if(mode=='save') {
				toast('저장할 항목을 선택하세요.');
			} else if(mode=='delete') {
				toast('삭제할 항목을 선택하세요.');
			} else {
				toast('항목을 선택하세요.');
			}
			return;
		}
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	var modeMsg = '';
	var successMsg = '';
	var failMsg = '';
	
	if(mode=='save') {
		modeMsg = '선택된 항목을 저장하시겠습니까?';
		successMsg = '저장에 성공하였습니다.';
		failMsg = '저장에 실패하였습니다.';
	} else if(mode=='delete') {
		modeMsg = '선택된 항목을 삭제하시겠습니까?';
		successMsg = '삭제에 성공하였습니다.';
		failMsg = '삭제에 실패하였습니다.';
	} else if(mode=='custom') {
		modeMsg = msg;
		successMsg = success;
		failMsg = fail;
	}
	
	if(confirm(modeMsg)) {
			
		$("#"+gridName).setGridParam({cellEdit:false});
		var colModel = $("#"+gridName).getGridParam('colModel');
		var gridData = [];
		
		for(var i=0; i<selRows.length; i++) {
			var rowData = $("#"+gridName).getRowData(selRows[i]);

			for(var j=0; j<colModel.length; j++) {
				
				var colData = rowData[colModel[j].name];
				
				if((typeof colData != "undefined") &&
						( colData.toLowerCase().indexOf("<input") >= 0 
						  || colData.toLowerCase().indexOf("<select") >= 0
						  || colData.toLowerCase().indexOf("<textarea") >= 0
						)
				) {
					toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
					$("#"+gridName).setGridParam({cellEdit:true});
					return;
				}
			}
			
			gridData.push(rowData);
		}
		
		var jsonData = JSON.stringify(gridData);
		
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					if(data.msg != '' && data.msg !== undefined) {
						toast(data.msg);
					} else {
						toast(successMsg);
					}	
				} else if(data.code == '-1'){
					toast(failMsg);
				}
				else {
					toast(data.msg);	
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
				
				$("#tabBtn3").trigger("click");

			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}

function getGridDataToJson(gridName, type) {	
	
	$("#"+gridName).editCell(0,0,false); 
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();		
	}	
	
	$("#"+gridName).setGridParam({cellEdit:false});
	var colModel = $("#"+gridName).getGridParam('colModel');
	var gridData = [];
	
	for(var i=0; i<selRows.length; i++) {
		var rowData = $("#"+gridName).getRowData(selRows[i]);

		for(var j=0; j<colModel.length; j++) {
			
			var colData = rowData[colModel[j].name];
			
			if((typeof colData != "undefined") &&
					( colData.toLowerCase().indexOf("<input") >= 0 
					  || colData.toLowerCase().indexOf("<select") >= 0
					  || colData.toLowerCase().indexOf("<textarea") >= 0
					)
			) {
				toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
				$("#"+gridName).setGridParam({cellEdit:true});
				return false;
			}
		}
		
		gridData.push(rowData);
	}
		
	return gridData;

}

function getGridDataToJson2(gridName, type) {					
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	$("#"+gridName).setGridParam({cellEdit:false});
	var colModel = $("#"+gridName).getGridParam('colModel');
	var gridData = [];
	
	for(var i=0; i<selRows.length; i++) {
		var rowData = $("#"+gridName).getRowData(selRows[i]);

		for(var j=0; j<colModel.length; j++) {
			
			var colData = rowData[colModel[j].name];
			
			if((typeof colData != "undefined") &&
					( (colData.toLowerCase().indexOf("<input") >= 0 && colData.toLowerCase().indexOf("button") == -1) 
					  || colData.toLowerCase().indexOf("<select") >= 0
					  || colData.toLowerCase().indexOf("<textarea") >= 0
					)
			) {
				toast('편집중인 항목이 있습니다. 편집모드를 종료하세요.');
				$("#"+gridName).setGridParam({cellEdit:true});
				return false;
			}
		}
		
		gridData.push(rowData);
	}
		
	return gridData;

}

function getGridDataToString(gridName, type) {		
	return JSON.stringify(getGridDataToJson(gridName, type));
}

function getGridDataToString2(gridName, type) {					
	return JSON.stringify(getGridDataToJson2(gridName, type));
}

//선택한 grid 삭제 
function deleteGridSelected(gridName, type, url) {
	$("#"+gridName).editCell(0,0,false); 
	
	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}
	
	var modeMsg = '선택된 항목을 삭제하시겠습니까?';
	var successMsg = '삭제에 성공하였습니다.';
	var failMsg = '삭제에 실패하였습니다.';
	
	var num = selRows.length;
	var gridData = [];
	if(confirm(modeMsg)) {
		for(var i=num; i>0; i--) {
			var rowData = $("#"+gridName).jqGrid('getRowData',selRows[i-1]);
			if(rowData.CRUD == "C")
				$("#"+gridName).jqGrid('delRowData',selRows[i-1]);
			else
				gridData.push(rowData);
		}
	}
	
	if( gridData.length > 0){
		var jsonData = JSON.stringify(gridData);
	
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					toast(successMsg);
				// 메시지를 따로 정의해서 출력할 필요가 있을때 사용 (2013.11.07 최영호)
				} else if(data.code == '-1'){
					toast(failMsg);
				}
				else {
					toast(data.msg);	
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}

//grid multi save(edit mode check 변경)
function saveGridSelected2(gridName, type, mode, url, msg, success, fail) {		
	$("#"+gridName).editCell(0,0,false); 

	var selRows;
	if(type == 'selected') {
		selRows = $("#"+gridName).getGridParam('selarrrow');
		
		if(selRows.length==0) {
			if(mode=='save') {
				toast('저장할 항목을 선택하세요.');
			} else if(mode=='delete') {
				toast('삭제할 항목을 선택하세요.');
			} else {
				toast('항목을 선택하세요.');
			}
			return;
		}
	} else if(type == 'all'){
		selRows = $("#"+gridName).getDataIDs();
	}	
	
	var modeMsg = '';
	var successMsg = '';
	var failMsg = '';
	
	if(mode=='save') {
		modeMsg = '선택된 항목을 저장하시겠습니까?';
		successMsg = '저장에 성공하였습니다.';
		failMsg = '저장에 실패하였습니다.';
	} else if(mode=='delete') {
		modeMsg = '선택된 항목을 삭제하시겠습니까?';
		successMsg = '삭제에 성공하였습니다.';
		failMsg = '삭제에 실패하였습니다.';
	} else if(mode=='custom') {
		modeMsg = msg;
		successMsg = success;
		failMsg = fail;
	}
	
	if(confirm(modeMsg)) {
			
		var colModel = $("#"+gridName).getGridParam('colModel');
		var gridData = [];
		
		for(var i=0; i<selRows.length; i++) {
			
			//select 빼고 1부터 check
			for(var j=1; j<colModel.length; j++) {
				if($("#"+gridName+" tr#"+selRows[i]+" td:eq("+j+")").hasClass("edit-cell")){
					$("#"+gridName).jqGrid("saveCell",selRows[i],j);
				}
			}
			
			var rowData = $("#"+gridName).getRowData(selRows[i]);
			gridData.push(rowData);
		}
		
		var jsonData = JSON.stringify(gridData);
		
		$.ajax({
			type: "POST",
			url: url,
			data: jsonData,
			dataType: 'json',
			contentType: 'application/json; charset=utf-8',
			success: function(data) {
				if(data.code == '0') {
					if(data.msg != '' && data.msg !== undefined) {
						toast(data.msg);
					} else {
						toast(successMsg);
					}	
				// 메시지를 따로 정의해서 출력할 필요가 있을때 사용 (2013.11.07 최영호)
				} else if(data.code == '-1'){
					toast(failMsg);
				}
				else {
					toast(data.msg);	
				}
				
				$("#"+gridName).setGridParam({cellEdit:true});
				$("#"+gridName).jqGrid("clearGridData").jqGrid('setGridParam',{datatype:'json'});
				$("#"+gridName).trigger("reloadGrid");
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);
				$("#"+gridName).setGridParam({cellEdit:true});
			}
		});
	}
}	

/**
 * 그리드 내 sorting 및 paging 처리를 위한 function
 */
function setSortingGridData(obj, data) {
		var $this = $(obj);
	    if ($this.jqGrid('getGridParam', 'datatype') === 'json') {

	    	$this.jqGrid('setGridParam', {
	            datatype: 'local',
	            data: data.rows,
	            pageServer: data.page,
	            recordsServer: data.records,
	            lastpageServer: data.total
	        });

	    	obj.refreshIndex();

	        if ($this.jqGrid('getGridParam', 'sortname') !== '') {

	        	$('#gview_'+$this.attr('id')).find('.s-ico').hide();
	        	$this.jqGrid('setGridParam', {sortname:'', lastsort:0}); 
//	        	$this.triggerHandler('reloadGrid');
	        	
	        }
	    } else {
	    	
	        $this.jqGrid('setGridParam', {
	            page: $this.jqGrid('getGridParam', 'pageServer'),
	            records: $this.jqGrid('getGridParam', 'recordsServer'),
	            lastpage: $this.jqGrid('getGridParam', 'lastpageServer')
	        });
	        obj.updatepager(false, true);
	    }

}

function codeLinkFormatter_old(cellVal, options, rowObj) {
    
    var cellval = String(cellVal);
    
    cellval = '<a style="color:red;" href="javascript:searchContentsData(\'' + rowObj['code_cd'] + '\');" cellVal="'+ rowObj['code_cd'] +'">'+cellval+'</a>';                              
    
    return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
}
 
function apprCdFormatter(cellVal, options, rowObj) {

    var cellval = String(cellVal);
	var fontColor = 'black';
	var apprNm = '';
	
	
    switch(cellVal) {
	    case "10601":
	    	fontColor = "black";
	    	apprNm = "신청";
	        break;
	    case "10602":
	    	fontColor = 'blue';
	    	apprNm = '승인';
	        break;
	    case "10603":
	    	fontColor = "red";
	    	apprNm = "반려";
	        break;
	    default:
	    	fontColor = "black";
	    	apprNm = "신청";
	    break;
	}

    cellval = '<span style="color:' + fontColor + ';">' + apprNm + '</span>';                              
    
    return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
}

function stsCdFormatter(cellVal, options, rowObj) {

    var cellval = String(cellVal);
	var fontColor = 'black';
	var apprNm = '';
	
    switch(cellVal) {
	    case "10701":
	    	fontColor = "black";
	    	apprNm = "접수";
	        break;
	    case "10702":
	    	fontColor = 'green';
	    	apprNm = '진행예정';
	        break;
	    case "10703":
	    	fontColor = "red";
	    	apprNm = "진행중";
	        break;
	    case "10704":
	    	fontColor = "blue";
	    	apprNm = "완료";
	        break;
	    default:
	    	fontColor = "black";
	    	apprNm = "접수";
	    break;
	}

    cellval = '<span style="color:' + fontColor + ';">' + apprNm + '</span>';                              
    
    return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
}


function codeUnLinkFormatter(cellVal, options, rowObj) {
    
    var cellval = String(cellVal);
    
    cellval = '<a style="color:blue;" href="javascript:searchContentsData(\'' + rowObj['code_cd'] + '\');" cellVal="'+ rowObj['code_cd'] +'">'+cellval+'</a>';                              
    
    return  cellval === "" ? $.fn.fmatter.defaultFormat(cellval,options) : cellval;
 }


function idColorFmt( rowId, tv, rawObject, cm, rdata) {

	console.log('rawObject.appr_cd',rawObject.appr_cd);
	

	
    switch( rawObject.appr_cd) {
        case 1:
            return 'style="background-color:#58D3F7"';
            break;
        case 2:
            return 'style="background-color:#E0F2F7"';
            break;
        case 3:
            return 'style="background-color:white"';
            break;
        default:
        	return 'style="background-color:red"';
        break;
    }
    return  'style="background-color:red"';
}


var apprFmt = function (rowId, tv, rowObject, cm, rdata){

	switch(rowObject.appr_cd) {
	    case "10601":
	    	return ' style="color:gray;"';
	        break;
	    case "10602":
	    	return ' style="color:blue;"';
	        break;
	    case "10603":
	    	return ' style="color:red;"';
	        break;
	    default:
	    	return ' style="color:gray;"';
	    break;
	}
	
	return ' style="color:gray;"' ;
}

var stsFmt = function (rowId, tv, rowObject, cm, rdata){

	switch(rowObject.sts_cd) {
	    case "10701":
	    	return ' style="color:gray;"';
	        break;
	    case "10702":
	    	return ' style="color:green;"';
	        break;
	    case "10703":
	    	return ' style="color:red;"';
	        break;
	    case "10704":
	    	return ' style="color:blue;"';
	        break;
	    default:
	    	return ' style="color:gray;"';
	    break;
	}
	
	return ' style="color:gray;"' ;
}


	$(document).ready(function() {

		
		jQuery("#tmsGrid").jqGrid({
			url:'/system/tms/tmsListJson',
			datatype: "local",				   
			colNames:['구분1', '구분2', '프로그램명', '프로그램url', 'comment', '승인상태', '진행상태', '등록일', '작업시작일','완료예정일', '작업완료일','tms_no'],
			colModel:[
				{name:'part1'     , index:'part1'     , width:90, align:"left"  , sortable:true, editable:true},
				{name:'part2'     , index:'part2'     , width:90, align:"left"  , sortable:true, editable:true},
				{name:'title'     , index:'title'     , width:280, align:"left"  , sortable:true, editable:true},
				{name:'pg_url'     , index:'pg_url'     , width:200, align:"left"  , sortable:true, editable:true},
				{name:'comment'     , index:'comment'     , width:200, align:"left" , sortable:true, editable:true},
				{name:'appr_cd'    , index:'appr_cd'    , width:90, align:"center", sortable:true, editable:true,cellattr: apprFmt, formatter:"select", edittype:"select", editoptions:{value:apprCodeList}},
				{name:'sts_cd'    , index:'sts_cd'    , width:90, align:"center", sortable:true, editable:true,cellattr: stsFmt, formatter:"select", edittype:"select", editoptions:{value:stsCodeList}},
				{name:'reg_dt' , index:'reg_dt' , width:100, align:"center", sortable:true, editable:true},
				{name:'start_dt' , index:'start_dt' , width:100, align:"center", sortable:true, editable:true},
				{name:'due_dt' , index:'due_dt' , width:100, align:"center", sortable:true, editable:true},
				{name:'finish_dt' , index:'finish_dt' , width:100, align:"center", sortable:true, editable:true},
				{name:'tms_no'     , index:'tms_no'     , width:90, align:"left"  , sortable:true, editable:false, hidden:true}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:1000,	   	
			rowList:[20,50,1000],
			height: 2000,
			sortname: 'staff_id',
		    viewrecords: true,
		    //sortorder: "asc",		
		    //shrinkToFit:false, 
			cellsubmit : 'clientArray',
			cellEdit : true,
			gridview:true,
			editable:true,
			multiselect : true,
			pager: '#pager1',
			// 서버에러시 처리
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
			// 데이터 로드 완료 후 처리 
		    loadComplete: function(data) {
		    	setSortingGridData(this, data);
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#tmsGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    // 그리드 부가 파라미터 정보
		    postData : serializeObject($('#searchForm'))
		});

		jQuery("#tmsGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/system/staff/staffDetailPop?type=modify&staff_id=' + rowObj['staff_id'] + '\', \'open\', \'900\', \'535\', \'scrollbars=no, status=no\');">'+cellVal+'</a>';
			return linkURL;
		}
		
		// Link 처리 unformatter
		function linkUnFormatter(cellVal, options, cell) {
			return $('a', cell).text();
		}
		
		// 로그인ID/TMS명/핸드폰번호 입력폼에서 엔터입력 시 검색
		$('#login_id, #staff_nm, #mobil_txt').keydown(13, function(event) {
			if (event.keyCode == 13) {
				$("#btnSearch").click();
			}
		});
		
//		$("#btnSearch").click( function(){
//			//if(checkTermSearch("lastlogin_dt_s", "lastlogin_dt_e", "최종로그인일자")){
//				$('#tmsGrid').clearGridData();
//				$("#searchForm").submit();
//			//}
//		});
				
		// jQuery validation
		$("#searchForm").validate({
			rules: {
				login_id: {maxlength: 20},
				staff_nm: {maxlength: 30},
				mobil_txt: {maxlength: 20},
				lastlogin_dt_s: {dpDate: true},
				lastlogin_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#lastlogin_dt_s'}}
			},
			messages: {
				login_id: {maxlength: jQuery.format("로그인ID는 최대 {0} 글자 이하로 입력하세요.")},
				staff_nm: {maxlength: jQuery.format("TMS명은 최대 {0} 글자 이하로 입력하세요.")},
				mobil_txt: {maxlength: jQuery.format("핸드폰번호는 최대 {0} 글자 이하로 입력하세요.")},
				lastlogin_dt_s: {dpDate: "최종 로그인 시작일자는 yyyy-mm-dd 형식으로 입력하세요."},
				lastlogin_dt_e: {dpDate: "최종 로그인 종료일자는 yyyy-mm-dd 형식으로 입력하세요.",
						dpCompareDate: "최종 로그인 일자 검색 종료일은 시작일과 같거나 이후 일자를 선택하세요."}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#tmsGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm'))
				});
				$("#tmsGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#tmsGrid").trigger("reloadGrid");
			}
		});
		
		// 초기화
		$("#btnReset").click( function() {	
			$("#searchForm")[0].reset();
			/*방법2 - 문서에 있는 모든 form을 리셋
			$("form".each(function(){
				this.reset();
			});*/
		});	
		
		$("#btnAdd").click( function() {
			fn_f9();
		});
		
		$("#btnDel").click(function (){
			fn_f11();
		});
		
		$("#btnSaveTms").click(function (){
			saveGridSelected("tmsGrid", 'selected', 'save', "/system/tms/updateTmsListJson");
		});
		
		
		// 오늘
		$("#btnToday").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "today");
			event.preventDefault();
		});
		
		// 1주일
		$("#btnWeek").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "weekago");
			event.preventDefault();
		});
		
		// 1개월
		$("#btnMonth").click(function(event) {
			setSearchDate("lastlogin_dt_s", "lastlogin_dt_e", "monthago");
			event.preventDefault();
		});
		
		$("#btnVendor").click(function(event) {
			openPop(1);
			event.preventDefault();
		});
		
	});
	
	function jsRefresh(){
		$("#tmsGrid").setGridParam({
			datatype: "json",
			page : 1
		});
		$("#tmsGrid").trigger("reloadGrid");
	}
	
	function setVendorData(Data){
		$("#vendor_nm").val(Data[0].vendor_nm);
		$("#vendor_no").val(Data[0].vendor_no);
	}
	
	function fnSearch(){
		$('#tmsGrid').clearGridData();
		$("#searchForm").submit();
	}
	
	function fn_f3(){
		$('#tmsGrid').clearGridData();
		$("#searchForm").submit();
	}
	
	function fn_f9(){
		CenterOpenWindow('/system/tms/tmsDetail', 'TMS등록', '900','425', 'scrollbars=no, status=yes');
	}
	
	function fn_f10(){
		saveGridSelected("tmsGrid", 'selected', 'save', "/system/tms/updateTmsListJson");
	}
	
	function fn_f11(){
		saveGridSelected("tmsGrid", 'selected', 'delete', "/system/tms/deleteTmsListJson");
	}
	
	
	
	
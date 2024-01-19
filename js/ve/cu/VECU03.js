	$(document).ready(function() {


	    jQuery("#memberList").jqGrid({
	  		url:'/system/staff/staffListJson',
	  		datatype: "local",				   
	  		colNames:['staff_id','담당업무', '직책', '성명', '아이디', '핸드폰','E-Mail'],
	  		colModel:[
				{name:'staff_id'	, index:'staff_id', 	width:90, hidden:true},
	  			{name:'job_nm'		, index:'job_nm', 		width:50, align:"left", sortable:true, editable:false},
	  			{name:'position_nm'	, index:'position_nm', 	width:40, align:"left", sortable:true, editable:false},
	  			{name:'staff_nm'	, index:'staff_nm', 	width:50, align:"left", sortable:true, editable:false},
	  			{name:'login_id'	, index:'login_id', 	width:90, align:"left", sortable:true, editable:false},
	  			{name:'mobile_txt'	, index:'mobile_txt', 	width:90, align:"left", sortable:true, editable:false},
	  			{name:'email_txt'	, index:'email_txt', 	width:120, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 140,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {},

			postData : {
				vendor_no:function() {
					return $("#vendor_no").val();
				},
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	//checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});
	    
	    $("#memberList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    jQuery("#orderList").jqGrid({
	  		url:'/order/orderListJson',
	  		datatype: "local",				   
	  		colNames:['ord_no','기간', '회사', 'CT'],
	  		colModel:[
				{name:'ord_no'	, index:'ord_no', 	width:90, hidden:true},
	            { name: 'booking_summary', 	index: 'booking_summary', 	align: 'left',		sortable: true, width: '300', formatter : linkFormatter},
	            { name: 'customer_company',	index: 'customer_company',	align: 'center',	sortable: true, width: '350', formatter : linkFormatter2},
	  			{name:'box_qty'	, index:'box_qty', 	width:60, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {},

			postData : {
				vendor_no:function() {
					return $("#vendor_no").val();
				},
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	//checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});

	    
	    $("#orderList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    jQuery("#partnerList").jqGrid({
	  		url:'/partner/partnerListJson',
	  		datatype: "local",				   
	  		colNames:['vendor_no','구분', '코드', '회사명'],
	  		colModel:[
				{name:'vendor_no'	, index:'vendor_no', 	width:90, hidden:true},
				{name:'vendor_typ_nm'	, index:'vendor_typ_nm', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_no'	, index:'vendor_no', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_nm'	, index:'vendor_nm', 	width:280, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {},

			postData : {
				vendor_no:function() {
					return $("#vendor_no").val();
				},
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	//checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});

	    
	    $("#partnerList").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    jQuery("#customerList5").jqGrid({
	  		url:'/partner/customerListJson',
	  		datatype: "local",				   
	  		colNames:['vendor_no','코드', '창고명'],
	  		colModel:[
				{name:'vendor_no'	, index:'vendor_no', 	width:90, hidden:true},
				{name:'vendor_no'	, index:'vendor_no', 	width:60, align:"left", sortable:true, editable:false},
				{name:'vendor_nm'	, index:'vendor_nm', 	width:280, align:"left", sortable:true, editable:false},
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		height: 200,
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
// 	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {},

			postData : {
				vendor_no:$("#vendor_no").val(),
				vendor_typ:'5',
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	//checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});

	    
	    $("#customerList5").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
	    
	    
	    
	    
	    $("#btnCompModify").on("click", function(){
			CenterOpenWindow('/partner/partnerListPop.do?vendor_no=' + vendor_no, '수신인 선택', '1280','800', 'scrollbars=no, status=yes');
	    });
	    
	});
		
	function linkFormatter(cellVal, options, rowObj) {
		var linkURL = '';
 		linkURL += '<a href="javascript:CenterOpenWindow(\'/cu/or/CUOR01/popup' + '?ord_no=' + rowObj['ord_no'] + '&vendor_no=' + vendor_no + '\', \'open\', \'1280\', \'780\', \'scrollbars=yes, status=no\');">';
				
		if(rowObj['transport_way_nm'] != null) linkURL += rowObj['transport_way_nm'];
		
		linkURL += '      ' + rowObj['start_dt'].substr(5,5) + '(' + rowObj['send_region_nm'] + ')';
		linkURL += ' ~ ' + rowObj['arrive_dt'].substr(5,5) + '(' + rowObj['receive_region_nm'] + ')';
		linkURL += '</a>';
				
		return linkURL;
	}
	
	function linkFormatter2(cellVal, options, rowObj) {
		var linkURL = '';
		
		linkURL = rowObj['send_nm'];
		linkURL += ' ~ ' + rowObj['receive_nm'];
				
		return linkURL;
	}
	
	
	
	
	
	
	$(document).ready(function(){
		
		$("#btnBack").on("click",function(){
			
			location.href="/partner/partnerList?menu_id=10184&screen_id=&menu_nm=고객현항&js_url=";
		});
		
		
		
		$("#btnConnection").click( function() {
			//CenterOpenWindow('/system/staff/staffSnsPop?type=add&staff_typ=2&vendor_no='+vendor_no, 'SNS등록', '800','260', 'scrollbars=no, status=yes');
		});
		
	});
	
	
	
	
	
	
	
	
	
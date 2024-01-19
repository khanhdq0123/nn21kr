


		$(document).ready(function() {
						
			jQuery("#list1").jqGrid({
				url:'/ad/ms/ADMS01/search',
//				datatype: "json",				   
				datatype: "local",				   
				colNames:['msg_no','Type1','Type2','Target','Lang', 'Message'],
				colModel:[
					{name:'msg_no',			index:'msg_no',			hidden:true}, 
					{name:'msg_typ1',		index:'msg_typ1',		width:100,	align:"center"},
					{name:'msg_typ2',		index:'msg_typ2',		width:50,	align:"center"},
					{name:'msg_target',		index:'msg_target',		width:50,	align:"center"},
					{name:'msg_lan',		index:'msg_lan',		width:50,	align:"center"},
					{name:'msg_content',	index:'msg_content',	width:300,	align:"left", formatter : linkFormatter}
				],
				mtype:"post",
				//autowidth: true,	// 부모 객체의 width를 따른다
				rowNum:500,	   	
				//rowList:[20,50,100],
				height: 400,
				// pager: '#pager1',
				pager: '',
			    //viewrecords: true,	
			    multiselect : true,
// 			    cellEdit : true,
				cellsubmit : 'clientArray',
				gridview: true,
				// 서버에러시 처리
				loadError : function(xhr,st,err) {
					girdLoadError();
			    },				    
			    // 데이터 로드 완료 후 처리 
			    loadComplete: function(data) {
			    	setSortingGridData(this, data);
			    }, 
			    // 그리드 부가 파라미터 정보
			    postData : serializeObject($('#searchForm')),
			 	// cell이 변경되었을 경우 처리
			    afterSaveCell : function(id, name, val, iRow, iCol) {
			    	checkWhenColumnUpdated("list1", id);
			    }		
			});


			$("#searchForm").validate({
				debug : true,
				rules : {		
					regdt_from:{
						dpDate:true
					},
					regdt_to:{
						dpDate:true,
						dpCompareDate:{notBefore:'#regdt_from'}
					}
				},
				messages: { 
					regdt_from:{
						dpDate: '등록 시작일자는 yyyy-mm-dd 형식으로 입력하세요.'
					},
					regdt_to:{
						dpDate: '등록 종료일자는 yyyy-mm-dd 형식으로 입력하세요.',
						dpCompareDate: '등록 종료일은 시작일보다 같거나 이후 일자를 선택하세요.'
					}	
				},
				onfocusout:false,
				invalidHandler: function(form, validator) {
					showValidationError(form, validator);               
	            },
				errorPlacement: function(error, element) {
					// nothing
				},
				submitHandler: function(form) {		
					$("#list1").setGridParam({
						page : 1,
						postData : serializeObject($('#searchForm'))
					});
					$("#list1").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				}
			});
			
			$('#btnDelete').click(function (){
				fn_deleteMsg();
			});
			
			$('#btnNew').click(function (){
				fn_newMsg();
			});
			
			
			
			


		});	
		
	function linkFormatter(cellVal, options, rowObj) {
		var msg_no = rowObj['msg_no'];
		var msg_typ1 = rowObj['msg_typ1'];
		var msg_typ2 = rowObj['msg_typ2'];
		var msg_target = rowObj['msg_target'];
		var msg_lan = rowObj['msg_lan'];
		var msg_content = rowObj['msg_content'];

		var linkURL = "<a href=\"javascript:fn_setInfo(\'" + msg_no + "\'";
		linkURL += ",\'" + msg_typ1 + "\'" ;
		linkURL += ",\'" + msg_typ2 + "\'" ;
		linkURL += ",\'" + msg_target + "\'" ;
		linkURL += ",\'" + msg_lan + "\'" ;
		linkURL += ",\'" + msg_content + "\'" ;
		linkURL += ")\">" + cellVal + "</a>";
		return linkURL;
	}		
	
	
	function fn_setInfo(msg_no,msg_typ1,msg_typ2,msg_target,msg_lan,msg_content){
		
		$("#msg_no").val(msg_no);

		$("#msg_typ1").val(msg_typ1);


		$(":radio[name='msg_typ2'][value='" + msg_typ2 + "']").prop('checked', true);
		$(":radio[name='msg_target'][value='" + msg_target + "']").prop('checked', true);
		$(":radio[name='msg_lan'][value='" + msg_lan + "']").prop('checked', true);

		
		
		$("#msg_content").val(msg_content);
		
	}
		
	function fn_newMsg(){
		$("#msg_no").val("");
		$("#msg_typ1").val("1");
		$(":radio[name='msg_typ2'][value='A']").prop('checked', true);
		$(":radio[name='msg_target'][value='S']").prop('checked', true);
		$(":radio[name='msg_lan'][value='EN']").prop('checked', true);
		$("#msg_content").val("");
	}	
		
		
		
	function fn_f3(){
		fn_newMsg();
		$('#list1').clearGridData();
		$("#searchForm").submit();
		
	}
	
	function fn_f9(){
		//CenterOpenWindow('/partner/joinMembership2', 'open', '1200', '720', 'scrollbars=yes, status=no');
	}
		
		
	function fn_f10(){
		
		
		if($("#msg_content").val() == ''){
			toast('메세지를 입력하세요');
			return false;
		}
		
		var msg_no = $("#msg_no").val();
		var actUrl = (msg_no == '') ? "/ad/ms/ADMS01/insert" : "/ad/ms/ADMS01/update";
		
		$.ajax({
			type: "POST",
			url: actUrl,
			data: $("#inputForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != 0){
					toast('저장 되었습니다.');
					fn_f3();
				} else {
					toast('저장이 실패되었습니다.');
				}
			}
		});
	}
	
	
	
	function fn_deleteMsg(){
		$.ajax({
			type: "POST",
			url: "/ad/ms/ADMS01/delete",
			data: $("#inputForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				if(data.code != 0){
					toast('삭제 되었습니다.');
					fn_f3();
				} else {
					toast('삭제가 실패되었습니다.');
				}
			}
		});
	}
		
		
		
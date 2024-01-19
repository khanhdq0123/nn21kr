<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>단가항목 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	$(document).ready(function() {
		fnPriceList();
		
		fnEventBind();
		
		jQuery("#plGrid").jqGrid({
			url:'/priceList/plMapListJson',
			datatype: "local",				   
			colNames:['청구대상코드','상위항목코드', '상위항목명', '항목코드', '항목명','정렬순서','CRUD'],
			colModel:[
				{name:'pl_typ'		 , index:'pl_typ'		, width:60, align:"center", sortable:true, editable:false},
				{name:'uptag_no'		 , index:'uptag_no'		, width:60, align:"center", sortable:true, editable:false},
				{name:'uptag_nm'		 , index:'uptag_nm'		, width:200, align:"center", sortable:true, editable:false},
				{name:'tag_no'		 , index:'tag_no'		, width:60, align:"center", sortable:true, editable:false},
				{name:'tag_nm'		 , index:'tag_nm'		, width:150, align:"center", sortable:true, editable:false},
				{name:'sort_seq'		 , index:'sort_seq'		, width:200, align:"center", sortable:true, editable:false,hidden:true},
				{name:'CRUD'		 , index:'CRUD'		, width:200, align:"center", sortable:true, editable:false,hidden:true}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,
// 			rowList:[10,30,50],
			height: 260,
		    viewrecords: true,
		    sortname: 'code_cd',
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
			gridview:true,
			editable:true,
			pager: '#pager1',
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
		    loadComplete: function(data) {
		    	setSortingGridData(this, data);
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#plGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    postData : serializeObject($('#gForm')),
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("plGrid", id);
		    }
		});

		jQuery("#plGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
		
		
		// jQuery validation
		$("#gForm").validate({
			rules: {
				login_id: {maxlength: 20},
				staff_nm: {maxlength: 30},
				mobil_txt: {maxlength: 20},
				lastlogin_dt_s: {dpDate: true},
				lastlogin_dt_e: {dpDate: true, dpCompareDate:{notBefore: '#lastlogin_dt_s'}}
			},
			messages: {
				login_id: {maxlength: jQuery.format("로그인ID는 최대 {0} 글자 이하로 입력하세요.")},
				staff_nm: {maxlength: jQuery.format("운영자명은 최대 {0} 글자 이하로 입력하세요.")},
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
				$("#plGrid").setGridParam({
					page : 1,
					postData : serializeObject($('#gForm'))
				});
				$("#plGrid").jqGrid('setGridParam',{datatype:'json'}).trigger("reloadGrid");
				//$("#staffGrid").trigger("reloadGrid");
			}
		});
		

		
	});

	
	
	function fnEventBind(){
		
		//청구대상구분 클릭시
		$("input[name=rd_pl_typ]").on("click",function(){
			$("#pl_typ").val($(this).val());
			//fnGridView();
			$('#plGrid').clearGridData();	
			
			$("#gForm").submit();
		});

		//저장
		$("#BTN_Save").on("click", function(){
			saveGridSelected("plGrid", 'selected', 'save', "/priceList/savePlMapListJson");
		});
		
		
		//삭제
		$("#BTN_Delete").on("click", function(event){
			saveGridSelected("plGrid", 'selected', 'delete', "/priceList/deletePlMapListJson");
		});

	}
	
	
	
	function fnPriceList(){

		$.ajax({
			type: "POST",
			url: "/priceList/plTagListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="<tr>";
				var strCospan="";
				var glevel="";
				var i = 1;
				var j = 1;
				var strColClass = "";
				var beforeUpcode = "";
				$.each(data.rows, function(key, d) {
					
					if(glevel != d.glevel && key != 0){
						regionHtml += "</tr>";
						
						if(d.glevel == 3) regionHtml += "<tr class='tag3'>";
						else regionHtml += "<tr>";
						
						strColClass = "col1";
					}
					
					strCospan="";
					if(d.colspan > 0) strCospan = "colspan='" + d.colspan + "'";
		
					if(beforeUpcode != d.upcode){
						i = (i == 1)? 2 : 1;
					}
					
					if(d.glevel == 1){
						regionHtml += "<td " + strCospan + " class='" + strColClass + " row1' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'><b>" + d.code_nm + "</b></td>";
					} else if(d.glevel == 2){
						if(strCospan != "")
						regionHtml += "<td " + strCospan + " class='" + strColClass + " bg-color-th" + j + "' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'>" + d.code_nm + "</td>";
					} else if(d.glevel == 3){
						regionHtml += "<td " + strCospan + " class='" + strColClass + " bg-color-td" + i + "' code='" + d.code + "' code_nm='" + d.code_nm + "' upcode='" + d.upcode + "' upcode_nm='" + d.upcode_nm + "' sort_seq='" + d.sort_seq + "' glevel='" + d.glevel + "'>" + d.code_nm + "</td>";
					}

					j = (j == 1)? 2 : 1;
					
					beforeUpcode = d.upcode;
					strColClass = "";
					glevel = d.glevel;
				});
				
				regionHtml += "</tr>";

				$("#pl_list").html(regionHtml);
				
				$("#pl_list td").on("click",function(){
					
					var pl_typ = $("#pl_typ").val();
					
					if(pl_typ == ''){
						toast('먼저 청구대상 구분을 선택하세요.');
						return false;
					}
					
					$("#pl_list td").removeClass("on");
					$(this).addClass("on");

					
					var glevel = $(this).attr("glevel");
					var tag_no = $(this).attr("code");
					var tag_nm = $(this).attr("code_nm");
					var uptag_no = $(this).attr("upcode");
					var uptag_nm = $(this).attr("upcode_nm");
					var sort_seq = $(this).attr("sort_seq");
					
					
				    var num = $("#plGrid").getGridParam("reccount");

					var newGridData={pl_typ:"",tag_no:"",tag_nm:"",uptag_no:"", uptag_nm:"", sort_seq:'', CRUD:"C" };    
					var allGridData = [];
					


					if(glevel == 1){
					
					} else if(glevel == 2){
					
					} else if(glevel == 3){
						allGridData[0] = newGridData;
						newGridData.pl_typ = pl_typ;
						newGridData.tag_no = tag_no;
						newGridData.tag_nm = tag_nm;
						newGridData.uptag_no = uptag_no;
						newGridData.uptag_nm = uptag_nm;
						newGridData.sort_seq = sort_seq;
					}
					
					//jQuery("#plGrid").jqGrid('addRowData', 2, allGridData[0]);
					   
					   
					   var ids = $("#plGrid").jqGrid('getDataIDs');
					   var idx = jQuery("#plGrid").getDataIDs();
					   
					   
					   if ( ids.length > 0 ){
					      for (var i = 0; i < allGridData.length; i++) {
					    	  
					         var result = true;
					         for(var j=0;j<ids.length;j++){
					            var rowdata = $("#plGrid").getRowData(ids[j]);
					            var tag_no = rowdata.tag_no;
					         
					            if(allGridData[i].tag_no == tag_no)
					               result = false;
					         }
					         
					         if(result)
					            jQuery("#plGrid").jqGrid('addRowData', idx.length+i+1, allGridData[i]);
					         else
					            toast(allGridData[i].tag_nm+"은(는)  이미 등록되어 있습니다." );
					      }
					   }else{
	
					         jQuery("#plGrid").jqGrid('addRowData', 1, allGridData[0]);
					   }
					   

					
					//등록입력창
					

					
				});

				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	
	var fnSetInfo = function(code,code_nm,upcode,upcode_nm,sort_seq){
		$("#code").val(code);
		$("#code_nm").val(code_nm);
		$("#upcode").val(upcode);
		$("#upcode_nm").val(upcode_nm);
		$("#sort_seq").val(sort_seq);
	}
	
	var fnFormReset = function(){
		//$("#cForm")[0].reset();
		$("#code_nm3").val('');
		$("#sort_seq3").val('');
	}
	
	var fnGridView = function(){
		
		jQuery("#plGrid").jqGrid({
			url:'/priceList/plMapListJson',
			datatype: "local",				   
			colNames:['상위항목코드', '상위항목명', '항목코드', '항목명'],
			colModel:[
				{name:'tag_no'		 , index:'tag_no'		, width:100, align:"center", sortable:true, editable:false},
				{name:'tag_nm'		 , index:'tag_nm'		, width:200, align:"center", sortable:true, editable:false},
				{name:'uptag_no'		 , index:'uptag_no'		, width:100, align:"center", sortable:true, editable:false},
				{name:'uptag_nm'		 , index:'uptag_nm'		, width:200, align:"center", sortable:true, editable:false}
			],
			
			mtype:"post",
			autowidth:true,
			rowNum:500,
// 			rowList:[10,30,50],
			height: 260,
		    viewrecords: true,
		    sortname: 'code_cd',
			cellsubmit : 'clientArray',
			multiselect : true,
			cellEdit : true,
			gridview:true,
			editable:true,
			pager: '#pager1',
			loadError : function(xhr,st,err) {
				girdLoadError();
		    },
		    loadComplete: function(data) {
		    	setSortingGridData(this, data);
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#plGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
		    postData : serializeObject($('#gForm')),
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("plGrid", id);
		    }
		});

		jQuery("#plGrid").jqGrid('navGrid','#pager1',{search:false,edit:false,add:false,del:false,refresh:true});
	}
	

	
</script>

<style>

.vl {writing-mode: vertical-lr; letter-spacing:6px; width:30px;}



.tag-list .tag3 td {writing-mode: vertical-lr; letter-spacing:6px; width:23px; cursor:pointer;}
.tag-list td { cursor:pointer;}
.tag-list td:hover {background-color:yellow; color:blue;}
.tag-list td.on {background-color:orange; color:blue;}


.int_space{line-height:24px !important;}
</style>

</head>

<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">단가항목 관리</h3>
			
			<span class="bullet6">단가관리 &gt; 단가항목 관리</span>
		</div>
		
		
		<div class="mt20" style=" width:100%; overflow-x:scroll;">

			<table class="layer_tbl2 tag-list wa" id="pl_list"></table>
		
		</div>
		
		<div class="dp_category">
				
		

			
			<div class="fl w40p mt40">
			
				<form id="gForm" name="gForm" method="post" action="#">
					<input type="hidden" id="pl_typ" name="pl_typ" />

						<fieldset>
						<legend>메뉴 관리 상세</legend>
							<div class="product_tbl">
								<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2">
								<caption>메뉴 관리 상세</caption>
									<colgroup>
										<col width="150px" />
										<col />
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">청구대상 구분</th>
											<td>

                                             <c:forEach var="entity" items="${applicationScope['CODE']['10900']}">
                                                <c:if test="${entity.use_yn == 'Y'}">
                                                <input type="radio" id="code${entity.code_cd}" name="rd_pl_typ" value="<c:out value="${entity.code_cd}"/>" /><label class="int_space" for="code${entity.code_cd}"><c:out value="${entity.code_nm}"/></label> <br />
                                             	</c:if>
                                             </c:forEach>   

											
										
											</td>
										</tr>

									</tbody>
								</table>
							</div>
						</fieldset>
					</form>
			</div>
			
			
			
			<!-- 그리드 -->
			<div class="fr w59p mt40">
				<div class="grid" min="800">
				
					<div class="outcome info">
						<span class="res_search" >단가항목</span>
						<div class="min_btn" style="float:right;">
							<input type="button" class="btn btn-primary btn-sm" value="저장" id="BTN_Save">
							<input type="button" class="btn btn-danger btn-sm" value="삭제" id="BTN_Delete">
						</div>
					</div>
					<br />
					<table id="plGrid"></table>
					
				</div>
			
			</div>

		</div>
		

		
		<br/>

			

	</div>
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
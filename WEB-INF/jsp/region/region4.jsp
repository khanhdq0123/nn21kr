<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>지역 관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>

<script type="text/javascript">
								
	var _country = '';
	var _city = '';
	var _region1 = '';
	var _region2 = '';
	
	var _countryNo = '';
	var _cityNo = '';
	var _region1No = '';
	var _region2No = '';

	$(document).ready(function() {

		fnSelectNation();
		fnRegionNationLoad(10000);
		fnGridView();

		$("#btnReg").click( function() {
			if ($('#code').val()=='') {
				toast("지역를 선택하고 신규 등록을 해 주세요.");
				return false;
			}
			CenterOpenWindow('/region/regionDetailPop?code='+ $("#code").val(), '지역등록', '680','260', 'scrollbars=no, status=yes');
		});
		
		$("#btnMod").click( function() {
			$("#rForm").submit();
		});
		
		$("#gForm").validate({
			debug : true,
			rules : {
				region_nm:{required:true, maxlength:30},
				sort_seq:{required:true, number:true, max:32767}
			},
			messages: {
				region_nm:{
					required:"지역명을 입력하세요.",
					maxlength:jQuery.format("지역명은 최대 {0}자 이하로 입력하세요.")
				},
				sort_seq:{
					required:"정렬순서를 입력하세요",
					number:"정렬순서는 숫자로 입력하셔야합니다.",
					maxlength:jQuery.format("정렬순서는 최대  {0} 이하로 입력하세요.")
				}
			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
            },
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {	

				$.ajax({
					type: "POST",
					url: "/region/updateRegion",
					data: $(form).serialize(),
					dataType: 'json',
					contentType: 'application/x-www-form-urlencoded; charset=utf-8',
					success: function(data) {
						if(data.code == '0') {
							//toast(data.msg);
							
							var _code = $("#code").val();
							var _region_nm = $("#region_nm").val();
							
							if($("input[name=levels]").val() == '1'){
								fnRegionNationLoad(10000);
							}
							else if ($("input[name=levels]").val() == '2'){
								fnRegionCityLoad(_countryNo,_country,0,null);
							}
							else if ($("input[name=levels]").val() == '3'){
								fnRegionVillageLoad(_cityNo,_city,0,null);
							}

							
						}	
					},
					error: function(jqXHR, textStatus, errorThrown) {
// 						toast(jqXHR.status);						
					}
				});
			}
		});
		

		
		$("#btnSave").click(function (){
// 		    $("#regionGrid").editCell(0,0,false);
// 			saveGridSelected("regionGrid", 'selected', 'save', "/region/updateRegionListJson");
		});
		
		$("#btnDel").click(function (){
			saveGridSelected("regionGrid", 'selected', 'delete', "/region/deleteRegionListJson");
		});
		
		$("#btnMod2").click( function() {
			$("#gForm").submit();
		});
		
	});	
					

	function fnRegionNationLoad(code){

		$("#code").val(code);
		$("#use_yn").val('');
		
		$.ajax({
			type: "POST",
			url: "/region/regionList2DepthJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="";
				var beforeUpcode="";
				$.each(data.rows, function(key, d) {
					if(beforeUpcode != d.up_code && key != 0){
						regionHtml += "</td>";
						regionHtml += "</tr>";
					}
					if(beforeUpcode != d.up_code){						
						regionHtml += "<tr>";
						regionHtml += "<th class=\"cont\">";
						regionHtml += "<span onclick=\"fnRegionLoad('" + d.up_code + "','" + d.up_region_nm + "','" + d.up_sort_seq + "','" + d.up_use_yn + "')\">" + d.up_region_nm + "</span>";
						regionHtml += "</th>";
						regionHtml += "<td class=\"nation\">";
					}
					regionHtml += "<span class=\"tit\"  onclick=\"fnRegionCityLoad('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.use_yn + "')\">" + d.region_nm + "</span>";
					beforeUpcode = d.up_code;
				});
				
				regionHtml +="<tr><th>";
				regionHtml +="<button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" onclick=\"fnRegRegion();\" style=\"margin-top:0; width:230px;\">+ 대륙추가</button></th>";
				regionHtml +="<td><button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" style=\"margin-top:0; width:100%;\">+ 국가추가</button>";
				regionHtml +="</td></tr>";
				
				
				
				$("#nationRegion").html(regionHtml);

				
				
				
				
				
				
				
				
				$("#nationRegion .nation span").on("click", function(){
					$("#nationRegion .nation span").removeClass("on");
					$(this).addClass("on");
				});
				
				$("#nationRegion .cont span").on("click", function(){
					$("#nationRegion .cont span").parent().removeClass("on");
					$(this).parent().addClass("on");
				});
				
				var id = $("#code").val();

			    $("#regionGrid").setGridParam({ datatype: "json" });
			    $("#regionGrid").trigger("reloadGrid", id);
			    
			    
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionCityLoad(code,region_nm,sort_seq,use_yn){
		
		$("input[name=code]").val(code);
		$("#region_nm").val(region_nm);
		$("#sort_seq").val(sort_seq);
		$("input[name=levels]").val(1);
		
		_country = region_nm;
		_countryNo = code;
		
		if(use_yn == "Y"){
			$("input:radio[name='use_yn']:radio[value='Y']").prop('checked',true);
			$("input:radio[name='use_yn']:radio[value='N']").prop('checked',false);
		} else {
			$("input:radio[name='use_yn']:radio[value='Y']").prop('checked',false);
			$("input:radio[name='use_yn']:radio[value='N']").prop('checked',true);
		}

		$.ajax({
			type: "POST",
			url: "/region/regionList2DepthJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="";
				var beforeUpcode="";
				$.each(data.rows, function(key, d) {
					if(beforeUpcode != d.up_code && key != 0){
						regionHtml += "</td>";
						regionHtml += "</tr>";
					}
					if(beforeUpcode != d.up_code){						
						regionHtml += "<tr>";
						regionHtml += "<th class=\"cont\">";
						regionHtml += "<span onclick=\"fnRegionLoad('" + d.up_code + "','" + d.up_region_nm + "','" + d.up_sort_seq + "','" + d.up_use_yn + "')\">" + d.up_region_nm + "</span>";
						regionHtml += "</th>";
						regionHtml += "<td class=\"nation\">";
					}
					if(d.region_nm != null)
					regionHtml += "<span onclick=\"fnRegionVillageLoad('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.use_yn + "')\">" + d.region_nm + "</span>";
					beforeUpcode = d.up_code;
				});
				$("#cityRegion").html(regionHtml);
				$("#villageRegion").html("");
				
				$("#cityRegion .nation span").on("click", function(){
					$("#cityRegion .nation span").removeClass("on");
					$(this).addClass("on");
				});
				
				$("#cityRegion .cont span").on("click", function(){
					$("#cityRegion .cont span").removeClass("on");
					$(this).addClass("on");
				});
				
				var id = $("#code").val();

			    $("#regionGrid").setGridParam({ datatype: "json" });
			    $("#regionGrid").trigger("reloadGrid", id);
			    
			    $("#nationRegion").parent().hide();
			    $("#cityRegion").parent().show();
			    $(".nationTitWrap").removeClass("dpn");
			    $(".titNationNm").html(region_nm);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad(code,region_nm,sort_seq,cnt){
		
// 		$('#cityRegion').parent().fadeOut('fast', function(){
// 			$('#villageRegion1').parent().fadeIn('fast');
// 		});

		$('#villageRegion1').parent().fadeIn('fast');
		
		$("#selectRegionTxt").text($("#selectRegionTxt").text() + ' > ' + region_nm);
		$("#titRegion").text('select a Region');
		
		_city = region_nm;
		_cityNo = code;
		
		$("#upcode").val(code);
		
		$.ajax({
			type: "POST",
			url: "/region/regionListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="";
				var beforeUpcode="";
				
				regionHtml += "<tr>";
				
				regionHtml += "<th class=\"cont\">";
				regionHtml += "<span onclick=\"fnRegionLoad('" + code + "','" + region_nm + "','" + sort_seq + "','Y')\">" + region_nm + "</span>";
				regionHtml += "</th>";
				
				regionHtml += "<td class=\"nation\">";
				
				$.each(data.rows, function(key, d) {
					regionHtml += "<span onclick=\"fnRegionVillageLoad2('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.cnt + "')\">" + d.region_nm + " (" + d.cnt + ")</span>";
				});
				

				regionHtml += "</td>";
				regionHtml += "</tr>";
				
				$("#villageRegion1").html(regionHtml);
				
				$("#villageRegion1 .cont span").on("click", function(){
					$("#villageRegion .cont span").removeClass("on");
					$(this).addClass("on");
				});
				
				var id = $("#code").val();

			    $("#regionGrid").setGridParam({ datatype: "json" });
			    $("#regionGrid").trigger("reloadGrid", id);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad2(code,region_nm,sort_seq,cnt){
		
		$("#selectRegionTxt").text($("#selectRegionTxt").text() + ' > ' + region_nm);
		_region1 = region_nm;
		_region1No = code;
		

				
		$('#villageRegion2').parent().fadeIn('fast');

		
		$("#upcode").val(code);

		$.ajax({
			type: "POST",
			url: "/region/regionListJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="";
				var beforeUpcode="";
				
				regionHtml += "<tr>";
				
				regionHtml += "<th class=\"cont\">";
				regionHtml += "<span onclick=\"fnRegionLoad('" + code + "','" + region_nm + "','" + sort_seq + "','Y')\">" + region_nm + "</span>";
				regionHtml += "</th>";
				
				regionHtml += "<td class=\"nation\">";
				
				$.each(data.rows, function(key, d) {
					regionHtml += "<span onclick=\"fnRegionVillageLoad3('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.cnt + "')\">" + d.region_nm + " (" + d.cnt + ")</span>";
				});
				

				regionHtml += "</td>";
				regionHtml += "</tr>";
				
				$("#villageRegion2").html(regionHtml);
				
				$("#villageRegion2 .cont span").on("click", function(){
					$("#villageRegion .cont span").removeClass("on");
					$(this).addClass("on");
				});
				
				var id = $("#code").val();

			    $("#regionGrid").setGridParam({ datatype: "json" });
			    $("#regionGrid").trigger("reloadGrid", id);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad3(code,region_nm,sort_seq,cnt){
		
//			$('#villageRegion1').parent().fadeOut('fast', function(){
//				$('#villageRegion2').parent().fadeIn('fast');
//			});
		
		_region2 = region_nm;
		_region2No = code;
		

		$("#selectRegionTxt").text($("#selectRegionTxt").text() + ' > ' + region_nm);


		
	}
	
	function fnRegionLoad(code,region_nm,sort_seq,use_yn){
		
		$("input[name=levels]").val(3);
		$("input[name=code]").val(code);
		$("#region_nm").val(region_nm);
		$("#sort_seq").val(sort_seq);
		
		_region1 = region_nm;
		_region1No = code;
		
		if(use_yn == "Y"){
			$("input:radio[name='use_yn']:radio[value='Y']").prop('checked',true);
			$("input:radio[name='use_yn']:radio[value='N']").prop('checked',false);
		} else {
			$("input:radio[name='use_yn']:radio[value='Y']").prop('checked',false);
			$("input:radio[name='use_yn']:radio[value='N']").prop('checked',true);
		}
		
	    $("#regionGrid").setGridParam({ datatype: "json" });
	    $("#regionGrid").trigger("reloadGrid", code);
	}
	
	function fnReloadRegionGrid(){
		
// 		var id = $("#code").val();

// 	    $("#regionGrid").setGridParam({ datatype: "json" });
// 	    $("#regionGrid").trigger("reloadGrid", id);

		fnSelectNation();
		fnRegionNationLoad(10000);
		//fnGridView();
	}
	
	function fnPreView(){
		
		CenterOpenWindow('/region/selectRegionPop?code=10000', '지역선택', '1000','560', 'scrollbars=no, status=yes');
	}
	
	function fnSetSelectRegionInfo(_country, _city, _region1, _region2, _countryNo, _cityNo, _region1No, _region2No){
		
		$("#selNation").val(_country);
		$("#selCity").val(_city);
		$("#selVillage1").val(_region1);
		$("#selVillage2").val(_region2);
		$("#selNationNo").val(_countryNo);
		$("#selCityNo").val(_cityNo);
		$("#selVillage1No").val(_region1No);
		$("#selVillage2No").val(_region2No);
	}
	
	
	function fnSelectNation(){
		$(".regionWrap").hide();
		$(".nationTitWrap").addClass("dpn");
		$("#nationRegion").parent().show();
	}

	function fnGridView(){
	    jQuery("#regionGrid").jqGrid({
	  		url:'/region/regionListJson',
	  		datatype: "local",				   
	  		colNames:['지역ID', '지역이름', '상위지역ID', '정렬순서', '사용여부', '수정일시'],
	  		colModel:[
	  			{name:'code'		, index:'code', width:0, align:"center", sortable:true, editable:false, key:true, hidden:true},
	  			{name:'region_nm'	, index:'region_nm', width:180, align:"left", sortable:true, editable:true},
	  			{name:'upcode'	, index:'upcode', width:0, align:"center", sortable:true, editable:false, hidden:true},
	  			{name:'sort_seq'     , index:'sort_seq'     , width:40, editable:true},
	  			{name:'use_yn'      , index:'use_yn'      , width:40, align:"center", sortable:true, editable:true, formatter:"select", edittype:"select", editoptions:{value:"Y:사용;N:미사용"}},
	  			{name:'mod_dt'     , index:'mod_dt'     , width:0, hidden:true}
	  		],
	  		mtype:"get",
	  		autowidth: true,	// 부모 객체의 width를 따른다
	  		//rownumbers: true,
	  		rowNum:500,	   	
	  		//rowList:[20,50,100],
	  		//width : $("#content").width() - $("#treeDiv").width() - $("#blank").width(),
	  		height: 500,
	  		//pager: '#subPager1',
	  		sortname: 'groupauth_id',
	  	    viewrecords: true,
	  	    //sortorder: "desc",
	  	    //caption: "게시판 샘플", 
	  	    multiselect : true,
	  	    cellEdit : true,
	  		cellsubmit : 'clientArray',
	  		gridview: true,
	  		// 서버에러시 처리
	  		loadError : function(xhr,st,err) {
	  			girdLoadError();
	  	    },
	  	    
	  		// 데이터 로드 완료 후 처리 
	  	  	loadComplete: function(data) {
	  	  		setSortingGridData(this, data);
				var detailData = $('#regionGrid').getGridParam('userData');
		    },
		    onPaging: function(btn) {
		    	if($('#'+btn).hasClass('ui-state-disabled')) {
		    		return 'stop';
		    	} else { 
		    		$("#regionGrid").jqGrid('setGridParam',{datatype:'json'});
		    		return true;
		    	}
		    },
			postData : {
				upcode:function() {
					return $("#code").val();
				},
				additionalParam:'dummy'
			},
	  	   
	  	    // cell이 변경되었을 경우 처리
	  	    afterSaveCell : function(id, name, val, iRow, iCol) {
	  	    	checkWhenColumnUpdated("regionGrid", id);
	  	    },
	  	    //스크롤바 자동 생성
	  	    shrinkToFit:true			    
	  	});
	}
	
	function fnRegRegion(){
		if ($('#code').val()=='') {
			toast("상위지역를 선택하고 등록을 해 주세요.");
			return false;
		}
		CenterOpenWindow('/region/regionDetailPop?code='+ $("#code").val(), '지역등록', '680','260', 'scrollbars=no, status=yes');
	}
	
	
	function fn_f10(){
	    $("#regionGrid").editCell(0,0,false);
		saveGridSelected("regionGrid", 'selected', 'save', "/region/updateRegionListJson");
	}	
</script>

<style>
.cont {text-align:left !important; height:20px; font-size:14px; text-align:center !important;}
.cont span { cursor:pointer;}
.nation {}
.nation span {display:inline-block; width: 230px; line-height:30px; vertical-algin:top; font-size:14px;}
.nation span:hover{background-color:#d0ee17; cursor:pointer;}
.mt10 {margin-top:10px;}

.on {background-color:#d0ee17 !important;}

.dpn {display:none;}
.titNationNm {font-size:36px; font-weight:bold; margin-right:22px;}
.nationTitWrap {line-height:30px; padding-top:10px;}
.ul {text-decoration:underline;}


.content_wrap .history {overflow:hidden;}
.bmarkadd {float:left;min-width:90px;height:17px;border:1px solid #d1d0d2;border-radius:3px;display:inline-block;padding:3px 7px 3px 6px;}
.content_wrap .history .bmarkadd span {font-weight:bold;background:url(../images/bg_yellowStar.gif) left center no-repeat;padding-left:15px;font-size:12px;}
.content_wrap .history .bullet6 {float:right;height:25px;line-height:25px;}

.minBtn {min-width:90px;height:17px;border:1px solid #d1d0d2;border-radius:3px;display:inline-block;padding:3px 7px 3px 6px;}
.minBtn span {font-weight:bold; padding-left:1px; font-size:12px; color:#70b1dd;}
</style>
</head>
<body class="sky">



	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">지역 관리</h3>
			
			<span class="bullet6">지역 관리 &gt; 지역 관리</span>
		</div>
		

		<div class="content_wrap history" style=" display:inline; width:75%; margin-top:0;">

			<form id="gForm" name="gForm" method="post" action="#">
				<input type="hidden"  name="levels" id="levels" value="1" />  
				<input type="hidden"  name="upcode" />
				<input type="hidden"  name="code" />

							<table cellspacing="0" cellpadding="0" summary="" class="tbl_type2">
							<caption>지역 관리 상세</caption>
								<colgroup>
									<col width="100" />
									<col width="90" />
									<col width="100" />
									<col width="200" />
									<col width="100" />
									<col width="90" />
									<col width="/" />
								</colgroup>
								<tbody>

									<tr>
										<th scope="row"><label for="region_nm">지역명</label></th>
										<td>
											<input type="text" id="region_nm" name="region_nm" style="width:200px;" />
										</td>
										<th scope="row"><label for="region_nm">사용여부</label></th>
										<td>
											<input type="radio" id="use_yn1" name="use_yn" value="Y" checked="checked" /><label class="int_space" for="use_yn1">사용</label>
											<input type="radio" id="use_yn2" name="use_yn" value="N" /><label class="int_space" for="use_yn2">미사용</label>
										</td>
										<th scope="row"><label for="region_nm">정렬순서</label></th>
										<td>
											<input type="text" id="sort_seq" name="sort_seq" style="width:30px;" />
										</td>
										<td>
											<button id="btnMod2" name="btnMod2" class="sky" style="margin-top:0;">수정</button>
											<button id="btnDel2" class="gray">삭제</button>
										</td>
									</tr>
		
								</tbody>
							</table>
	
	
	
			</form>
		
		</div>


		<div class="dp_category nationTitWrap dpn">
			<div style="float:left; display:inline; width:25%; margin-top:0;">
				<span class="titNationNm" onclick="fnSelectNation();"></span>
				
<!-- 				<span id="btnDel2" onclick="fnSelectNation();" class="gray ul"> ↔ 국가 다시선택</span> -->
			</div>

		</div>

		<div class="dp_category">
		
		
			<div style=" display:inline; margin-top:0;">
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10" >
		            <caption>국가정보</caption>
		            <colgroup>
		               <col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="nationRegion"></tbody>
				</table>
				

		
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>도시정보</caption>
		            <colgroup>
		               <col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="cityRegion"></tbody>
				</table>
				
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>마을정보</caption>
		            <colgroup>
		               <col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion"></tbody>
				</table>
				
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>마을정보</caption>
		            <colgroup>
		            	<col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion1"></tbody>
				</table>
				
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>마을정보</caption>
		            <colgroup>
		            	<col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion2"></tbody>
				</table>				
			
			</div>

			<!-- product_admin -->
			<div  style="diaplay:inline; margin-top:0;">
			
<!-- 			<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" style="padding:5px;"> -->
<!-- 			미리보기 -->
<!-- 				<input type="text" name="selNation" id="selNation" onclick="fnPreView();" value="선택하세요." style="background-color:#eee; color:#777; width:110px;" readonly /> -->
<!-- 				<input type="text" name="selCity" id="selCity" onclick="fnPreView();" value="" style="background-color:#eee; color:#777; width:110px;" readonly /> -->
<!-- 				<input type="text" name="selVillage1" id="selVillage1" onclick="fnPreView();" value="" style="background-color:#eee; color:#777; width:110px;" readonly /> -->
<!-- 				<input type="text" name="selVillage2" id="selVillage2" onclick="fnPreView();" value="" style="background-color:#eee; color:#777; width:110px;" readonly /> -->
<!-- 			</div> -->

			


			</div>
			<!-- //product_admin -->
		</div>
	
	
	
	
	
	
	
	
	
	
		<div class="corner_tab mt30" style="display:none;">
			<div class="grid" min="400">
				<div class="outcome info" style="height:30px;">
					<span class="res_search" >하위 지역 리스트 </span>
					<div class="min_btn" style="float:right;">
						<button id="btnReg" class="sky">추가</button>
						<button id="btnSave" class="sky">저장</button>
						<button id="btnDel" class="gray">삭제</button>
					</div>
				</div>
				<table id="regionGrid"></table>
			</div>
		</div>
	
	
	</div>
	<!-- //content_wrap -->
 
					<form id="rForm" name="rForm" method="post" action="#">
					<input type="hidden" id="levels" name="levels" />  
					<input type="hidden" id="upcode" name="upcode" />
					<input type="hidden" id="code" name="code" />
					</form>
 
 <div id="toast"></div></body>
 </html>
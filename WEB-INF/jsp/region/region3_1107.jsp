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
	var _countryEng = '';
	var _city = '';
	var _region1 = '';
	var _region2 = '';
	var _region3 = '';
	var _region4 = '';
	
	var _countryNo = '';
	var _cityNo = '';
	var _region1No = '';
	var _region2No = '';
	var _region3No = '';
	var _region4No = '';

	$(document).ready(function() {

		fnSelectNation();
		fnRegionNationLoad(10000);


		$("#btnReg").click( function() {
			if ($('#code').val()=='') {
				toast("지역를 선택하고 신규 등록을 해 주세요.");
				return false;
			}
			CenterOpenWindow('/region/regionDetailPop?code='+ $("#code").val(), '지역등록', '680','320', 'scrollbars=no, status=yes');
		});
		
		$("#btnMod").click( function() {
			$("#rForm").submit();
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
				var i = 1;
				$.each(data.rows, function(key, d) {
					if(beforeUpcode != d.up_code && key != 0){
						regionHtml += "</td>";
						regionHtml += "</tr>";
					}
					if(beforeUpcode != d.up_code){						
						regionHtml += "<tr>";
						regionHtml += "<th class=\"cont bg-color-th" + i + " \" code='" + d.up_code + "' sort_seq='" + d.up_sort_seq + "'  >";
						regionHtml += "<span class='mb10' onclick=\"fnRegionDetailPop('" + d.up_code + "',2)\">" + d.up_region_nm + "</span>";
						regionHtml += "<div class='mt5'>";
						regionHtml += "<span class='minBtn btn-up' onclick=\"fnMoveUpSeq(this,'" + d.up_code + "','" + d.up_sort_seq + "',2)\"><span class=''>▲</span></span>";
						regionHtml += "<span class='minBtn btn-down' onclick=\"fnMoveDownSeq(this,'" + d.up_code + "','" + d.up_sort_seq + "',2)\"><span class=''>▼</span></span>";
						regionHtml += "<span class='minBtn  ml20'><span class='' onclick=\"fnRegRegion('" + d.up_code + "',2)\">국가등록</span></span></div>";
						regionHtml += "</th>";
						regionHtml += "<td class='bg-color-td" + i + "'>";
						i = (i == 1)? 2 : 1;
					}
					
					regionHtml += "<span class=\"nation\">";
					var starClass = (d.use_yn == "Y")? "orange" : "gray";
					regionHtml += "<span class=\"tit " + starClass + " \" onclick=\"fnFavority('" + d.code + "','" + d.use_yn + "',2)\">★ </span>";
					regionHtml += "<span class=\"tit\"  onclick=\"fnRegionCityLoad('" + d.code + "','" + d.region_enm + "','" + d.region_nm + "')\">" + d.region_enm + " " + d.region_nm + "</span>";
					regionHtml += "<span class='skyblue ml10'><span class='' onclick=\"fnRegionDetailPop('" + d.code + "',2)\">▤</span></span>";
					regionHtml += "</span>";
					
					
					beforeUpcode = d.up_code;
				});
				
				regionHtml +="<tr><th>";
				regionHtml +="<button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" onclick=\"fnRegRegion(10000, 1);\" style=\"margin-top:0; width:230px;\">+ 대륙추가</button></th>";
				regionHtml +="<td>";
				regionHtml +="</td></tr>";

				$("#nationRegion").html(regionHtml);
				
				
				$("#nationRegion .cont").first().find(".btn-up").remove();
				$("#nationRegion .cont").last().find(".btn-down").remove();
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionCityLoad(code,region_enm,region_nm){
		$("input[name=code]").val(code);
		$("#use_yn").val('');

		if(typeof region_nm == "undefined") $("#region_nm").val(region_enm);
		else $("#region_nm").val(region_enm + ' ' + region_nm);

		_country = region_nm;
		_countryEng = region_enm;
		_countryNo = code;
		

		$.ajax({
			type: "POST",
			url: "/region/regionList2DepthJson",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				var regionHtml="";
				var beforeUpcode="";
				var i = 1;
				
				$.each(data.rows, function(key, d) {
					if(beforeUpcode != d.up_code && key != 0){
						regionHtml += "</td>";
						regionHtml += "</tr>";
					}
					if(beforeUpcode != d.up_code){						
						regionHtml += "<tr>";
						regionHtml += "<th class=\"cont bg-color-pastel" + i + " \" code='" + d.up_code + "' sort_seq='" + d.up_sort_seq + "'  >";
						
						regionHtml += "<span onclick=\"fnRegionDetailPop('" + d.up_code + "',4)\">" + d.up_region_enm + "</span>";
						if(d.up_region_nm != null && d.up_region_nm != '')
						regionHtml += "<br /><span onclick=\"fnRegionDetailPop('" + d.up_code + "',4)\">" + d.up_region_nm + "</span>";
						
						regionHtml += "<div class='mt5'>";
						regionHtml += "<span class='minBtn btn-up' onclick=\"fnMoveUpSeq(this,'" + d.up_code + "','" + d.up_sort_seq + "',4)\"><span class=''>▲</span></span>";
						regionHtml += "<span class='minBtn btn-down' onclick=\"fnMoveDownSeq(this,'" + d.up_code + "','" + d.up_sort_seq + "',4)\"><span class=''>▼</span></span>";
						regionHtml += "<span class='minBtn'><span class='' onclick=\"fnRegRegion('" + d.up_code + "',4);\">지역등록</span></span>";
						regionHtml += "</th>";
						regionHtml += "<td>";
						i++;
					}
					
					if(d.region_nm != null){
						
						regionHtml += "<span class=\"nation\">";		
						var starClass = (d.use_yn == "Y")? "orange" : "gray";
						regionHtml += "<span class=\"tit " + starClass + " \" onclick=\"fnFavority('" + d.code + "','" + d.use_yn + "',4)\">★ </span>";
						regionHtml += "<span class=\"tit\" onclick=\"fnRegionVillageLoad('" + d.code + "','" + d.region_nm + "')\">" + d.region_enm + " " + d.region_nm + "</span>";
						regionHtml += "<span class='skyblue ml10'><span class='' onclick=\"fnRegionDetailPop('" + d.code + "',4)\">▤</span></span>";
						regionHtml += "</span>";
					}
					
					beforeUpcode = d.up_code;
				});
				
				
				regionHtml +="<tr><th>";
				regionHtml +="<button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" onclick=\"fnRegRegion(" + code + ", 3);\" style=\"margin-top:0; width:230px;\">+ 권역추가</button></th>";
				regionHtml +="<td>";
				regionHtml +="</td></tr>";
				
				$("#cityRegion").html(regionHtml);
				$("#villageRegion").html("");
				
				$("#cityRegion .cont").first().find(".btn-up").remove();
				$("#cityRegion .cont").last().find(".btn-down").remove();

			    $("#nationRegion").parent().hide();
			    $("#cityRegion").parent().show();
			    $(".nationTitWrap").removeClass("dpn");

			    $(".titNationNm").html(region_enm + ' ' + region_nm);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad(code,region_nm){

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
				regionHtml += "<span onclick=\"fnRegionLoad('" + code + "','" + region_nm + "')\">" + region_nm + "</span>";
				regionHtml += "<span class='minBtn'><span class='' onclick=\"fnRegRegion('" + code + "',5);\">지역등록</span></span>";
				regionHtml += "</th>";
				
				regionHtml += "<td>";
				
				$.each(data.rows, function(key, d) {
					regionHtml += "<span class=\"nation\">";
					regionHtml += "<span class=\"tit\" onclick=\"fnRegionVillageLoad2('" + d.code + "','" + d.region_nm + "')\">" + d.region_enm + " " + d.region_nm + "</span>";
					regionHtml += "<span class='minBtn'><span class='' onclick=\"fnRegionDetailPop('" + d.code + "',5)\">수정</span></span>";
					regionHtml += "</span>";
				});
				

				regionHtml += "</td>";
				regionHtml += "</tr>";
				
// 				regionHtml +="<tr><th>";
// 				regionHtml +="<button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" onclick=\"fnRegRegion(" + code + ", 5);\" style=\"margin-top:0; width:230px;\">+ 지역추가</button></th>";
// 				regionHtml +="<td>";
// 				regionHtml +="</td></tr>";
				
				$("#villageRegion1").html(regionHtml);
				$("#villageRegion2").html("");
				
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad2(code,region_nm){
		
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
				regionHtml += "<span onclick=\"fnRegionLoad('" + code + "','" + region_nm + "')\">" + region_nm + "</span>";
				regionHtml += "<span class='minBtn'><span class='' onclick=\"fnRegRegion('" + code + "',6);\">지역등록</span></span>";
				regionHtml += "</th>";
				
				regionHtml += "<td>";
				
				$.each(data.rows, function(key, d) {
					regionHtml += "<span class=\"nation\">";
					regionHtml += "<span class=\"tit\">" + d.region_enm + " " + d.region_nm + "</span>";
					regionHtml += "<span class='minBtn'><span class='' onclick=\"fnRegionDetailPop('" + d.code + "',6)\">수정</span></span>";
					regionHtml += "</span>";
				});
				

				regionHtml += "</td>";
				regionHtml += "</tr>";
				
// 				regionHtml +="<tr><th>";
// 				regionHtml +="<button id=\"btnMod2\" name=\"btnMod2\" class=\"sky\" onclick=\"fnRegRegion(" + code + ", 6);\" style=\"margin-top:0; width:230px;\">+ 지역추가</button></th>";
// 				regionHtml +="<td>";
// 				regionHtml +="</td></tr>";
				
				$("#villageRegion2").html(regionHtml);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnRegionVillageLoad3(code,region_nm,sort_seq,cnt){
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
		fnSelectNation();
		fnRegionNationLoad(10000);
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
	
	function fnCallbackRegionUpdate(levels){
		

		
		if(levels == '1' || levels == '2'){
			fnRegionNationLoad(10000);
		} else if(levels == '3' || levels == '4'){
			fnRegionCityLoad(_countryNo,_countryEng,_country);
		} else if(levels == '5'){
			fnRegionVillageLoad(_cityNo,_city);
		} else if(levels == '6'){
			fnRegionVillageLoad2(_region1No,_region1);
		}
	}

	//등록 화면
	function fnRegRegion(code, levels){
		CenterOpenWindow('/region/regionRegFormPop?code='+ code + '&levels=' + levels, '지역등록', '680','260', 'scrollbars=no, status=yes');
	}
	
	//수정 화면
	function fnRegionDetailPop(code, levels){
		CenterOpenWindow('/region/regionDetailPop?code='+ code + '&levels=' + levels, '지역등록', '680','260', 'scrollbars=no, status=yes');
	}
	
	//순서변경
	function fnMoveUpSeq(_target,code1,sort_seq1, levels){
		
		var code2;
		var sort_seq2;
		var _parent = $(_target).parent().parent().parent().parent().find("tr");	//table tr
		var _this = $(_target).parent().parent().parent();
		var _index = _parent.index(_this);
		
		code2 = _parent.eq(_index - 1).find(".cont").attr("code");
		sort_seq2 = _parent.eq(_index - 1).find(".cont").attr("sort_seq");
		
		$("#code1").val(code1);
		$("#code2").val(code2);
		$("#sort_seq1").val(sort_seq1);
		$("#sort_seq2").val(sort_seq2);

		$.ajax({
			type: "POST",
			url: "/region/updateRegionSortSeq",
			data: $("#sForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				fnCallbackRegionUpdate(levels);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}

	function fnMoveDownSeq(_target,code1,sort_seq1, levels){
		
		var code2;
		var sort_seq2;
		var _parent = $(_target).parent().parent().parent().parent().find("tr");	//table tr
		var _this = $(_target).parent().parent().parent();
		var _index = _parent.index(_this);
		
		code2 = _parent.eq(_index + 1).find(".cont").attr("code");
		sort_seq2 = _parent.eq(_index + 1).find(".cont").attr("sort_seq");
		
		$("#code1").val(code1);
		$("#code2").val(code2);
		$("#sort_seq1").val(sort_seq1);
		$("#sort_seq2").val(sort_seq2);

		$.ajax({
			type: "POST",
			url: "/region/updateRegionSortSeq",
			data: $("#sForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				fnCallbackRegionUpdate(levels);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
	
	function fnFavority(code, use_yn, levels){
		
		use_yn = (use_yn == "Y")? "N":"Y";
		$("#code").val(code);
		$("#use_yn").val(use_yn);

		$.ajax({
			type: "POST",
			url: "/region/updateRegionUseYn",
			data: $("#rForm").serialize(),
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=utf-8',
			success: function(data) {
				fnCallbackRegionUpdate(levels);
			},
			error: function(jqXHR, textStatus, errorThrown) {
				toast(jqXHR.status);						
			}
		});
	}
</script>

<style>
.cont {text-align:left !important; height:40px; font-size:14px; text-align:center !important;}
.cont span { cursor:pointer;}
.nation {display:inline-block; width: 250px; padding:7px;}
.nation .tit {}
.nation .tit:hover{background-color:#d0ee17; cursor:pointer;}

.mt5 {margin-top:5px;}
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

.minBtn {min-width:14px;height:17px; margin-left:5px; border:1px solid #d1d0d2;border-radius:3px;
	display:inline-block;padding:1px 5px 3px 3px; background-color:white; cursor:pointer;}
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
		



		<div class="dp_category nationTitWrap dpn">
			<div style="float:left; display:inline; width:75%; margin-top:0;">
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
				
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>마을정보</caption>
		            <colgroup>
		            	<col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion3"></tbody>
				</table>
				
				<table cellspacing="0" cellpadding="0" class="regionWrap layer_tbl mt10"  >
		            <caption>마을정보</caption>
		            <colgroup>
		            	<col width="230">
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion4"></tbody>
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
	<input type="hidden" id="use_yn" name="use_yn" />
	</form>
 
 	<form id="sForm" name="sForm" method="post" action="#">
		<input type="hidden" id="code1" name="code1" />
		<input type="hidden" id="code2" name="code2" />
		<input type="hidden" id="sort_seq1" name="sort_seq1" />
		<input type="hidden" id="sort_seq2" name="sort_seq2" />
 	</form>

 <div id="toast"></div></body>
 </html>
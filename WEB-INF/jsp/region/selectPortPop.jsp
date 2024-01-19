<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/common/include/header.jsp"%>
		
		<title>포트 선택</title>
		
		<script type="text/javascript">
			var _code = ${code}
			
			var _country = '';
			var _city = '';
			var _region1 = '';
			var _region2 = '';
			var _countryNo = '';
			var _cityNo = '';
			var _region1No = '';
			var _region2No = '';
										
			$(document).ready(function() {

				fnRegionNationLoad(_code);

				$("#btnReset").click(function() { location.reload(); });
				$("#btnSelected").click(function() {
					if(_country == '' || _city == '' || _region1 == '') {toast('지역을 선택하세요.'); return;}
// 					window.opener.fnSetSelectRegionInfo( _country, _city, _region1, _region2, _countryNo, _cityNo, _region1No, _region2No);
					window.opener.fnSetSelectPortInfo( _country, _city, _region1, _region2, _countryNo, _cityNo, _region1No, _region2No);
					window.close();
				});
				
				
			});
			
			function fnRegionNationLoad(code){

				$("#code").val(code);
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
								regionHtml += "<span>" + d.up_region_nm + " (" + d.up_cnt + ")</span>";
								regionHtml += "</th>";
								regionHtml += "<td class=\"nation\">";
							}
							regionHtml += "<span onclick=\"fnRegionCityLoad('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.cnt + "')\">" + d.region_nm + " (" + d.cnt + ")</span>";
							beforeUpcode = d.up_code;

						});
						$("#nationRegion").html(regionHtml);

						$("#nationRegion .nation span").on("click", function(){
							$("#nationRegion .nation span").removeClass("on");
							$(this).addClass("on");
						});
						
						$("#nationRegion .cont span").on("click", function(){
							$("#nationRegion .cont span").removeClass("on");
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
			
			function fnRegionCityLoad(code,region_nm,sort_seq,cnt){

				$('#nationRegion').parent().fadeOut('fast', function(){
					$('#cityRegion').parent().fadeIn('fast');
				});
				$("#selectRegionTxt").text(region_nm);
				$("#titRegion").text('select a City');
				
				_country = region_nm;
				_countryNo = code;
				
				$("#code").val(code);

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
								regionHtml += "<span>" + d.up_region_nm + " (" + d.up_cnt + ")</span>";
								regionHtml += "</th>";
								regionHtml += "<td class=\"nation\">";
							}
							if(d.region_nm != null)
							regionHtml += "<span onclick=\"fnRegionVillageLoad('" + d.code + "','" + d.region_nm + "','" + d.sort_seq + "','" + d.cnt + "')\">" + d.region_nm + " (" + d.cnt + ")</span>";
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
					},
					error: function(jqXHR, textStatus, errorThrown) {
						toast(jqXHR.status);						
					}
				});
			}
			
			function fnRegionVillageLoad(code,region_nm,sort_seq,cnt){
				
				$('#cityRegion').parent().fadeOut('fast', function(){
					$('#villageRegion1').parent().fadeIn('fast');
				});
				
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
				
				$('#villageRegion1').parent().fadeOut('fast', function(){
					if(cnt == '0'){ 
						$("#titRegion").text('');
						return false;
					} else {
						$("#titRegion").text('select a Region');				
						$('#villageRegion2').parent().fadeIn('fast');
					}
				});

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
				
// 				$('#villageRegion1').parent().fadeOut('fast', function(){
// 					$('#villageRegion2').parent().fadeIn('fast');
// 				});
				
				_region2 = region_nm;
				_region2No = code;
				

				$("#selectRegionTxt").text($("#selectRegionTxt").text() + ' > ' + region_nm);

	
				
			}
			
		</script>
		
		<style>
.cont {text-align:left !important; height:20px;}
.nation {}
.nation span {display:inline-block; width: 100px; line-height:20px; vertical-algin:top;}
.nation span:hover{background-color:#d0ee17; cursor:pointer;}
.mt10 {margin-top:10px;}
.ml10 {margin-left:10px;}
.on {background-color:#d0ee17;}
</style>
		
	</head>

<body class="sky">

<div class="layerpop_inner" id="#">

	<h1 class="ly_header" id="portTitle">포트 선택</h1>

	<div class="ly_body">
		<div class="refer bullet6">
		
			<div id="selectRegionTxt" style="font-weight:bold; font-size:20px; float:left; line-height:25px;"></div>
					<div class="refer_bt">
						<div class="min_btn mini">
							<button class="gray" id="btnClose">닫기</button>
						</div>
					</div>
		</div>
		

		
		<div class="dp_category"  style="padding:10px;">

				<div style="height:30px;">
				
					<h3 id="titRegion" style="float:left;">Select a country</h3>
					
					<div class="refer_bt" style="float:right;  margin-right:20px;">
						<div class="min_btn mini">
							<button type="button" class="reset" id="btnReset" style="width:180px;"><span>다시선택</span></button>
							<button class="blue3 ml10" id="btnSelected" style="width:180px; height:26px; margin-left:5px;">선택완료</button>
						</div>
					</div>
								
				</div>

				<table cellspacing="0" cellpadding="0" class="layer_tbl mt10" >
		            <caption>국가정보</caption>
		            <colgroup>
		               <col width="150">
		               <col width="/">
		            </colgroup>
		            <tbody id="nationRegion"></tbody>
				</table>
				<table cellspacing="0" cellpadding="0" class="layer_tbl mt10" style="display:none;">
		            <caption>도시정보</caption>
		            <colgroup>
		               <col width="150">
		               <col width="/">
		            </colgroup>
		            <tbody id="cityRegion"></tbody>
				</table>
				<table cellspacing="0" cellpadding="0" class="layer_tbl mt10"  style="display:none;">
		            <caption>마을정보</caption>
		            <colgroup>
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion1"></tbody>
				</table>
				<table cellspacing="0" cellpadding="0" class="layer_tbl mt10"  style="display:none;">
		            <caption>마을정보</caption>
		            <colgroup>
		               <col width="/">
		            </colgroup>
		            <tbody id="villageRegion2"></tbody>
				</table>
		</div>

		<form id="rForm" name="rForm" method="post" action="#">
			<input type="hidden" id="code" name="code" value="30000" />
			<input type="hidden" id="upcode" name="upcode" value="" />
			<input type="hidden" id="use_yn" name="use_yn" value="Y" />
		</form>
	</div>

</div>

<div id="toast"></div></body>
</html>
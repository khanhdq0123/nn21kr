<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>입고관리</title>
<meta http-equiv="Content-type" content="text/html; charset=utf-8" />
<meta http-equiv="Cache-control" content="No-cache" />
<meta http-equiv="Pragma" content="No-cache" />
<meta name="Description" content="" />
<meta name="Keywords" content="" />

<%@include file="/common/include/header.jsp"%>


<script type="text/javascript">
	$(document).ready(function() {
		
		
		var sStatus = "2:진행중;3:완료";	
		
		
		$("#spnSetReg button").click(function() {
			var when = '';
			if (this.id == 'btnRegSetToday') when = 'today';
			if (this.id == 'btnRegSetWeekago') when = 'weekago';
			if (this.id == 'btnRegSetMonthago') when = 'monthago';
			setSearchDate('search_start_dt', 'search_end_dt', when);
		});
		
		
		// Title	BLNO	Date	Area	Warehouse	 	Status	excel
		
		// 그리드 - 프로토타입 
		jQuery('#list1').jqGrid({
			url: '/transport/inbound/inputListJson',
			datatype: 'local',
		   	colNames: ['Transport', 'Title', 'BLNO', 'Date', 'Area', 'Warehouse','count/Kg/KCM','Status', 'excel'],
			colModel: [
	            { name: 'Transport', 	index: 'Transport', 	align: 'center', sortable: true, width: '100' },
				{ name: 'Title', 		index: 'Title', 		align: 'center', sortable: true, width: '100' , editable:true},
				{ name: 'BLNO', 		index: 'BLNO', 			align: 'center', sortable: true, width: '120' },
				{ name: 'Date', 		index: 'Date', 			align: 'center', sortable: true, width: '100' },
				{ name: 'Area', 		index: 'Area', 			align: 'center', sortable: true, width: '250' },
				{ name: 'Warehouse', 	index: 'Warehouse', 	align: 'center', sortable: true, width: '100' },
				{ name: 'kcc', 			index: 'reg_date', 		align: 'center', sortable: true, width: '150' },
				{ name: 'Status', 		index: 'Status', 		align: 'center', editable:true, formatter:"select", edittype:"select", editoptions:{value:"2:완료;3:진행중"}, width:210 },
				{ name: 'excel', 		index: 'reply_date', 	align: 'center', editable:true, width: '70'}
			],
			mtype:"post",
			autowidth:true,
			rowNum:500,	   	
// 			rowList:[20,50,100],
			height: 500,
			editable:true,
			pager: '#pager1',
			sortname: 'maker_no',
		    viewrecords: true,
		    sortorder: "desc",
			loadComplete: function(data) {
				setSortingGridData(this, data);
			}, 
			onPaging: function(btn) {
				if($('#'+btn).hasClass('ui-state-disabled')) {
					return 'stop';
				} else { 
					$('#list1').jqGrid('clearGridData').jqGrid('setGridParam',{ datatype:'json' });
					return true;
				}
			},
			loadError: function(xhr,st,err) {
				girdLoadError();
		    },
		    postData: serializeObject($('#searchForm')),
		    // cell이 변경되었을 경우 처리
		    afterSaveCell : function(id, name, val, iRow, iCol) {
		    	checkWhenColumnUpdated("codeGrid", id);
		    }
		});
		
		// jqGrid Navigator
		jQuery('#list1').jqGrid('navGrid','#pager1',{search:false, edit:false, 
				add:false, del:false, refresh:false});
	
		// Link 처리
		function linkFormatter(cellVal, options, rowObj) {
			var linkURL = '<a href="javascript:CenterOpenWindow(\'/board/oneOnone/oneOnoneDetail.do' 
					+ '?id=' + rowObj['voc_id']
					+ '\', \'open\', \'800\', \'600\', \'scrollbars=yes, status=no\');">'
					+ cellVal + '</a>';
			return linkURL;
		}
		
		// 검색 날짜 자동 채우기
		$('#spnSetReg button').click(function() {
			if (this.id == 'btnRegSetToday')
				setSearchDate('search_start_dt', 'search_end_dt', 'today');
			if (this.id == 'btnRegSetWeekago')
				setSearchDate('search_start_dt', 'search_end_dt', 'weekago');
			if (this.id == 'btnRegSetMonthago')
				setSearchDate('search_start_dt', 'search_end_dt', 'monthago');
		});
		
		// grid 검색
		$('#btnSearch').click(function() {
			$('#searchForm').submit();
		});
		
		// 초기화 버튼
		$('#btnReset').click(function() {
			$('#searchForm')[0].reset();
		});
		

		
		// jQuery validation
		$("#searchForm").validate({
			rules: {

			},
			messages: {

			},
			onfocusout:false,
			invalidHandler: function(form, validator) {
				showValidationError(form, validator);               
			},
			errorPlacement: function(error, element) {},
			submitHandler: function(form) {
				$("#list1").setGridParam({
					page : 1,
					postData : serializeObject($('#searchForm')),
					datatype: 'json'
				});
				
				$("#list1").trigger("reloadGrid");
			}
		});
	});
</script>

</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header">도착입고</h3>
			
			<span class="bullet6">물류관리 &gt; 입고관리 &gt; 도착입고</span>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="get" id="searchForm">
					<fieldset>
						<legend>도착입고</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">
												<dl class="section">
													<dt>From</dt>
													<dd>
														<select id="st_RegionCode" class="form-control text-sm"><option value="All">ALL</option><option value="G">JAPAN</option><option value="7">HONGKONG</option><option value="8">Taiwan</option><option value="F">U.S.A</option><option value="B">Indonesia</option><option value="C">Myanmar</option><option value="6">Vietnam</option><option value="E">Philippines</option><option value="D">Laos</option><option value="1">Korea</option><option value="2">China</option><option value="3">Japan</option><option value="5">Mexico</option><option value="9">OtherLocation</option></select>
													</dd>
													<dt>Warehouse</dt>
													<dd>
														<select id="st_Storage" class="form-control text-sm"><option value="All">ALL</option><option value="215"> (주)에이씨티앤코아물류보세창고 </option><option value="351"> (주)일심로지스타 </option><option value="352"> 더로지스(주)제2보세창고 </option><option value="343"> 한국공항(주) </option><option value="335">(주)가람통상 보세창고</option><option value="367">(주)광진티엘에스</option><option value="364">(주)엘아이피 2창고</option><option value="262">(주)원경통상 보세창고</option><option value="332">(주)일심로지스타</option><option value="334">(주)E1컨테이너터미널보세창고</option><option value="62">0본사1층창고</option><option value="131">0해상특송창고</option><option value="174">1 인천수입창고</option><option value="293">1인천수출창고</option><option value="180">2  SEKWANG/세광</option><option value="228">2, CSL/씨에스엘</option><option value="223">3, E1 CFS</option><option value="186">4, 건창보세창고/</option><option value="138">6, 견적용 입고</option><option value="101">가산로지스틱스 보세창고</option><option value="331">고려보세창고</option><option value="58">구내1창고</option><option value="112">구내2창고</option><option value="60">구내3창고</option><option value="61">구내4창고</option><option value="59">구내5창고</option><option value="197">국보인천아암물류센터</option><option value="349">국제여객부두 컨테이너 보세창고</option><option value="79">그린물류보세창고</option><option value="65">극동창고</option><option value="83">대광창고</option><option value="157">대보창고</option><option value="133">대우보세창고(주)</option><option value="80">대한통운창고</option><option value="268">대한항공(주)</option><option value="153">대호보세창고</option><option value="156">대흥창고</option><option value="188">더로지스(주) 창고 </option><option value="275">더로지스(주)보세창고</option><option value="353">더로지스(주)제2보세창고</option><option value="2">동방보세창고</option><option value="316">동방허치슨보세창고</option><option value="278">동부부산보세창고</option><option value="350">동원부산컨테이너터미널(주)보세창고</option><option value="214">듀얼인천보세창고</option><option value="202">듀얼인천보세창고</option><option value="170">바오스창고</option><option value="139">바이넥스 보세창고</option><option value="356">백마보세창고</option><option value="340">백마제2보세창고</option><option value="163">백마종합물류 보세창고</option><option value="301">베델로직스창고</option><option value="221">베트남사무실</option><option value="231">부강보세창고 </option><option value="265">부강보세창고</option><option value="57">부두직 통관</option><option value="155">부산 용당세관창고 </option><option value="184">부산국제우편출장소</option><option value="267">부산항감만CY</option><option value="270">부산항신선대CY</option><option value="77">브이지로지스</option><option value="182">삼미 영업용 보세창고(주)</option><option value="179">삼해로지스보세창고</option><option value="160">서경로지텍창고</option><option value="72">서광창고</option><option value="336">서해물류 보세창고</option><option value="200">선광신컨테이너터미널보세창고 </option><option value="337">선광신항터미널</option><option value="185">선광인천터미널창고</option><option value="338">선광종합물류(주)CY</option><option value="189">선광종합물류CFS</option><option value="198">선광컨테이너보세창고</option><option value="212">선광컨테이너보세창고</option><option value="71">선광CFS</option><option value="304">성민종합물류보세창고</option><option value="130">세계로물류 보세창고</option><option value="87">세방부산터미널</option><option value="85">세원창고</option><option value="107">송도창고</option><option value="220">스카이국제운송</option><option value="183">신대동국제물류 보세창고</option><option value="203">신대륙물류보세창고</option><option value="192">씨제이대한통운 아암국제물류</option><option value="204">씨제이대한통운 평택 보세창고</option><option value="318">아시아나에어포트(주)1</option><option value="327">에스엠상선경인터미널</option><option value="285">에이에이씨티 (유)</option><option value="264">엠앤엠통운 보세창고 </option><option value="137">엠앤엠통운 보세창고</option><option value="300">엠엔엠통운 보세창고</option><option value="339">연성물류</option><option value="348">연성창고</option><option value="323">영진공사(1부두CY)</option><option value="90">영진공사보세창고(주)</option><option value="230">영진창고</option><option value="206">와이엘보세창고(주)</option><option value="328">우련국제물류(주)보세창고</option><option value="317">우련통운CY</option><option value="169">유앤아이보세창고</option><option value="302">은산컨테이너(주)신항만화전</option><option value="358">은산해운창고</option><option value="134">인성물류보세창고</option><option value="88">인천 로지스틱 보세창고</option><option value="187">인천공항세관검사장</option><option value="333">인천국제여객부두 컨테이너 보세창고</option><option value="125">인천보세창고(대아창고)</option><option value="207">인천복합운송협회(사)</option><option value="355">인천선광신항컨테이너터미널(SNCT</option><option value="193">인천선광신항터미널</option><option value="81">인천컨테이너 보세창고</option><option value="205">인천컨테이너터미널(주)</option><option value="360">인천컨테이너터미널(주)</option><option value="162">인천항공동물류보세창고</option><option value="78">일신창고</option><option value="111">조양창고</option><option value="342">주)토탈물류보세창고</option><option value="346">㈜세광물류보세창고</option><option value="347">㈜세광물류보세창고</option><option value="110">지성보세창고</option><option value="165">지앤지(주)</option><option value="357">지정장치장(특송물류센터)</option><option value="136">진아보세창고</option><option value="152">천우제2창고</option><option value="64">천우창고</option><option value="256">청도보성보세창고</option><option value="135">컨테이너 CY창고</option><option value="308">크로스독 창고</option><option value="102">태광통상 보세창고</option><option value="127">태정실업 보세창고</option><option value="70">태평양 창고</option><option value="195">통관대행창고</option><option value="363">특송창고 </option><option value="276">평택당진항내항동부두</option><option value="211">평택세관 지정장치장</option><option value="341">평택아이포트</option><option value="168">평택중부창고</option><option value="175">평택창고</option><option value="216">평택카훼리CFS</option><option value="269">평택컨테이너터미날(주)CY</option><option value="362">평택컨테이너터미날(주)CY</option><option value="345">평택항 카훼리 화물터미널</option><option value="196">평택해운로지스</option><option value="272">피에스에이현대부산신항만(주)</option><option value="315">한국공항(주)</option><option value="366">한국로지스풀(주) 인천신항</option><option value="227">한국로지스풀(주)인천남동</option><option value="354">한국허치슨터미널(주)부산컨테</option><option value="273">한국허치슨터미널(주)부산컨테이너</option><option value="277">한국허치슨터미널(주)부산컨테이너</option><option value="76">한진국제 보세창고</option><option value="303">한진부산컨테이너터미널</option><option value="271">한진인천컨테이너터미널</option><option value="254">한진제2보세창고</option><option value="217">한진CFS</option><option value="359">한진CFS</option><option value="344">해광물류</option><option value="274">해성종합물류(주)보세창고 </option><option value="292">혜성보세창고</option><option value="103">화인통상 제2보세창고</option><option value="171">화전CFS</option><option value="280">흥아로지스틱스 보세창고</option><option value="69">흥아창고</option><option value="132">희창물산(주) 인천물류지점</option><option value="199">ACT항공화물</option><option value="361">M&amp;M보세창고</option><option value="73">SFS창고</option><option value="307">SM 상선 경인터미널</option></select>
													</dd>
													
												</dl>
												<dl class="section">
													<dt>BLNO</dt>
													<dd>
														<input type="text" id="gl_user_id" name="gl_user_id" style="width: 50%" maxlength="20"/>
													</dd>
													<dt>Transport</dt>
													<dd>
														<select name="process_status_code" style="width: 50%">
															<option value="" selected="selected">전체</option>
															<option value="1">내륙 항공운송</option>
															<option value="2">항공운송</option>
															<option value="3">FCL</option>
															<option value="5">Not Fixed</option>
		
														</select>
													</dd>
													
												</dl>
												<dl class="section">
													<dt>BLNO</dt>
													<dd>
														<input type="text" id="gl_user_id" name="gl_user_id" style="width: 50%" maxlength="20"/>
													</dd>
													<dt>Status</dt>
													<dd>
														<input type="text" id="user_name" name="user_name" style="width: 50%" maxlength="30"/>
													</dd>
												</dl>
												<dl class="section">
													<dt>Date</dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_start_dt" name="search_start_dt"/>
														</span>
														&nbsp;~&nbsp; 
														<span class="calendar">
															<input type="text" maxlength="10" class="datepicker" id="search_end_dt" name="search_end_dt"/>
														</span>
														
														<span id="spnSetReg">
															<button type="button" class="btn_c6" id="btnRegSetToday">오늘</button>
															<button type="button" class="btn_c6" id="btnRegSetWeekago">1주일</button>
															<button type="button" class="btn_c6" id="btnRegSetMonthago">1개월</button>
														</span>
													</dd>
												</dl>
											</div>
											<div class="tbl_wrap active mark"></div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</fieldset>
				</form>
			</div>
			

			<div class="product_bt">
				<button type="button" class="search" id="btnSearch">
					<span>검색</span>
				</button>
				<button type="button" class="reset" id="btnReset">
					<span>초기화</span>
				</button>
			</div>
			<!-- grid -->
			<div class="grid">
				<table id="list1"></table>
				<div id="pager1"></div>			
			</div>
			<!-- grid end -->			

		</div>
		<!-- //product_admin -->
	</div>
	<!-- //content_wrap -->
<div id="toast"></div></body>
</html>

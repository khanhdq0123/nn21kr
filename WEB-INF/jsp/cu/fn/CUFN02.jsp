<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
	<%@include file="/common/include/header.jsp"%>		 
	<script type="text/javascript" src="/js/cu/fn/CUFN02.js"></script>
</head>
<body class="sky">
	<!-- content_wrap -->
	<div class="content_wrap">
		<div class="history">
			<h3 class="header"></h3>
			<div class="btn-wrap">
				<input type="button" class="btn btn-success btn-sm" value="검색[F3]" id="btnSearch">
				<input type="button" class="btn btn-primary btn-sm" value="신규등록[F9]" id="btnAdd">
				<input type="button" class="btn btn-primary btn-sm" value="저장[F10]" id="btnSaveAddFn">
			</div>
		</div>
		<!-- product_admin -->
		<div class="product_admin">
			<!-- product_form -->
			<div class="product_form">
				<form method="post" id="searchForm" name="searchForm" action="#">
				
					<fieldset>
					<legend>검색조건</legend>
						<div class="product_tbl">
							<table cellspacing="0" cellpadding="0" class="tbl_type2 tbl_cell">
							<caption>검색조건 정보</caption>
								<colgroup>
									<col width="100%" />
								</colgroup>
								<tbody>
									<tr>
										<td>
											<div class="tbl_wrap">												
												<dl class="section">
													<dt><label for="a11">등록일</label></dt>
													<dd class="cols">
														<span class="calendar">
															<input type="text" class="datepicker2" id="regdt_from" name="regdt_from" autocomplete="off" />
														</span>
															~
														<span class="calendar">
															<input type="text" class="datepicker2" id="regdt_to" name="regdt_to" autocomplete="off" />
														</span>
														<input type="button" class="btn_c6 btnDate btn btn-close btn-xs" val="today" value="오늘">
														<input type="button" class="btn_c6 btnDate btn btn-close btn-xs" val="weekago" value="1주일">
														<input type="button" class="btn_c6 btnDate btn btn-close btn-xs" val="monthago" value="1개월">																								
													</dd>
												</dl>
											</div>
										</td>
									</tr>
								</tbody>
								<!--  //추가 검색조건 열기 -->
							</table>
						</div>
					</fieldset>
				</form>
			</div>


			<div class="grid">
				<table id="list1"></table>
			</div>
		</div>
		<!-- //product_admin -->
	</div>
	
	<!-- //content_wrap -->
 <div id="toast"></div></body>

</html>
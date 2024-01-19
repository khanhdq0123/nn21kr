<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
function removePartnerDiv(){
	$("#layerPop").remove();
}
</script>
<div class="lypopWrap lypop_prosumInfo" id="partnerThumbDiv">
	<!-- header -->
	<div class="header">
		<h3>지사 요약 정보</h3>
		<p class="btnR">
			<a href="javascript:removePartnerDiv();" class="gray" >닫기</a>
		</p>
	</div>
	<!-- //header -->
	<!-- contents -->
	<div class="contents">
		<!-- 본문 -->
		<div class="">
			<ul class="ul_def3">
				<li>
					<p><strong>지사코드</strong>: ${info.vendor_no}</p>
				</li>
				<li>
					<p><strong>대표자 명</strong> :  ${info.owner_nm}</p>
				</li>
				<li>
					<p><strong>과세유형</strong>: ${applicationScope['CODENAME'][info.tax_cd]}</p>
				</li>
				<li>
					<p><strong>업태</strong>: ${info.business_type_txt}</p>
				</li>
				<li>
					<p><strong>상태</strong>: ${applicationScope['CODENAME'][info.stats_typ_cd]}</p>
				</li>
			</ul>
			<ul class="ul_def3">
				<li>
					<p><strong>지사명</strong> : ${info.vendor_nm}</p>
				</li>
				<li>
					<p><strong>사업자번호</strong> :  ${info.biz_num_txt}</p>
				</li>
				<li>
					<p><strong>대표전화번호</strong> : ${info.tel_txt}</p>
				</li>
				<li>
					<p><strong>업종</strong> :  ${info.business_txt}</p>
				</li>

			</ul>
			<ul class="ul_def3" style="width:100%;margin-top:0px;">
				<li>
					<p><strong>회사주소(지번)</strong> : ${info.lot_basadd_txt}&nbsp;${info.lot_dtladd_txt}</p>
				</li>
				<li>
					<p><strong>회사주소(도로명)</strong> : ${info.road_basadd_txt}&nbsp;${info.road_dtladd_txt}</p>
				</li>
			</ul>
		</div>
		<!-- //본문 -->
	</div>
	<!-- //contents -->
</div>
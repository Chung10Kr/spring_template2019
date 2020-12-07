<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>	
<%@ include file="/WEB-INF/views/layout/tagCommon.jsp"%>
<script>
var barcode ; 
$(function () {
	barcode = '1234567890128'
	setBarcode('barcode',barcode,2,15);
});

</script>
<a id="target" style="display: none"></a>
	<div class="AR W100p MgT10 PdR10 MgB20 printBtn H20">
		<button class="Tbtn W80 AC" type="button" onclick="fnReportPrint();return false">프린트</button>
	</div>
	<div id="printA4" class="a4 W100p printA4 AC">
	  <!-- 프린트 영역 start -->
			<h2 class="W100p MgT5 AC VM H30">거 래 명 세 서</h2>
			 
			<div class="AR H50">
				전표번호 : <div class="barcode fr"></div>
			</div>
			<div>
				<h1 class="AL H10 fs15">(공급받는자 보관용)</h1>
				<table class="print_table MgT5 fl W48p ">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 25%;" />
						<col style="width: 23%;" />
						<col style="width: 25%;" />
						<col />
					<colgroup>
					<tbody>
						<tr>
							<th rowspan="4">공</br>급</br>자</th>
							<th>등록번호</th>
							<td colspan="3">504-81-75846</td>
						</tr>
						<tr>
							<th>상호</th>
							<td>(주)하이텍</td>
							<th>성명</th>
							<td>홍길동</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">인천광역시 미추홀구</td>
						</tr>
						<tr>
							<th>업태</th>
							<td></td>
							<th>종목</th>
							<td></td>
						</tr>
					</tbody>
				</table>
				
				<table class="print_table MgT5 fr W48p ">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 25%;" />
						<col style="width: 23%;" />
						<col style="width: 25%;" />
						<col />
					<colgroup>
					<tbody>
						<tr>
							<th rowspan="4">공</br>급</br>받</br>는</br>자</th>
							<th>등록번호</th>
							<td colspan="3">504-81-75846</td>
						</tr>
						<tr>
							<th>상호</th>
							<td>(주)하이텍</td>
							<th>성명</th>
							<td>홍길동</td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">인천광역시 미추홀구</td>
						</tr>
						<tr>
							<th>업태</th>
							<td></td>
							<th>종목</th>
							<td></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div>
				<h1 class="MgT10 fl H10 fs15">납품일자 : 2019-11-25 차수:35</h1>
				<table class="table_list AL MgT5 W100p">
						<colgroup>
							<col style="width: 5%;" />
							<col style="width: 15%;" />
							<col style="width: 30%;" />
							<col style="width: 8%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col />
						<colgroup>
						<thead>
							<tr>
								<th>No</th>
								<th>품 번</th>
								<th>품 명</th>
								<th>단 위</th>
								<th>수 량</th>
								<th>단 가</th>
								<th>금 액</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach begin="0" end="67" varStatus="index" >
								<tr>
									<td><c:out value="${index.count}"/></td>
									<td>514-12-15</td>
									<td>품명</td>
									<td>EA</td>
									<td>13521</td>
									<td>100</td>
									<td>1352100</td>
								</tr> 
							</c:forEach>
						</tbody>
				</table>
			</div>
			<div class="">
				<table class="print_table MgT5 W100p ">
						<colgroup>
							<col style="width: 10%;" />
							<col style="width: 13%;" />
							<col style="width: 10%;" />
							<col style="width: 13%;" />
							<col style="width: 10%;" />
							<col style="width: 13%;" />
							<col style="width: 10%;" />
							<col />
						<colgroup>
						<tbody>
							<tr>
								<th>수량합계</th>
								<td>37,440</td>
								<th>공급가액</th>
								<td>12,881,088</td>
								<th>세액</th>
								<td>1,288,109</td>
								<th>합계금액</th>
								<td>14,169,197</td>
							</tr>
						</tbody>
					</table>
				<table class="print_table MgT5 fl W30p ">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 30%;" />
						<col style="width: 30%;" />
					<colgroup>
					<tbody>
						<tr>
							<th rowspan="2">확</br>인</th>
							<th>입고시간</th>
							<th>정문확인</th>
							<th>부품품질</th>
						</tr>
						<tr class="H50">
							<td></td><td></td><td></td>
						</tr>
					</tbody>
				</table>
				<table class="print_table MgT5 fr W30p ">
					<colgroup>
						<col style="width: 10%;" />
						<col style="width: 30%;" />
						<col style="width: 30%;" />
					<colgroup>
					<tbody>
						<tr>
							<th rowspan="2">자</br>재</th>
							<th>입고확인</th>
							<th>SYS입력</th>
							<th>송장검증</th>
						</tr>
						<tr class="H50">
							<td></td><td></td><td></td>
						</tr>
					</tbody>
				</table>
			</div>
	<!-- 프린트 영역 end -->
	</div>
	



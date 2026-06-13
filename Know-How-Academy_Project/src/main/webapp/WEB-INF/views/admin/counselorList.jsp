<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.counselor-section {
		width: 100%;
		padding: 0px 40px 80px;
		box-sizing: border-box;
	}

	/* 페이지 제목 */
	.page-title-area {
		display: flex;
		justify-content: space-between;
		align-items: flex-end;
		margin-bottom: 28px;
	}

	.page-title-area h2 {
		margin: 0;
		font-size: 32px;
		font-weight: 800;
		color: #2c2f3f;
	}

	.page-title-area p {
		margin: 10px 0 0;
		font-size: 15px;
		color: #6b7280;
	}

	/* 공통 버튼 */
	.btn-primary {
		min-width: 96px;
		height: 42px;
		padding: 0 22px;
		border: none;
		border-radius: 8px;
		background-color: #4233c7;
		color: #fff;
		font-size: 15px;
		font-weight: 700;
		cursor: pointer;
	}

	.btn-primary:hover {
		background-color: #3528a8;
	}

	.btn-primary.small {
		min-width: 76px;
		height: 36px;
		padding: 0 16px;
		font-size: 14px;
	}

	.btn-outline {
		min-width: 82px;
		height: 36px;
		padding: 0 14px;
		border: 1px solid #c9ccd6;
		border-radius: 7px;
		background-color: #fff;
		color: #4b5563;
		font-size: 14px;
		font-weight: 600;
		cursor: pointer;
	}

	.btn-outline:hover {
		border-color: #4233c7;
		color: #4233c7;
	}

	.btn-danger-outline {
		min-width: 82px;
		height: 36px;
		padding: 0 14px;
		border: 1px solid #ef4444;
		border-radius: 7px;
		background-color: #fff;
		color: #ef4444;
		font-size: 14px;
		font-weight: 700;
		cursor: pointer;
	}

	.btn-danger-outline:hover {
		background-color: #fff1f1;
	}

	/* 탭 */
	.counselor-tabs {
		display: flex;
		margin-bottom: 24px;
		border-bottom: 1px solid #e5e7eb;
	}

	.tab-btn {
		width: 170px;
		height: 50px;
		border: 1px solid #d7d4f5;
		border-bottom: none;
		background-color: #fff;
		color: #6b7280;
		font-size: 16px;
		font-weight: 700;
		cursor: pointer;
	}

	.tab-btn:first-child {
		border-radius: 8px 0 0 0;
	}

	.tab-btn:last-child {
		border-radius: 0 8px 0 0;
	}

	.tab-btn.active {
		color: #4233c7;
		border-color: #8b7cff;
		background-color: #fff;
	}

	/* 검색 카드 */
	.search-card {
		background-color: #fff;
		border: 1px solid #e5e7eb;
		border-radius: 12px;
		padding: 24px 28px;
		margin-bottom: 28px;
		box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
	}

	.search-title {
		display: block;
		margin-bottom: 12px;
		font-size: 16px;
		font-weight: 800;
		color: #2c2f3f;
	}

	.search-row {
		display: flex;
		gap: 16px;
		align-items: center;
	}

	.search-input {
		flex: 1;
		height: 46px;
		padding: 0 16px;
		border: 1px solid #d1d5db;
		border-radius: 8px;
		font-size: 15px;
		color: #2c2f3f;
		outline: none;
	}

	.search-input:focus {
		border-color: #4233c7;
		box-shadow: 0 0 0 3px rgba(66, 51, 199, 0.12);
	}

	.search-btn {
		height: 46px;
	}

	.search-keyword {
		display: inline-flex;
		align-items: center;
		gap: 8px;
		margin-top: 14px;
		padding: 7px 12px;
		border-radius: 8px;
		background-color: #f2f0ff;
		color: #4233c7;
		font-size: 14px;
		font-weight: 600;
	}

	.search-keyword button {
		border: none;
		background: none;
		color: #6b5ce7;
		font-size: 16px;
		cursor: pointer;
	}

	/* 리스트 카드 */
	.list-card {
		background-color: #fff;
		border: 1px solid #e5e7eb;
		border-radius: 12px;
		padding: 28px;
		box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
	}

	.list-card-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 18px;
	}

	.list-card-header strong {
		font-size: 17px;
		font-weight: 800;
		color: #2c2f3f;
	}

	.list-card-header span {
		font-size: 14px;
		color: #6b7280;
	}
	
	.counselor-table {
		width: 100%;
		border-collapse: separate;
		border-spacing: 0;
		border: 1px solid #e5e7eb;
		border-radius: 10px;
		font-size: 15px;
		min-width: 1100px;
	}

	.counselor-table thead th {
		height: 54px;
		padding: 0 18px;
		background-color: #fafafa;
		color: #2c2f3f;
		font-weight: 800;
		text-align: left;
		border-bottom: 1px solid #e5e7eb;
	}

	.counselor-table tbody td {
		min-height: 64px;
		padding: 14px 18px;
		color: #374151;
		border-bottom: 1px solid #eef0f4;
		vertical-align: middle;
	}

	.counselor-table tbody tr:last-child td {
		border-bottom: none;
	}

	.counselor-table tbody tr:hover {
		background-color: #fafaff;
	}

	.name-link {
		color: #4233c7;
		font-weight: 800;
		text-decoration: underline;
		text-underline-offset: 3px;
	}

	.name-link:hover {
		color: #2f2499;
	}

	/* 클래스 변경 select */
	.class-select {
		width: 170px;
		height: 40px;
		padding: 0 12px;
		border: 1px solid #d1d5db;
		border-radius: 7px;
		background-color: #fff;
		color: #374151;
		font-size: 14px;
		outline: none;
	}

	.class-select:disabled {
		background-color: #f3f4f6;
		color: #9ca3af;
		cursor: not-allowed;
	}

	.class-select:focus {
		border-color: #4233c7;
	}

	.select-help {
		margin: 6px 0 0;
		font-size: 12px;
		color: #9ca3af;
	}

	/* 상태 배지 */
	.status-badge {
		display: inline-flex;
		align-items: center;
		justify-content: center;
		min-width: 62px;
		height: 28px;
		padding: 0 12px;
		border-radius: 999px;
		font-size: 13px;
		font-weight: 800;
	}

	.status-badge.active {
		background-color: #e8f8ec;
		color: #128a3a;
	}

	.status-badge.waiting {
		background-color: #fff5d6;
		color: #c47a00;
	}

	.status-badge.inactive {
		background-color: #f1f2f5;
		color: #6b7280;
	}

	/* 관리 버튼 묶음 */
	.action-group {
		display: flex;
		gap: 8px;
		align-items: center;
	}

	/* 페이징 */
	.pagination-area {
		display: flex;
		justify-content: center;
		align-items: center;
		gap: 10px;
		margin-top: 24px;
	}

	.pagination-area button {
		width: 36px;
		height: 36px;
		border: none;
		border-radius: 8px;
		background-color: #fff;
		color: #374151;
		font-size: 15px;
		font-weight: 700;
		cursor: pointer;
	}

	.pagination-area button:hover {
		background-color: #f2f0ff;
		color: #4233c7;
	}

	.pagination-area button.active {
		background-color: #4233c7;
		color: #fff;
	}
</style>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	<!-- 상담사 관리 콘텐츠 시작 -->
	<section class="counselor-section">

		<!-- 페이지 상단 타이틀 -->
		<div class="page-title-area">
			<div>
				<h2>상담사 관리</h2>
				<p>상담사 계정, 담당 클래스, 초대 상태를 관리합니다.</p>
			</div>

			<!-- 상담사등록 -->
			<button type="button" class="btn-primary" onclick="go('/admin/counselorInvite')">
				상담사 등록
			</button>
		</div>

		<!-- 탭 영역 (+) -->
		<div class="counselor-tabs">
			<button type="button" data-status="ACTIVE" 
					class="tab-btn ${requestScope.status eq 'ACTIVE' ? 'active' : ''}" 
				    onclick="go('/admin/counselorList?status=ACTIVE')">
				재직중 상담사</button>
			<button type="button" data-status="INACTIVE" 
					class="tab-btn ${requestScope.status eq 'INACTIVE' ? 'active' : ''}" 
				    onclick="go('/admin/counselorList?status=INACTIVE')">
				비활성화 상담사</button>
		</div>

		<!-- 검색 영역 -->
		 <form action="${pageContext.request.contextPath}/admin/counselorList" 
		 	   method="get" id="counselorSearchForm">
			<input type="hidden" name="status" value="${requestScope.status}">
			<div class="search-card">
				<label for="counselorKeyword" class="search-title">검색어</label>

				<div class="search-row">
					<input type="text"
						class="search-input"
						id="counselorKeyword"
						name="keyword"
						value="${requestScope.keyword}"
						placeholder="상담사명 또는 이메일 또는 전화번호 검색">

					<button type="submit" class="btn-primary search-btn">
						검색
					</button>
				</div>
				<c:if test="${not empty keyword}">
					<div class="search-keyword">
						검색어: <span><c:out value="${keyword}" /></span>
						<button type="button" onclick="go('/admin/counselorList?status=${requestScope.status}')">×</button>
					</div>
				</c:if>
			</div>
		</form>

		
		<div id="counselorListContainer">
			<jsp:include page="counselorListFragment.jsp" />
		</div>

		<br><br>
	</section>
	<!-- 상담사 관리 콘텐츠 끝 -->
	<script>

		function reloadCounselorList(cpage = 1) {
			const params = $("#counselorSearchForm").serialize();

			$("#counselorListContainer").load(
				"${pageContext.request.contextPath}/admin/counselorList/fragment?"
				 + params
				 + "&cpage=" + cpage
			);
		}

		function updateClass(userNo) {
			const selectedOption = $("#classSelect-" + userNo).find("option:selected");
			const changeType = selectedOption.data("change-type");
			const changeNo = selectedOption.data("change-no");
			const cpage = $("#currentCounselorPage").val();

			$.ajax({
				url: "${pageContext.request.contextPath}/admin/class/update",
				type: "POST",
				data: {
					userNo: userNo,
					changeType: changeType,
					changeNo : changeNo
				},
				success: function(result) {
					if(result == "success"){
						alert("저장되었습니다.");
						reloadCounselorList(cpage);
					}else if(result == "fail"){
						alert("이미 사용 중인 클래스입니다.");
					}else{
						alert(result);
					}
				},
				error: function(xhr) {

					console.log("상담사리스트 상담사 클래스 변경 ajax 통신 실패!");

					if (xhr.status !== 401 && xhr.status !== 403) {
                        alert("오류가 발생했습니다.");
                    }
				}
			});
		}

		function deleteInvite(inviteNo){

			const cpage = $("#currentCounselorPage").val();

			$.ajax({
				url: "${pageContext.request.contextPath}/admin/invite/delete",
				type: "POST",
				data: {
					inviteNo: inviteNo
				},
				success: function(result) {
					if(result == "success"){
						alert("초대링크가 삭제되었습니다.");
						reloadCounselorList(cpage);
					}else {
						alert("사용되거나 만료된 링크입니다.");
					}
				},
				error: function(xhr) {
					console.log("상담사리스트 상담사 초대링크 삭제 ajax 통신 실패!");

					if (xhr.status !== 401 && xhr.status !== 403) {
                        alert("오류가 발생했습니다.");
                    }
				}
			});
		}
	</script>
</body>
</html>
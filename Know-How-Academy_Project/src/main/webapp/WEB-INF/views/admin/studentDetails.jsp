<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.counselor-detail-section {
    width: 100%;
    padding: 0px 40px 80px;
    box-sizing: border-box;
}

.detail-title-area {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    margin-bottom: 28px;
}

.detail-title-area h2 {
    margin: 0;
    font-size: 32px;
    font-weight: 800;
    color: #2c2f3f;
}

.detail-title-area p {
    margin: 10px 0 0;
    font-size: 15px;
    color: #6b7280;
}

.profile-summary-card {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 150px;
    padding: 32px 40px;
    margin-bottom: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 18px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

.profile-left {
    display: flex;
    align-items: center;
    gap: 28px;
}

.profile-img-box {
    width: 118px;
    height: 118px;
    border-radius: 18px;
    background-color: #f0f1f8;
    border: 1px solid #d7d9e5;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #9ca3af;
    font-weight: 800;
}

.profile-text h3 {
    margin: 0;
    font-size: 30px;
    font-weight: 900;
    color: #111827;
}

.profile-text p {
    display: flex;
    align-items: center;
    gap: 10px;
    margin: 12px 0 0;
    font-size: 15px;
    color: #6b7280;
}

.summary-dot {
    color: #c4c7d0;
}

.detail-card-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 24px;
    margin-bottom: 28px;
}

.detail-card {
    padding: 28px 32px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 16px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

.detail-card-title {
    margin-bottom: 20px;
    padding-bottom: 14px;
    border-bottom: 1px solid #eef0f4;
    font-size: 20px;
    font-weight: 900;
    color: #2c2f3f;
}

.info-row {
    display: flex;
    align-items: center;
    min-height: 48px;
    border-bottom: 1px solid #f0f1f4;
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    width: 130px;
    flex-shrink: 0;
    color: #6b7280;
    font-size: 15px;
    font-weight: 700;
}

.info-value {
    color: #111827;
    font-size: 16px;
    font-weight: 800;
}

.memo-card {
    padding: 28px 32px;
    margin-bottom: 28px;
    background-color: #fff;
    border: 1px solid #e5e7eb;
    border-radius: 16px;
    box-shadow: 0 4px 14px rgba(17, 24, 39, 0.06);
}

.memo-card-header h3 {
    margin: 0;
    font-size: 20px;
    font-weight: 900;
    color: #2c2f3f;
}

.memo-card-header p {
    margin: 8px 0 20px;
    font-size: 14px;
    color: #6b7280;
}

.memo-list {
    display: flex;
    flex-direction: column;
    gap: 12px;
    margin-bottom: 22px;
}

.memo-item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    min-height: 52px;
    padding: 0 18px;
    border: 1px solid #eef0f4;
    border-radius: 12px;
    background-color: #fafafa;
}

.memo-text {
    font-size: 16px;
    font-weight: 800;
    color: #111827;
}

.memo-delete-btn {
    width: 32px;
    height: 32px;
    border: none;
    border-radius: 50%;
    background-color: #e5e7eb;
    color: #374151;
    font-size: 18px;
    cursor: pointer;
}

.memo-delete-btn:hover {
    background-color: #d1d5db;
}

.memo-input-area {
    display: flex;
    gap: 12px;
    align-items: center;
}

.memo-input {
    flex: 1;
    height: 44px;
    padding: 0 16px;
    border: 1px solid #d1d5db;
    border-radius: 10px;
    font-size: 15px;
    outline: none;
}

.memo-input:focus {
    border-color: #4233c7;
    box-shadow: 0 0 0 3px rgba(66, 51, 199, 0.12);
}

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

.status-badge.inactive {
    background-color: #f1f2f5;
    color: #6b7280;
}

.status-badge.leave {
    background-color: #fff5d6;
    color: #c47a00;
}

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
    min-width: 72px;
    height: 40px;
    padding: 0 16px;
    font-size: 14px;
}

.btn-outline {
    min-width: 96px;
    height: 42px;
    padding: 0 22px;
    border: 1px solid #c9ccd6;
    border-radius: 8px;
    background-color: #fff;
    color: #4b5563;
    font-size: 15px;
    font-weight: 700;
    cursor: pointer;
}

.btn-outline:hover {
    border-color: #4233c7;
    color: #4233c7;
}

.btn-danger {
    min-width: 96px;
    height: 42px;
    padding: 0 22px;
    border: none;
    border-radius: 8px;
    background-color: #ef3124;
    color: #fff;
    font-size: 15px;
    font-weight: 800;
    cursor: pointer;
}

.btn-danger:hover {
    background-color: #d7281d;
}

.btn-active {
    min-width: 96px;
    height: 42px;
    padding: 0 22px;
    border: none;
    border-radius: 8px;
    background-color: #128a3a;
    color: #fff;
    font-size: 15px;
    font-weight: 800;
    cursor: pointer;
}

.btn-active:hover {
    background-color: #107a32;
}

.detail-bottom-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

    <section class="counselor-detail-section">

        <div class="detail-title-area">
            <div>
                <h2>학원생 상세조회</h2>
                <p>상담사의 기본 정보와 담당 클래스, 상태를 확인합니다.</p>
            </div>

            <button type="button" class="btn-outline" onclick="location.assign('/know-how/admin/studentList') ">목록으로</button>
        </div>

        <div class="profile-summary-card">

            <div class="profile-left">
                <div class="profile-img-box">
                    <span>IMG</span>
                </div>

                <div class="profile-text">
                    <h3>${ requestScope.s.studentName }</h3>
                </div>
            </div>
			<c:choose>
					<c:when test="${ requestScope.s.status eq 'ATTENDING' }">
			            <div class="profile-right">
			                <button type="button" class="btn-danger" onclick="rest('${ requestScope.s.status }');">휴학 처리</button>
			            </div>
			        </c:when>
			        <c:otherwise>
			        	<div class="profile-right">
			                <button type="button" class="btn-active" onclick="rest('${ requestScope.s.status }');">재학 처리</button>
			            </div>
			        </c:otherwise>
			</c:choose>
        </div>

        <div class="detail-card-grid">

            <div class="detail-card">
                <div class="detail-card-title">
                    학생 인적사항
                </div>

                <div class="info-row">
                    <span class="info-label">이름</span>
                    <span class="info-value">${ requestScope.s.studentName }</span>
                </div>

                <div class="info-row">
                    <span class="info-label">연락처</span>
                    <span class="info-value">${ requestScope.s.phone }</span>
                </div>

                <div class="info-row">
                    <span class="info-label">이메일</span>
                    <span class="info-value">${ requestScope.s.email }</span>
                </div>

                <div class="info-row">
                    <span class="info-label">가입일</span>
                    <span class="info-value">${ requestScope.s.createdAt }</span>
                </div>
            </div>

            <div class="detail-card">
                <div class="detail-card-title">
                    수강 정보
                </div>

                <div class="info-row">
                    <span class="info-label">소속 클래스</span>
                    <span class="info-value">${ requestScope.s.className }</span>
                </div>

                <div class="info-row">
                    <span class="info-label">담당 상담사</span>
                    <span class="info-value">${ requestScope.s.counselorName }</span>
                </div>
                
				<c:choose>
					<c:when test="${ requestScope.s.status eq 'ATTENDING' }">
		                <div class="info-row">
		                    <span class="info-label">현재 상태</span>
		                    <span class="status-badge active">재학</span>
		                </div>
	                </c:when>
	                <c:otherwise>
		                <div class="info-row">
		                    <span class="info-label">현재 상태</span>
		                    <span class="status-badge leave">휴학</span>
		                </div>
	                </c:otherwise>
				</c:choose>
				
                <div class="info-row">
                    <span class="info-label">최근 변경일</span>
                    <span class="info-value">${ requestScope.s.updatedAt }</span>
                </div>
            </div>
        </div>

        <div class="memo-card">
            <div class="memo-card-header">
                <div>
                    <h3>메모 기록</h3>
                    <p>특이사항, 휴원 이력 등 내부 관리용 메모를 기록합니다.</p>
                </div>
            </div>
			
            <div class="memo-list">
            </div>

            <div class="memo-input-area">
                <input type="text"
                    class="memo-input"
                    placeholder="메모를 입력하세요.">
                <button type="button" class="btn-primary small" onclick="insertMemo();">등록</button>
            </div>
        </div>

		<script>
			$(function() {
				selectMemoList();
			});
			function selectMemoList() {
				
				$.ajax({
					url : "/know-how/admin/student/mlist",
					type : "get",
					data : {
						userNo : ${ requestScope.s.userNo }
					},
					success : function(result) {
						
						let resultStr = "";
						
						for(let i in result) {
							
							resultStr += "<div class='memo-item'>"
									   + 	"<div class='memo-text'>" + result[i].userMemo + "</div>"
									   + 	"<button type='button' class='memo-delete-btn' onclick='deleteMemo("+ result[i].memoNo +");'>×</button>"
									   + "</div>";
						}
						$(".memo-list").html(resultStr);
					}
				});
			}
			function insertMemo() {
				
				let userMemo = $(".memo-input").val();

				$.ajax({
					url : "/know-how/admin/student/minsert",
					type : "post",
					data : {
						userNo : ${ requestScope.s.userNo },
						userMemo : userMemo
					},
					success : function(result) {
						
						if(result == "success") {
							
							selectMemoList();
							
							$(".memo-input").val("");
							
						} else {
							
							alert("메모 작성에 실패했습니다.");
							
							$(".memo-input").val("");
						}
					},
					error : function(xhr) {
					
						console.log("메모 작성용 ajax 통신 실패!");
					}
						
				});
			}
			function deleteMemo(memoNo) {
				
				$.ajax({
					url : "/know-how/admin/student/mdelete",
					type : "post",
					data : {
						memoNo : memoNo
					},
					success : function(result) {
						
						if(result == "success") {
							
							selectMemoList();
							
						} else {
							
							alert("메모 삭제에 실패했습니다.");
							
						}
					},
					error : function() {
					
						console.log("메모 삭제용 ajax 통신 실패!");
					}
						
				});	
	
			}
			function rest(status) {
				if(status == 'ABSENT') {
					status = 'ATTENDING';
				} else {
					status = 'ABSENT';
				} 
				$.ajax({
					url : "/know-how/admin/student/rest",
					type : "post",
					data : {
						studentNo : ${ requestScope.s.studentNo }, 
						status : status
					},
					success : function(result) {
						
						if(result == "success") {
							
							location.reload();
							
						} else {
							
							alert("상태 변경에 실패했습니다.");
							
						}
					},
					error : function() {
					
						console.log("상태 변경용 ajax 통신 실패!");
					}
				});
			}
			
		</script>
    </section>
</body>
</html>
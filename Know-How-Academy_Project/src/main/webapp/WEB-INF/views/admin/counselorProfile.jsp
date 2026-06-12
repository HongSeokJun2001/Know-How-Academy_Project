<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
	.counselor-detail-section {
	    width: 100%;
	    padding: 40px 52px 80px;
	    box-sizing: border-box;
	}
	
	/* 제목 영역 */
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
	
	/* 상단 프로필 카드 */
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
	
	.profile-img-box img {
	    width: 100%;
	    height: 100%;
	    object-fit: contain;
	    border-radius: 18px;
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
	
	/* 카드 2단 */
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
	
	/* 메모 카드 */
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
	
	.status-badge.inactive {
	    background-color: #f1f2f5;
	    color: #6b7280;
	}
	
	.status-badge.leave {
	    background-color: #fff5d6;
	    color: #c47a00;
	}
	
	/* 버튼 */
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
	
	/* 하단 버튼 */
	.detail-bottom-actions {
	    display: flex;
	    justify-content: space-between;
	    align-items: center;
	}
	
	/* 휴직프로필 어둡게 처리 */
	
	.leave-disabled {
	    background: #f3f4f6;
	}
	
	.memo-input:disabled,
	.memo-delete-btn:disabled,
	.btn-primary:disabled {
	    cursor: not-allowed;
	    opacity: 0.5;
	}

</style>

    <c:set var="ctx"          value="${pageContext.request.contextPath}" />
    <c:set var="statusClass"  value="${'ACTIVE' eq requestScope.counselor.status ? 'active' : 'inactive'}"/>
    <c:set var="statusText"   value="${'ACTIVE' eq requestScope.counselor.status ? '활성' : '비활성'}"/>
    <c:set var="isActive"     value="${'ACTIVE' eq requestScope.counselor.status}"/>

    <!-- 상담사 상세조회 콘텐츠 시작 -->
    <section class="counselor-detail-section">

        <!-- 페이지 제목 -->
        <div class="detail-title-area">
            <div>
                <h2>상담사 상세조회</h2>
                <p>상담사의 기본 정보와 담당 클래스, 상태를 확인합니다.</p>
            </div>

            <button type="button" class="btn-outline"
                    onclick="go('/admin/counselorList')">목록으로</button>
        </div>

        <!-- 상단 프로필 요약 카드 -->
        <div class="profile-summary-card ${isActive ? '' : 'leave-disabled'}">

            <div class="profile-left">
                <div class="profile-img-box">
                    <span>
                        <img src="${ctx}${requestScope.counselor.imgPath}" alt="프로필사진">
                        <!-- /know-how/resources/image/default-profile.png  -->
                    </span>
                </div>

                <div class="profile-text">
                    <h3>${requestScope.counselor.userName}</h3>
                    <p>
                        <span class="status-badge ${statusClass}">${statusText} 상담사</span>
                        <span class="summary-dot">·</span>
                        <c:if test="">
                        <span>${requestScope.counselor.className}반 담당</span>
                        </c:if>
                    </p>
                </div>
            </div>
            <form action="${ctx}/admin/counselor/updateStatus" method="post">
                <input type="hidden" name=userNo value="${requestScope.counselor.userNo}">
                <input type="hidden" name=status value="${requestScope.counselor.status}">
                <div class="profile-right">
                    <button type="submit" class="${isActive ? 'btn-danger' : 'btn-primary'}">
                        ${isActive ? '휴직 처리' : '재직 처리'}
                    </button>
                </div>
            </form>
        </div>

        <!-- 정보 카드 2단 -->
        <div class="detail-card-grid">

            <!-- 기본 정보 -->
            <div class="detail-card ${isActive ? '' : 'leave-disabled'}">
                <div class="detail-card-title">
                    기본 정보
                </div>

                <div class="info-row">
                    <span class="info-label">이름</span>
                    <span class="info-value">${requestScope.counselor.userName}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">연락처</span>
                    <span class="info-value">${requestScope.counselor.phone}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">이메일</span>
                    <span class="info-value">${requestScope.counselor.email}</span>
                </div>
            </div>

            <!-- 근무 정보 -->
            <div class="detail-card ${isActive ? '' : 'leave-disabled'}">
                <div class="detail-card-title">
                    근무 정보
                </div>

                <div class="info-row">
                    <span class="info-label">담당 클래스</span>
                    <span class="info-value">${requestScope.counselor.className}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">상태</span>
                    <span class="status-badge ${statusClass}">${statusText}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">담당 학생수</span>
                    <span class="info-value">${requestScope.counselor.studentCount} 명</span>
                </div>
            </div>
        </div>

        <!-- 메모 기록 카드 -->
        <div class="memo-card ${isActive ? '' : 'leave-disabled'}">
            
            <!-- 메모설명 -->
            <div class="memo-card-header">
                <div>
                    <h3>메모 기록</h3>
                    <p>퇴사 사유, 휴직 이력 등 내부 관리용 메모를 기록합니다.</p>
                </div>
            </div>

            <!-- 메모내용조회 -->
            <div class="memo-list">
            </div>

            <!-- 메모입력 -->
            <div class="memo-input-area">
                <input type="text"
                    class="memo-input"
                    placeholder="메모를 입력하세요.">
                <button type="button" class="btn-primary small" 
                        ${isActive ? '' : 'disabled'}
                        onclick="insertMemo();">
                    등록
                </button>
            </div>
        </div>

        <!-- 하단 버튼 -->
        <div class="detail-bottom-actions">
            <button type="button" class="btn-outline"
                    onclick="go('/admin/counselorList')">목록으로</button>

            <div>
                <button type="button" class="btn-primary" ${isActive ? '' : 'disabled'}>저장</button>
            </div>
        </div>

    </section>
    <!-- 상담사 상세조회 콘텐츠 끝 -->
    <script>
        const isActive = ${pageScope.isActive};
        let disabled = isActive ? "" : " disabled";

        $(function() {
            selectMemoList();
        });

        //메모 목록 재 조회
        function selectMemoList() {

            $.ajax({
                url : "${ctx}/admin/student/mlist",
                type : "get",
                data : {
                    userNo : ${ requestScope.counselor.userNo}
                },
                success : function(result) {
                    
                    let resultStr = "";
                    
                    for(let i in result) {

                        resultStr += "<div class='memo-item'>"
									+     "<div class='memo-text'>" + result[i].userMemo + "</div>"
									+     "<button " + disabled + " type='button' class='memo-delete-btn' onclick='deleteMemo(" + result[i].memoNo + ");'>×</button>"
									+ "</div>";
                    }

                    $(".memo-list").html(resultStr);
                },
                error : function(xhr){

                    if (xhr.status !== 401 && xhr.status !== 403) {
                        console.log("메모 목록 조회 실패!");
                        alert("메모 목록 조회 중 오류가 발생했습니다.");
                    }
                }
            });
        }

        // 메모 추가 후 재조회
        function insertMemo() {
            
            let userMemo = $(".memo-input").val();
			if(userMemo != null && userMemo.trim() !== ""){
				$.ajax({
					url : "${ctx}/admin/student/minsert",
					type : "post",
					data : {
						userNo : ${ requestScope.counselor.userNo },
						userMemo : userMemo
					},
					success : function(result) {
						
						if(result == "success") {
							
							$(".memo-input").val("");

							selectMemoList();

						} else {
							
							alert("메모 작성에 실패했습니다.");

						}
					},
					error : function(xhr) {
					
						if (xhr.status !== 401 && xhr.status !== 403) {
							console.log("메모 추가 실패!");
							alert("메모 추가 중 오류가 발생했습니다.");
						}

					}
						
				});
			}
        }

        //메모삭제 후 재조회
        function deleteMemo(memoNo) {
            
            $.ajax({
                url : "${ctx}/admin/student/mdelete",
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
                error : function(xhr) {
                    
                    if (xhr.status !== 401 && xhr.status !== 403) {
                        console.log("메모 삭제 실패!");
                        alert("메모 삭제 중 오류가 발생했습니다.");
                    }
                 
                }
                    
            });	

        }
    </script>
        
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


    <c:choose>
        <c:when test="${empty requestScope.inviteList}">
            <tr>
                <td colspan="5" align="center">조회된 항목이 없습니다.</td>
            </tr>
        </c:when>
        <c:otherwise>
            <c:forEach var="invite" items="${requestScope.inviteList}">
                <tr>
                    <td>${invite.inviteName}</td>
                    <td>${invite.inviteEmail}</td>
                    <td>${invite.inviteSentAt}</td>
                    <c:set var="lowerStatus" value="${fn:toLowerCase(invite.inviteStatus)}"/>
                    <c:choose>
                        <c:when test="${'PENDING'  eq invite.inviteStatus}">
                            <td>
                                <span class="invite-status pending">초대대기</span>
                            </td>
                            <td data-invite-no="${invite.inviteNo}">
                                <button type="button" class="btn-danger-outline small" onclick="cancelInvite(this)">
                                    초대삭제
                                </button>
                            </td>
                        </tr>
                    </c:when>
                    <c:when test="${'ACTIVE'  eq invite.inviteStatus}">
                            <td>
                                <span class="invite-status used">가입완료</span>
                            </td>
                            <td>
                                <button type="button" class="btn-outline small" onclick="go('/admin/counselorProfile/${invite.userNo}')">
                                    상세보기
                                </button>
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <td colspan="2">
                            <span class="invite-status ${lowerStatus}">${'expired' eq lowerStatus ? '만료' : 'canceled'  eq lowerStatus ? '삭제완료' : '휴직'}</span>
                        </td>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:otherwise>
    </c:choose>

    
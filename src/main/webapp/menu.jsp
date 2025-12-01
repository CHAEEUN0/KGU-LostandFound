<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">

<header class="pb-3 mb-4 border-bottom py-4">

    <div class="d-flex justify-content-between align-items-center">

        <h3 class="m-0">
            <a href="posts.jsp" class="text-dark text-decoration-none fw-bold">
                KGU Lost & Found
            </a>
        </h3>

        <div>
            <%
                String nickname = (String) session.getAttribute("nickname");
            %>

            <c:choose>

                <c:when test="${not empty studentId}">
                    
                    <span class="me-3 text-dark">
                        ${nickname}<fmt:message key="welcome" />
                    </span>

                    <a href="<c:url value='posts.jsp' />" 
                       class="me-2 text-dark text-decoration-none">
                       <fmt:message key="posts" />
                    </a>

                    <a href="<c:url value='myPosts.jsp' />" 
                       class="me-2 text-dark text-decoration-none">
                       <fmt:message key="myPosts" />
                    </a>

                    <a href="<c:url value='logout.jsp' />" 
                       class="text-dark text-decoration-none">
                       <fmt:message key="logout" />
                    </a>

                    <c:set var="qs" value="${pageContext.request.queryString}" />

                    <c:set var="qsClean" value="${fn:replace(qs, 'language=ko', '')}" />
                    <c:set var="qsClean" value="${fn:replace(qsClean, 'language=en', '')}" />
                    <c:set var="qsClean" value="${fn:replace(qsClean, '&&', '&')}" />
                    <c:set var="qsClean" value="${fn:trim(qsClean)}" />

                    <c:choose>
                        <c:when test="${empty qsClean}">
                            <c:set var="langKo" value="?language=ko" />
                            <c:set var="langEn" value="?language=en" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="langKo" value="?${qsClean}&language=ko" />
                            <c:set var="langEn" value="?${qsClean}&language=en" />
                        </c:otherwise>
                    </c:choose>

                    <span class="ms-3">
                        <a href="${langKo}" class="text-decoration-none">Korean</a> |
                        <a href="${langEn}" class="text-decoration-none">English</a>
                    </span>

                </c:when>

                <c:otherwise>
                    
                    <a href="<c:url value='posts.jsp' />" 
                       class="me-2 text-dark text-decoration-none">
                       <fmt:message key="posts" />
                    </a>

                    <a href="<c:url value='login.jsp' />" 
                       class="me-2 text-dark text-decoration-none">
                       <fmt:message key="login" />
                    </a>

                    <a href="<c:url value='register.jsp' />" 
                       class="text-dark text-decoration-none">
                       <fmt:message key="signup" />
                    </a>

                    <c:set var="qs" value="${pageContext.request.queryString}" />

                    <c:set var="qsClean" value="${fn:replace(qs, 'language=ko', '')}" />
                    <c:set var="qsClean" value="${fn:replace(qsClean, 'language=en', '')}" />
                    <c:set var="qsClean" value="${fn:replace(qsClean, '&&', '&')}" />
                    <c:set var="qsClean" value="${fn:trim(qsClean)}" />

                    <c:choose>
                        <c:when test="${empty qsClean}">
                            <c:set var="langKo" value="?language=ko" />
                            <c:set var="langEn" value="?language=en" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="langKo" value="?${qsClean}&language=ko" />
                            <c:set var="langEn" value="?${qsClean}&language=en" />
                        </c:otherwise>
                    </c:choose>

                    <span class="ms-3">
                        <a href="${langKo}" class="text-decoration-none">Korean</a> |
                        <a href="${langEn}" class="text-decoration-none">English</a>
                    </span>

                </c:otherwise>

            </c:choose>
        </div>

    </div>

</header>

</fmt:bundle>

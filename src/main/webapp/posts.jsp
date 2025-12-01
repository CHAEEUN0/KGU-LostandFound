<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>게시글 목록</title>
</head>

<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">
<%@ include file="menu.jsp" %>

<div class="container py-4" style="max-width: 800px;">

    <% String loginId = (String) session.getAttribute("studentId"); %>

    
    <div class="d-flex justify-content-end mb-3">
        <% if (loginId != null) { %>
            <a href="addPost.jsp" class="btn btn-primary btn-sm"><fmt:message key="addPost" /></a>
        <% } else { %>
            <a href="login.jsp" class="btn btn-outline-secondary btn-sm"><fmt:message key="loginToWrite" /></a>
        <% } %>
    </div>

    <%@ include file="dbconn.jsp" %>

    <%
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM Post ORDER BY post_id DESC";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();

        
        PreparedStatement pstmtImg = conn.prepareStatement(
            "SELECT img_path FROM PostImage WHERE post_id = ? LIMIT 1"
        );
    %>

    <ul class="list-group">

    <%
        while (rs.next()) {
            int postId = rs.getInt("post_id");
            String title = rs.getString("title");
            String content = rs.getString("content");
            if (content == null) content = "";
            String preview = content.length() > 30 ? content.substring(0, 30) + "..." : content;

         	// 썸네일용으로 게시글의 첫 번째 이미지만 가져옴
            pstmtImg.setInt(1, postId);
            ResultSet rsImg = pstmtImg.executeQuery();
            String thumbPath = null;
            if (rsImg.next()) {
                thumbPath = rsImg.getString("img_path");
            }
            rsImg.close();
    %>

        <li class="list-group-item py-3">
	    <a href="post.jsp?postId=<%= postId %>" class="text-decoration-none d-flex align-items-center">

        
        <div>
            <h5 class="mb-1 text-dark"><%= title %></h5>
            <p class="text-muted mb-0"><%= preview %></p>
        </div>

        
        <% if (thumbPath != null) { %>
            <img src="resources/images/<%= thumbPath %>" 
                 style="width:70px; height:auto; margin-left:10px;"
                 class="ms-auto">
        <% } %>

    </a>
</li>
    <%
        }

        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (pstmtImg != null) pstmtImg.close();
        if (conn != null) conn.close();
    %>
    </ul>
</div>
</fmt:bundle>
</body>
</html>

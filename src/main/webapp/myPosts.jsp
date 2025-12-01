<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<%
    String studentId = (String) session.getAttribute("studentId");

    if (studentId == null) {
%>
        <script>
            alert("로그인이 필요합니다.");
            location.href = "login.jsp";
        </script>
<%
        return;
    }
%>

<html>
<head>
<title>내 활동</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
</head>
<%@ include file="menu.jsp" %>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">
<div class="container py-4" style="max-width: 900px;">

    
    <h2 class="mb-3"><fmt:message key="myPostsList" /></h2>
    <hr>

    <%@ include file="dbconn.jsp" %>

    <%
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // 내가 작성한 게시글 목록
        String sqlPosts = "SELECT * FROM Post WHERE student_id = ? ORDER BY post_id DESC";
        pstmt = conn.prepareStatement(sqlPosts);
        pstmt.setString(1, studentId);
        rs = pstmt.executeQuery();

        boolean hasPost = false;
    %>

    <ul class="list-group mb-5">

    <%
        while (rs.next()) {
            hasPost = true;

            String title = rs.getString("title");
            String content = rs.getString("content");
            if (content == null) content = "";

            String preview = content.length() > 20 
                    ? content.substring(0, 20) + "..." 
                    : content;
    %>

        
        <li class="list-group-item">
            <h5 class="mb-1">
                <a href="post.jsp?postId=<%=rs.getInt("post_id")%>" class="text-decoration-none">
                    <%= title %>
                </a>
            </h5>
            <p class="text-muted mb-0"><%= preview %></p>
        </li>

    <%
        }
        if (!hasPost) {
    %>
        <li class="list-group-item text-muted"><fmt:message key="noMyPosts" /></li>
    <%
        }
    %>

    </ul>

    <%
        rs.close();
        pstmt.close();

        // 내가 작성한 댓글 
        String sqlComments =
            "SELECT c.comment_id, c.content, c.created_at, p.post_id, p.title " +
            "FROM Comment c JOIN Post p ON c.post_id = p.post_id " +
            "WHERE c.student_id = ? ORDER BY c.comment_id DESC";

        pstmt = conn.prepareStatement(sqlComments);
        pstmt.setString(1, studentId);
        rs = pstmt.executeQuery();

        boolean hasComment = false;
    %>

   
    <h2 class="mt-4 mb-3"><fmt:message key="myCommentsList" /></h2>
    <hr>

    <ul class="list-group">

    <%
        while (rs.next()) {
            hasComment = true;
    %>

        <li class="list-group-item">
            <p class="mb-1">
                <b>
                    [<a href="post.jsp?postId=<%=rs.getInt("post_id")%>" class="text-decoration-none">
                        <%= rs.getString("title") %>
                    </a>]
                </b>
            </p>
            <p class="text-muted mb-0"><%= rs.getString("content") %></p>
        </li>

    <%
        }
        if (!hasComment) {
    %>
        <li class="list-group-item text-muted"><fmt:message key="noMyComments" /></li>
    <%
        }

        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    %>

    </ul>

</div>
</fmt:bundle>
</body>
</html>

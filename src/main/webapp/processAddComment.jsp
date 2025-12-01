<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
    request.setCharacterEncoding("utf-8");

    String postId = request.getParameter("postId");
    String content = request.getParameter("content");
    String studentId = (String)session.getAttribute("studentId");

    if (studentId == null) {
%>
        <script>
            alert("로그인이 필요합니다.");
            location.href = "login.jsp";
        </script>
<%
        return;
    }

    
    if (content == null || content.trim().equals("")) {
%>
        <script>
            alert("댓글 내용을 입력하세요.");
            history.back();
        </script>
<%
        return;
    }

    PreparedStatement pstmt = null;

    String sql = "INSERT INTO Comment (post_id, student_id, content) VALUES (?, ?, ?)";

    pstmt = conn.prepareStatement(sql);
    pstmt.setString(1, postId);
    pstmt.setString(2, studentId);
    pstmt.setString(3, content);
    pstmt.executeUpdate();

    if (pstmt != null) pstmt.close();
    if (conn != null) conn.close();

    // 다시 글로 이동
    response.sendRedirect("post.jsp?postId=" + postId);
%>

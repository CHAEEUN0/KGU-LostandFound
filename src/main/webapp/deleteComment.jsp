<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
    String commentId = request.getParameter("commentId");
    String postId = request.getParameter("postId");
    String loginId = (String)session.getAttribute("studentId");

    if (loginId == null) {
%>
    <script>alert("로그인이 필요합니다."); history.back();</script>
<%
        return;
    }

    // 본인 댓글인지 확인
    PreparedStatement check = conn.prepareStatement(
        "SELECT student_id FROM Comment WHERE comment_id=?"
    );
    check.setString(1, commentId);
    ResultSet rs = check.executeQuery();

    boolean canDelete = false;

    if (rs.next() && loginId.equals(rs.getString("student_id"))) {
        canDelete = true;
    }

    rs.close();
    check.close();

    if (!canDelete) {
%>
    <script>alert("본인의 댓글만 삭제할 수 있습니다."); history.back();</script>
<%
        return;
    }

    PreparedStatement pstmt = conn.prepareStatement(
        "DELETE FROM Comment WHERE comment_id=?"
    );
    pstmt.setString(1, commentId);
    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("post.jsp?postId=" + postId);
%>

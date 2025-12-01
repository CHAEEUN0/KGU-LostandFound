<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
    String postId = request.getParameter("postId");
    String loginId = (String)session.getAttribute("studentId");

    if (loginId == null) {
%>
    <script>alert("로그인이 필요합니다."); location.href="login.jsp";</script>
<%
        return;
    }

    // 본인 글인지 확인
    PreparedStatement check = conn.prepareStatement(
        "SELECT student_id FROM Post WHERE post_id=?"
    );
    check.setString(1, postId);
    ResultSet rs = check.executeQuery();

    if (!(rs.next() && loginId.equals(rs.getString("student_id")))) {
%>
        <script>alert("본인의 글만 삭제 가능합니다."); history.back();</script>
<%
        return;
    }

    rs.close();
    check.close();

    // 글 삭제 
    PreparedStatement pstmt = conn.prepareStatement(
        "DELETE FROM Post WHERE post_id=?"
    );
    pstmt.setString(1, postId);
    pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("posts.jsp");
%>

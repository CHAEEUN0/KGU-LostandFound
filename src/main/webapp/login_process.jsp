<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=utf-8" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pw = request.getParameter("password");
%>

<%@ include file="dbconn.jsp" %>

<%
PreparedStatement pstmt = null;
ResultSet rs = null;

String sql = "SELECT * FROM Student WHERE student_id=? AND password=?";
pstmt = conn.prepareStatement(sql);
pstmt.setString(1, id);
pstmt.setString(2, pw);

rs = pstmt.executeQuery();

if (rs.next()) {
    // 세션 설정
    session.setAttribute("studentId", id);
    session.setAttribute("nickname", rs.getString("nickname"));

    // 로그인 성공시 글 목록으로 이동
    response.sendRedirect("posts.jsp");
} else {
%>
    <script>
        alert("아이디 또는 비밀번호가 잘못되었습니다.");
        history.back();
    </script>
<%
}

if (rs != null) rs.close();
if (pstmt != null) pstmt.close();
if (conn != null) conn.close();
%>

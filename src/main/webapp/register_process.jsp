<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String nickname = request.getParameter("nickname");
String studentId = request.getParameter("id");
String password = request.getParameter("password");
String checkPassword = request.getParameter("checkPassword");



PreparedStatement checkPstmt = conn.prepareStatement(
    "SELECT * FROM Student WHERE student_id=?"
);
checkPstmt.setString(1, studentId);

ResultSet rs = checkPstmt.executeQuery();

if (rs.next()) {
%>
    <script>
        alert("이미 존재하는 학번입니다.");
        history.back();
    </script>
<%
    rs.close();
    checkPstmt.close();
    conn.close();
    return;
}

rs.close();
checkPstmt.close();


PreparedStatement pstmt = conn.prepareStatement(
    "INSERT INTO Student (nickname, student_id, password) VALUES (?, ?, ?)"
);
pstmt.setString(1, nickname);
pstmt.setString(2, studentId);
pstmt.setString(3, password);

pstmt.executeUpdate();


pstmt.close();
conn.close();
%>

<script>
    alert("회원가입이 완료되었습니다! 로그인 페이지로 이동합니다.");
    location.href = "login.jsp";
</script>

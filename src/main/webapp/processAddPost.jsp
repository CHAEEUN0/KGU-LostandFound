<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp" %>

<%
request.setCharacterEncoding("UTF-8");


String realFolder = application.getRealPath("/resources/images");
int maxSize = 5 * 1024 * 1024; 
String encType = "utf-8";


MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());


String title = multi.getParameter("title");
String content = multi.getParameter("content");


String studentId = (String)session.getAttribute("studentId");


String sqlPost = "INSERT INTO Post (title, content, student_id) VALUES (?, ?, ?)";

PreparedStatement pstmt = conn.prepareStatement(sqlPost, Statement.RETURN_GENERATED_KEYS);
pstmt.setString(1, title);
pstmt.setString(2, content);
pstmt.setString(3, studentId);

pstmt.executeUpdate();


ResultSet rs = pstmt.getGeneratedKeys();
int postId = 0;
if (rs.next()) {
    postId = rs.getInt(1);
}
rs.close();
pstmt.close();

// PostImage 테이블에 사진 저장
Enumeration files = multi.getFileNames();

while (files.hasMoreElements()) {
    String inputName = (String) files.nextElement();
    String fileName = multi.getFilesystemName(inputName);

    if (fileName != null) {
        String sqlImg = "INSERT INTO PostImage (post_id, img_path) VALUES (?, ?)";
        PreparedStatement pstmtImg = conn.prepareStatement(sqlImg);
        pstmtImg.setInt(1, postId);
        pstmtImg.setString(2, fileName);
        pstmtImg.executeUpdate();
        pstmtImg.close();
    }
}


if (conn != null) conn.close();

// 글 목록 페이지로 이동
response.sendRedirect("posts.jsp");

%>

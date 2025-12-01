<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>게시글 상세보기</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
</head>

<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">
<%@ include file="menu.jsp" %>
<div class="container py-4" style="max-width: 800px;">


    <%
        String postId = request.getParameter("postId");
        String loginId = (String)session.getAttribute("studentId");
    %>

    <%@ include file="dbconn.jsp" %>

    <%
        // 게시글 조회
        PreparedStatement pstmtPost = conn.prepareStatement(
            "SELECT * FROM Post WHERE post_id = ?"
        );
        pstmtPost.setString(1, postId);
        ResultSet rsPost = pstmtPost.executeQuery();

        String title = "";
        String content = "";
        String writerId = "";

        if (rsPost.next()) {
            title = rsPost.getString("title");
            content = rsPost.getString("content");
            writerId = rsPost.getString("student_id");
        }
        rsPost.close();
        pstmtPost.close();

        // 작성자 닉네임
        PreparedStatement pstmtNick = conn.prepareStatement(
            "SELECT nickname FROM Student WHERE student_id = ?"
        );
        pstmtNick.setString(1, writerId);
        ResultSet rsNick = pstmtNick.executeQuery();

        String writerNick = "";
        if (rsNick.next()) writerNick = rsNick.getString("nickname");

        rsNick.close();
        pstmtNick.close();
    %>

    <!-- 게시글 내용 -->
    <h3><b><%= title %></h3>
    <p><fmt:message key="nickname" />: <%= writerNick %></p><br>
    <h5><%= content %></h5>

    <!-- 게시글 이미지 -->
    <%
        PreparedStatement pstmtImg = conn.prepareStatement(
            "SELECT img_path FROM PostImage WHERE post_id = ?"
        );
        pstmtImg.setString(1, postId);
        ResultSet rsImg = pstmtImg.executeQuery();
    %>

    <div class="mb-3">
    <%
        while (rsImg.next()) {
    %>
        <img src="resources/images/<%= rsImg.getString("img_path") %>" width="200">
    <%
        }
        rsImg.close();
        pstmtImg.close();
    %>
    </div>

    <%
        // 글 수정/삭제 버튼 (작성자만)
        if (loginId != null && loginId.equals(writerId)) {
    %>
        <div class="mb-3">
            <a href="deletePost.jsp?postId=<%= postId %>"
               onclick="return confirm('정말 삭제하시겠습니까?');"
               class="btn btn-secondary btn-sm">글 삭제</a>
        </div>
    <%
        }
    %>

    <hr>

    <!-- 댓글 작성 -->
    <h4><fmt:message key="comments" /></h4>

    <%
        if (loginId == null) {
    %>
        <p>로그인 후 댓글 작성 가능합니다.</p>
    <%
        } else {
    %>
        <form action="processAddComment.jsp" method="post">
            <input type="hidden" name="postId" value="<%= postId %>">
            <textarea name="content" rows="3" class="form-control mb-2"></textarea>
            <button type="submit" class="btn btn-primary btn-sm"><fmt:message key="addComment" /></button>
        </form>
    <%
        }
    %>

    <hr>

    <%
        PreparedStatement pstmtC = conn.prepareStatement(
            "SELECT c.comment_id, c.content, c.student_id, c.created_at, s.nickname " +
            "FROM Comment c JOIN Student s ON c.student_id = s.student_id " +
            "WHERE c.post_id = ? ORDER BY c.comment_id ASC"
        );
        pstmtC.setString(1, postId);
        ResultSet rsC = pstmtC.executeQuery();

        while (rsC.next()) {
            String cWriterId = rsC.getString("student_id");
            String cWriterNick = rsC.getString("nickname");
    %>

        <div class="mb-3">
            <p><b><%= cWriterNick %></b>: <%= rsC.getString("content") %></p>

            <% if (loginId != null && loginId.equals(cWriterId)) { %>
                <a href="deleteComment.jsp?commentId=<%= rsC.getInt("comment_id") %>&postId=<%= postId %>"
                   onclick="return confirm('댓글을 삭제하시겠습니까?');"
                   class="btn btn-secondary btn-sm">
                   댓글 삭제
                </a>
            <% } %>

            <hr>
        </div>

    <%
        }

        rsC.close();
        pstmtC.close();
        conn.close();
    %>

</div>
</fmt:bundle>
</body>
</html>

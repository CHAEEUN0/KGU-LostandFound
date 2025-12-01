<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*" %>

<html>
<head>
<title>글 작성</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript">
	function CheckAddPost(){
		var form = document.newPost;
		if (form.title.value == ""){
			alert("제목을 입력하세요.");
			form.title.focus();
			return false;
		}
		if (form.content.value == ""){
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		form.submit();
	}
</script>
</head>

<body>
<%@ include file="menu.jsp" %>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<div class="container my-4 py-5">

	<div class="col-md-6 mx-auto">

		<form name="newPost" action="./processAddPost.jsp" method="post" enctype="multipart/form-data">

			<fmt:bundle basename="resourceBundle.message">

				
				<div class="mb-3">
					<label class="form-label">
						<fmt:message key="title" />
					</label>
					<input type="text" name="title" id="title" class="form-control">
				</div>

				
				<div class="mb-3">
					<label class="form-label">
						<fmt:message key="content" />
					</label>
					<textarea name="content" id="content" rows="5" class="form-control"></textarea>
				</div>

				
				<div class="mb-3">
					<label class="form-label">
						<fmt:message key="postImage" />
					</label>
					<input type="file" name="postImages" multiple class="form-control">
				</div>

		
				<div>
				    <input 
				        type="button" 
				        value="<fmt:message key='addPost' />" 
				        onclick="CheckAddPost()" 
				        class="btn btn-primary w-100"
				    >
				</div>

			</fmt:bundle>

		</form>

	</div>

</div>

</body>
</html>

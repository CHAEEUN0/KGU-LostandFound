<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<title>로그인</title>
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">
<div class="container my-4 py-5">

 	<div class="text-center mb-1">
    <h3 class="m-0">
    <a href="posts.jsp" class="text-decoration-none text-dark">
        <b>KGU Lost & Found</b>
    </a>
	</h3>

	    <div class="d-flex justify-content-end" style="margin-top: -5px;">
	        <div>
	            <a href="?language=ko" class="text-decoration-none me-1">Korean</a> |
	            <a href="?language=en" class="text-decoration-none ms-1">English</a>
	        </div>
	    </div>
    </div>
	
    <div class="col-md-4 mx-auto">

        <form name="login" action="login_process.jsp" method="post">
            
            <div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="studentId" />
			    </label>
			    <input type="text" name="id" class="form-control">
			</div>
			
			<div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="password" />
			    </label>
			    <input type="password" name="password" class="form-control">
			</div>
			
			<div class="mb-3">
			    <input type="submit" value="<fmt:message key='login' />"
			           class="btn btn-primary w-100">
			</div>
			
			<div class="mb-3">
			    <a href="register.jsp" class="btn btn-secondary w-100">
			        <fmt:message key="signup" />
			    </a>
			</div>


        </form>
    </div>
</div>
</fmt:bundle>
</body>
</html>

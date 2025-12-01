<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
<script type="text/javascript" src="./resources/js/validation.js"></script>
<title>회원가입</title>
</head>
<body>
<fmt:setLocale value='<%=request.getParameter("language") %>' />
<fmt:bundle basename="resourceBundle.message">
<div class="container my-4 py-5">

	<div class="text-center mb-1">
    <h3 class="m-0"> <b>KGU Lost & Found</b> </h3>

	    <div class="d-flex justify-content-end" style="margin-top: -5px;">
	        <div>
	            <a href="?language=ko" class="text-decoration-none me-1">Korean</a> |
	            <a href="?language=en" class="text-decoration-none ms-1">English</a>
	        </div>
	    </div>
    </div>
	
	<div class="col-md-4  mx-auto">
		<form name="newStudent" method="post" action="register_process.jsp">
			<div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="nickname" />
			    </label>
			    <input type="text" id="nickname" name="nickname" class="form-control">
			</div>
			
			<div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="studentId" />
			    </label>
			    <input type="text" id="id" name="id" class="form-control">
			</div>
			
			<div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="password" />
			    </label>
			    <input type="password" id="password" name="password" class="form-control">
			</div>
			
			<div class="mb-3">
			    <label class="form-label">
			        <fmt:message key="checkpassword" />
			    </label>
			    <input type="password" id="checkPassword" name="checkPassword" class="form-control">
			</div>
			
			<div class="mb-3">
			    <input type="submit" value="<fmt:message key='signup' />"
			           onclick="return CheckRegister()" class="form-control btn btn-primary">
			</div>

		</form>
	</div>	
</div>
</fmt:bundle>
</body>
</html>
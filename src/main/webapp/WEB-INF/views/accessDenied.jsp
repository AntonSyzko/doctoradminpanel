<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<meta name="author" content="Anton Syzko antonio.shizko@gmail.com">

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>AccessDenied page</title>



	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>




	
</head>
<body>
<div class="generic-container">
	<div class="panel panel-danger">
		<div class="panel-heading">
			<span  class="glyphicon glyphicon-alert" style="color:#d43f3a;font-size:200%;font-weight:bold;text-shadow: 1px 1px darkorange">   Revered   <strong style="color:#46b8da;font-weight:bolder;font-size: 160%">${loggedinuser}</strong>, You are not authorized to access this page.</span>

		</div>
		<div class="panel-body"><span class="floatRight"><a href="<c:url value="/logout" />" class="btn btn-info btn-lg"><span  class="glyphicon glyphicon-log-out"></span>Log out
	</a></span>
			<a href="<c:url value='/list' />" class="btn btn-info btn-lg">
				<span class="glyphicon glyphicon-home"></span> Back to UserList
			</a>
	</div>
</div>
	</div>
</body>
</html>
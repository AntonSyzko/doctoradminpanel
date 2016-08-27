<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<meta name="author" content="Anton Syzko antonio.shizko@gmail.com">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" />
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>

<link href="<c:url value='/static/css/bootstrap.css' />"  rel="stylesheet"></link>
<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>




<body class="w3-container w3-section w3-green">

<div class="w3-container w3-section w3-green" style="margin-left: 14%">
    <h1><i style="font-size:40px;color:red" class="fa">&#xf0fa;</i> PRIVATE    DOCTOR     ADMINISTRATION   PANEL  <i style="font-size:40px;color:red" class="fa">&#xf0fa;</i> </h1>
</div>

<div id="mainWrapper">
    <div class="login-container">
        <div class="login-card">
            <div class="login-form">
                <c:url var="loginUrl" value="/login" />
                <form action="${loginUrl}" method="post" class="form-horizontal">
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger">
                            <p style="margin-left: 15%">    INVALID    USERNAME    /   PASSWORD   </p>
                        </div>
                    </c:if>
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success">
                            <p> YOU HAVE BEEN LOGGED OUT SUCCESSFULLY </p>
                        </div>
                    </c:if>
                    <div class="input-group input-sm">
                        <label class="input-group-addon" for="username"><i class="fa fa-user"></i></label>
                        <input type="text" class="form-control" id="username" name="ssoId" placeholder="use:testAdmin" required>

                    </div>
                    <div class="input-group input-sm">
                        <label class="input-group-addon" for="password"><i class="fa fa-lock"></i></label>
                        <input type="password" class="form-control" id="password" name="password" placeholder="use:testAdmin" required>
                    </div>
                    <div class="input-group input-sm">
                        <div class="checkbox" style="color: inherit">
                            <label><input type="checkbox" id="rememberme" name="remember-me"  > REMEMBER ME </label>
                        </div>
                    </div>
                    <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />

                    <div class="form-actions">
                        <input type="submit"
                               class="btn btn-block btn-success btn-lg raised" value="Log in">
                    </div>
                              <h5 style="text-align:center; margin-left: 1%;color:inherit">Automatic LOGOUT after 30 mins of inactivity</h5>
                </form>
            </div>
        </div>
    </div>
</div>
<%--<img src="doctora.jpg" alt="Car" style="width:50%">--%>


<div class="w3-container w3-section w3-green">
    <p style="margin-left: 80%">&#169 developed by  <a href="mailto:antonsyzko@gmail.com"> antonsyzko@gmail.com</a></p>
    <button  onclick="location.href = 'https://uk.linkedin.com/pub/anton-syzko/123/9ab/b70';" style="font-size:24px;color:#00bcd4;margin-left: 30%" alt="View Anton Syzko's profile on LinkedIn" >my LinkedIN profile <i class="fa fa-linkedin-square"></i></button>
   <button style="font-size:24px;color: #00bcd4;"  onclick="location.href = 'https://github.com/AntonSyzko/doctoradministrationpanel';" alt="View Anton Syzko's profile on GitHub">Code on GITHUB <i class="fa fa-github-square"></i></button>
    <h2><span class="glyphicon glyphicon-earphone"></span>     (+351)91611142 Rua capitaes de Abril 13-4ESQ 2650 - 352 Alfornelos Lisbon</h2>
</div>


</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>

<head>
	<meta name="author" content="Anton Syzko antonio.shizko@gmail.com">

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<%--<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>--%>
	<%--<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>--%>






	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



	<script type="text/javascript">
		$(function() { $( ".datepicker" ).datepicker({ dateFormat: 'yy-mm-dd' }); });
	</script>

	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js" type="text/javascript"></script>
	<link type="text/css" rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css"  />
	<script src="static/js/store.min.js" type="text/javascript"></script>
	<script src="static/js/jquery-idleTimeout.min.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" />


<%--session time out --%>
	<script type="text/javascript" charset="utf-8">
		$(document).ready(function (){
			$(document).idleTimeout({
				redirectUrl: '/logout',      // redirect to this url on logout. Set to "redirectUrl: false" to disable redirect
				// idle settings
				idleTimeLimit: 1500,           // 'No activity' time limit in seconds. 1200 = 20 Minutes
				idleCheckHeartbeat: 2,       // Frequency to check for idle timeouts in seconds
				// optional custom callback to perform before logout
				customCallback: false,       // set to false for no customCallback
				// customCallback:    function () {    // define optional custom js function
				// perform custom action before logout
				// },
				// configure which activity events to detect
				// http://www.quirksmode.org/dom/events/
				// https://developer.mozilla.org/en-US/docs/Web/Reference/Events
				activityEvents: 'click keypress scroll wheel mousewheel mousemove', // separate each event with a space
				// warning dialog box configuration
				enableDialog: true,           // set to false for logout without warning dialog
				dialogDisplayLimit: 300,       // 20 seconds for testing. Time to display the warning dialog before logout (and optional callback) in seconds. 180 = 3 Minutes
				dialogTitle: 'Session Expiration Warning', // also displays on browser title bar
				dialogText: 'Because you have been inactive, your session is about to expire.',
				dialogTimeRemaining: 'Time remaining',
				dialogStayLoggedInButton: 'Stay Logged In',
				dialogLogOutNowButton: 'Log Out Now',
				// error message if https://github.com/marcuswestin/store.js not enabled
				errorAlertMessage: 'Please disable "Private Mode", or upgrade to a modern browser. Or perhaps a dependent file missing. Please see: https://github.com/marcuswestin/store.js',
				// server-side session keep-alive timer
				sessionKeepAliveTimer: false,   // ping the server at this interval in seconds. 600 = 10 Minutes. Set to false to disable pings
				sessionKeepAliveUrl: window.location.href // set URL to ping - does not apply if sessionKeepAliveTimer: false
			});
		});
	</script>




</head>

<body>

<div class="panel panel-info">
	<%--<div class="panel-heading"> User Registration Form</div>--%>
	<div class="panel-body">

		<div class="generic-container">
			<%@include file="authheader.jsp" %>

			<div class="well lead">  PATIENT  REGISTRATION  FORM  </div>
			<form:form method="POST" modelAttribute="user" class="form-horizontal">
				<form:input type="hidden" path="id" id="id"/>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="firstName"><span class="glyphicon glyphicon-user">   </span>  FIRST  NAME   </label>
						<div class="col-md-7">
							<form:input type="text" path="firstName" id="firstName" class="form-control input-sm" />
							<div class="has-error">
								<form:errors path="firstName" class="help-inline" cssStyle="color: #c12e2a"/>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="lastName"><span class="glyphicon glyphicon-user">   </span>  LAST  NAME   </label>
						<div class="col-md-7">
							<form:input type="text" path="lastName" id="lastName" class="form-control input-sm"    />
							<div class="has-error">
								<form:errors path="lastName" class="help-inline" cssStyle="color: #c12e2a"/>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="ssoId"><span class="glyphicon glyphicon-edit">    </span>  LOGIN   </label>
						<div class="col-md-7">
							<c:choose>
								<c:when test="${edit}">
									<form:input type="text" path="ssoId" id="ssoId" class="form-control input-sm"  disabled="true"  />
								</c:when>
								<c:otherwise>
									<form:input type="text" path="ssoId" id="ssoId" class="form-control input-sm" />
									<div class="has-error">
										<form:errors path="ssoId" class="help-inline" cssStyle="color: #c12e2a"/>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="password"><span class="glyphicon glyphicon-edit">   </span>   PASSWORD  </label>
						<div class="col-md-7">
							<form:input type="password" path="password" id="password" class="form-control input-sm"  />
							<div class="has-error">
								<form:errors path="password" class="help-inline" cssStyle="color: #c12e2a"/>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">

						<label class="col-md-3 control-lable" for="email"><span class="glyphicon glyphicon-envelope">    </span>    EMAIL   </label>
						<div class="col-md-7">
							<form:input type="text" path="email" id="email" class="form-control input-sm"  pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"   />
							<div class="has-error">
								<form:errors path="email" class="help-inline" cssStyle="color: #c12e2a"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="email"><span class="glyphicon glyphicon-phone">     </span>    PHONE   </label>
						<div class="col-md-7">
							<form:input type="text" path="phone" id="phone" class="form-control input-sm"  />
							<div class="has-error">
								<form:errors path="phone" class="help-inline"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="joining_date"><span class="glyphicon glyphicon-calendar">     </span>   REGISTRATION  DATE (YYYY-MM-DD)   </label>
						<div class="col-md-7">
							<form:input type="date" path="joining_date"  id="datepicker" class="form-control input-sm datepicker"  palceholder="YYYY-MM-DD" />
							<div class="has-error">
								<form:errors path="joining_date" class="help-inline"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="description"><span class="glyphicon glyphicon-list-alt">     </span>   DESCRIPTION   </label>
						<div class="col-md-7">
							<form:input type="text" path="description" id="description" class="form-control input-sm"  />
							<div class="has-error">
								<form:errors path="description" class="help-inline"/>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-group col-md-12">
						<label class="col-md-3 control-lable" for="userProfiles"><span class="glyphicon glyphicon-menu-hamburger">   </span>  ROLES   </label>
						<div class="col-md-7">
							<form:select path="userProfiles" items="${roles}" multiple="true" itemValue="id" itemLabel="type" class="form-control input-sm" />
							<div class="has-error">
								<form:errors path="userProfiles" class="help-inline"  cssStyle="color: #c12e2a"/>
							</div>
						</div>
					</div>
				</div>

				<div class="row">
					<div class="form-actions floatRight">
						<c:choose>
							<c:when test="${edit}">
								<%--<input type="submit" value="Update" class="btn btn-primary btn-sm"/> or <a href="<c:url value='/list' />">Cancel</a>--%>

								<div class="panel-footer clearfix">
									<div class="pull-right">


											<input type="submit" value="Update" class="btn btn-success"/> or <a class="btn btn-danger" href="<c:url value='/list' />"><span class="glyphicon glyphicon-ban-circle"></span> Cancel</a>


									</div>
								</div>

							</c:when>
							<c:otherwise>
								<input style="margin-left: 35%" type="submit" value="REGISTER" class="btn btn-info btn-lg "/> or <a href="<c:url value='/list' />" class="btn btn-info btn-lg">
								<span class="glyphicon glyphicon-home"></span> BACK TO PATIENT LIST
							</a>


							</c:otherwise>
						</c:choose>
					</div>
				</div>





				<c:if test="${edit}">
			<span class="well pull-left">
				<%--<a href="<c:url value='/add-document-${user.id}' />">Click here to upload/manage your documents</a>--%>
         <a href="<c:url value='/add-document-${user.id}' />" class="btn btn-info btn-lg">
          <span class="glyphicon glyphicon-download-alt"></span> Click here to upload/manage your documents
        </a>
			</span>
				</c:if>
			</form:form>
		</div>
	</div>
		<span style="color: #1b6d85;margin-left: 70%"> Automatic LOGOUT after 30 mins of inactivity</span>    <p style="margin-left: 70%">&#169 developed by  <a href="mailto:antonsyzko@gmail.com"> antonsyzko@gmail.com</a></p>

</div>

</body>
</html>
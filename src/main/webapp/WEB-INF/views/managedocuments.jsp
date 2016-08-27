<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<html>

<head>
	<meta name="author" content="Anton Syzko antonio.shizko@gmail.com">

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Upload/Download/Delete Documents</title>
	<%--<link href="<c:url value='/static/css/bootstrap.css' />" rel="stylesheet"></link>--%>
	<%--<link href="<c:url value='/static/css/app.css' />" rel="stylesheet"></link>--%>




	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

  <style>
	  div.scrollable {
		  width: 100%;
		  height: 100%;
		  margin: 0;
		  padding: 0;
		  overflow: auto;
	  }
  </style>
	<%--pagination--%>
	<script type="text/javascript">
		$.fn.pageMe = function(opts){
			var $this = this,
					defaults = {
						perPage: 7,
						showPrevNext: false,
						hidePageNumbers: false
					},
					settings = $.extend(defaults, opts);

			var listElement = $this;
			var perPage = settings.perPage;
			var children = listElement.children();
			var pager = $('.pager');

			if (typeof settings.childSelector!="undefined") {
				children = listElement.find(settings.childSelector);
			}

			if (typeof settings.pagerSelector!="undefined") {
				pager = $(settings.pagerSelector);
			}

			var numItems = children.size();
			var numPages = Math.ceil(numItems/perPage);

			pager.data("curr",0);

			if (settings.showPrevNext){
				$('<li><a href="#" class="prev_link">«</a></li>').appendTo(pager);
			}

			var curr = 0;
			while(numPages > curr && (settings.hidePageNumbers==false)){
				$('<li><a href="#" class="page_link">'+(curr+1)+'</a></li>').appendTo(pager);
				curr++;
			}

			if (settings.showPrevNext){
				$('<li><a href="#" class="next_link">»</a></li>').appendTo(pager);
			}

			pager.find('.page_link:first').addClass('active');
			pager.find('.prev_link').hide();
			if (numPages<=1) {
				pager.find('.next_link').hide();
			}
			pager.children().eq(1).addClass("active");

			children.hide();
			children.slice(0, perPage).show();

			pager.find('li .page_link').click(function(){
				var clickedPage = $(this).html().valueOf()-1;
				goTo(clickedPage,perPage);
				return false;
			});
			pager.find('li .prev_link').click(function(){
				previous();
				return false;
			});
			pager.find('li .next_link').click(function(){
				next();
				return false;
			});

			function previous(){
				var goToPage = parseInt(pager.data("curr")) - 1;
				goTo(goToPage);
			}

			function next(){
				goToPage = parseInt(pager.data("curr")) + 1;
				goTo(goToPage);
			}

			function goTo(page){
				var startAt = page * perPage,
						endOn = startAt + perPage;

				children.css('display','none').slice(startAt, endOn).show();

				if (page>=1) {
					pager.find('.prev_link').show();
				}
				else {
					pager.find('.prev_link').hide();
				}

				if (page<(numPages-1)) {
					pager.find('.next_link').show();
				}
				else {
					pager.find('.next_link').hide();
				}

				pager.data("curr",page);
				pager.children().removeClass("active");
				pager.children().eq(page+1).addClass("active");

			}
		};

		$(document).ready(function(){

			$('#myTable').pageMe({pagerSelector:'#myPager',showPrevNext:true,hidePageNumbers:false,perPage:5});

		});
	</script>


	<%--front-end session timeout control--%>
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/jquery-ui.min.js" type="text/javascript"></script>
	<link type="text/css" rel="stylesheet" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.3/themes/smoothness/jquery-ui.css"  />
	<script src="static/js/store.min.js" type="text/javascript"></script>
	<script src="static/js/jquery-idleTimeout.min.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.3/css/font-awesome.css" />


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

	<style>
		table {
			border-collapse: separate;
			border-spacing: 4px;
		}
		table,
		th,
		td {
			border: 1px solid #cecfd5;
		}
		th,
		td {
			padding: 10px 15px;
		}

		th {
			text-align: center;
		}


	</style>


</head>

<body>

<div class="panel panel-info">
	<div class="panel-heading"><span style="color:#46b8da;font-size:200%;font-weight:bold;text-shadow: 2px 2px #c4e3f3"> LIST OF DOCUMENTS  FOR <span style="font-size: 150%">${user.firstName}  ${user.lastName}</span> </span>
		<div class="well" style="margin-left: 60%">
			<a href="<c:url value='/list' />" class="btn btn-info btn-lg" style="margin-left: 20%">
				<span class="glyphicon glyphicon-home"></span> BACK TO PATIENT LIST
			</a>

		</div></div>
	<div class="panel-body">
		<div class="generic-container">
			<div class="panel panel-default">
				<!-- Default panel contents -->
				<%--<div class="panel-heading"><span class="lead">List of Documents </span></div>--%>
				<div class="tablecontainer" >
					<table class="table table-hover">
						<thead>
						<tr class="info">
							<th>NO.</th>
							<th>FILE NAME</th>
							<th>TYPE</th>
							<th>DESCRIPTION</th>
							<th width="100"></th>
							<th width="100"></th>
						</tr>
						</thead>
						<tbody id="myTable">
						<c:forEach items="${documents}" var="doc" varStatus="counter">
							<tr class = "active">
								<td>${counter.index + 1}</td>
								<td>${doc.name}</td>
								<td>${doc.type}</td>
								<td style ="word-break:break-all">  ${doc.description}</td>
								<td><a href="<c:url value='/download-document-${user.id}-${doc.id}' />" class="btn btn-success custom-width"><span class="glyphicon glyphicon-download"></span>download</a></td>
								<td><a href="<c:url value='/delete-document-${user.id}-${doc.id}' />" class="btn btn-danger custom-width"><span class="glyphicon glyphicon-trash"></span>delete</a></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>

				</div>

			</div>
			<div class="col-md-12 text-center">
				<ul class="pagination pagination-lg pager" id="myPager"></ul>
			</div>
			<div class="panel panel-default">

				<div class="panel-heading"><span class="lead">UPLOAD NEW DOCUMENT</span></div>
				<div class="uploadcontainer">
					<form:form method="POST" modelAttribute="fileBucket" enctype="multipart/form-data" class="form-horizontal">

						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md-3 control-lable" for="file">UPLOAD A DOCUMENT</label>
								<div class="col-md-7">
									<form:input type="file" path="file" id="file" class="form-control input-sm"/>
									<div class="has-error">
										<form:errors path="file" class="help-inline" cssStyle="color: #d43f3a"/>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="form-group col-md-12">
								<label class="col-md-3 control-lable" for="file">DESCRIPTION</label>
								<div class="col-md-7">
									<form:input type="text"  rows="5" path="description" id="description" class="form-control input-sm"/>
									<div class="form-actions floatRight">
										<input type="submit" value="Upload" class="btn btn-info btn-lg">
									</div>
								</div>

							</div>


						</div>

						<%--<div class="row">--%>
							<%--<div class="form-actions floatRight">--%>
								<%--<input type="submit" value="Upload" class="btn btn-info btn-lg">--%>
							<%--</div>--%>
						<%--</div>--%>

					</form:form>
				</div>
			</div>

		</div>

	</div>
	<span style="color: #1b6d85;margin-left: 70%"> Automatic LOGOUT after 30 mins of inactivity</span>    <p style="margin-left: 70%">&#169 developed by  <a href="mailto:antonsyzko@gmail.com"> antonsyzko@gmail.com</a></p>

</div>

</body>
</html>
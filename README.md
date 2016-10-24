# doctoradminpanel

<html lang="en">
<head>
    <meta charset="UTF-8">
    
</head>
<body>

<b style="margin-left: 40%">PRIVATE DOCTOR ADMINISTRATION PANEL</b>
<hr />
 Administration tool for private doctor . <br/>
Registering new patients, updating existing patients, deleting existing patients, sending mail notifications, uploading/downloading files, data stored in database <br/>
Security Roles applied ( backed by database ) - ADMIN ( complete control - create/update/delete ),<br/>
DBA ( database admin - limited roles - edition only , buttons for creation or deletion are not available )<br/>
USER ( only observation - no actions can be taken )<br/>
File Uploading - ADMIN / DBA can  upload/download  files ( stored in database )
Registered user  receives the email with all the  info and attached  files
<hr/>
<b style="margin-left: 40%">Getting Started</b><br/>
   <a href="http://antonsyzkodemo.herokuapp.com/login?logout">Private Doctor Administration Panel</a><br/>
use <b>test</b> for username  and <b>test</b> for password<br/>
Click Add new patinet - fill in form <br/>
notification will be sent to new user<br/>
upload / manage files for  new  patient if  needed <br/>
edit existing patient  if needed - download / upload documents<br/>
patients are stored in table ( additional table for each patient's files included )<br/>

<hr/>

<b style="margin-left: 40%">DEMO</b><br/>
<h><a href="http://antonsyzkodemo.herokuapp.com/login?logout">Private Doctor Administration Panel</a></h><br/>


<hr/>

<b style="margin-left: 40%">Techologies used </b><br/>
<span>JAVA EE</span><br/>
<span>Spring MVC</span><br/>
<span>JSP</span><br/>
<span>Hibernate</span><br/>
<span>Spring Security</span><br/>
<span>javax mail</span><br/>
<span>Postgre SQL</span><br/>
<span>Spring ORM</span><br/>
<span>Bootstrap / JQuery / JQuery-JTables</span><br/>


<hr/>

<b style="margin-left: 40%">Contact</b><br/>
@Anton Szyko<br/>
email:<email>antonsyzko@gmail.com</email><br/>
linkedIn : <a href="https://www.linkedin.com/in/anton-syzko-b709ab123">Anton Syzko</a><br/>
<b style="margin-left: 50%">License</b><br/>
<span>MIT</span><br/>
</body>
</html>

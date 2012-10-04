<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>Criar sua própria reunião</title>

	<script type="text/javascript"
		src="js/jquery.min.js"></script>
	
</head>


<head>
    <meta charset="utf-8">
    <title>Criar sua própria reunião</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assets/css/docs.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
  </head>
<body>
<%@ include file="bbb_api.jsp"%>
<%@ include file="demo_header.jsp"%>
<%@ page import="java.util.regex.*"%>
<%
	if (request.getParameterMap().isEmpty()) {
%>
<div class="container-fluid">
	<div class="hero-unit">
		<h2>Criar sua própria reunião</h2>
	</div>
	
<FORM NAME="form1" class="well" METHOD="GET">
	<INPUT TYPE=hidden NAME=action VALUE="create"> 
	<label>Passo 1. Entre com seu Nome</label>
	<input type="text" autofocus required name="username1" /> 
	<div class="form-actions">
		<input id="submit-button" type="submit" value="Criar reunião" class="btn btn-primary"/>
	</div>
</FORM>

<script>
$(document).ready(function(){
    $("input[name='username1']").keyup(function() {
        if ($("input[name='username1']").val() == "") {
        	$("#submit-button").attr('value',"Create meeting" );
        } else {
       $("#submit-button").attr('value',"Criar reunião" +$("input[name='username1']").val());
        }
    });
});
</script>

<%
	} else if (request.getParameter("action").equals("create")) {
		//
		// User has requested to create a meeting
		//

		String username = request.getParameter("username1");
		String meetingID = "Reunião "+username;

		//
		// This is the URL for to join the meeting as moderator
		//
		String joinURL = getJoinURL(username, meetingID, "false", "<br>Bem vindo a conferencia %%CONFNAME%%.<br>", null, null);

		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String inviteURL = url + "create.jsp?action=invite&meetingID=" + URLEncoder.encode(meetingID, "UTF-8");
%>
	<div class="hero-unit">
		<h2>Reunião criada</h2>
	</div>
	<br>
	<div class="row-fluid span12">
		<strong> Reuniao <%=username%>'s </strong> foi criada.
	</div>
	<br>
	<div class="row-fluid span12">
		Passo 2. Envie a outros usuarios usando o <a href="<%=inviteURL%>">link</a> (abaixo):
	</div>
	<br>
	<div class="row-fluid span12">
		<form name="form2" method="POST">
			<textarea cols="300" rows="5" name="myname"><%=inviteURL%></textarea>
		</form>
	</div>
	<br>
	<div class="row-fluid span12">
		Passo 3. Click no link a seguir para iniciar a reunião:
	</div>
	<br>
	<div class="row-fluid span12">
		<a href="<%=joinURL%>" class="btn btn-primary">Iniciar Reunião</a>
	</div>
<%
	} else if (request.getParameter("action").equals("enter")) {
		String meetingID = request.getParameter("meetingID");
		String username = request.getParameter("username");
		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String enterURL = url + "create.jsp?action=join&username="
			+ URLEncoder.encode(username, "UTF-8") + "&meetingID="
			+ URLEncoder.encode(meetingID, "UTF-8");
		if (isMeetingRunning(meetingID).equals("true")) {
%>
<script type="text/javascript">
	window.location = "<%=enterURL%>";
</script>
<%
	} else {
			String checkMeetingStatus = getURLisMeetingRunning(meetingID);
%>

<script type="text/javascript">
$(document).ready(function(){
		$.jheartbeat.set({
		   url: "<%=checkMeetingStatus%>",
		   delay: 5000
		}, function () {
			mycallback();
		});
	});
function mycallback() {
	var isMeetingRunning = ($("#HeartBeatDIV").text().search("true") > 0 );

	if (isMeetingRunning) {
		window.location = "<%=enterURL%>"; 
	}
}
</script>

	<div class="hero-unit">
		<h2><strong><%=meetingID%></strong> não foi iniciada.</h2>
	</div>

<table class="table">
	<tbody>
		<tr>
			<td>
			<p>Ola <%=username%>,</p>
			<p>Aguardando moderador para iniciar a reunião <strong><%=meetingID%></strong>.</p>
			<br />
			<p>(Seu browser será automaticamente recarregado quando for iniciado)</p>
			</td>
			<td width="50%"><img src="polling.gif"></img></td>
		</tr>
	</tbody>
</table>
<%
}
	} else if (request.getParameter("action").equals("invite")) {
		String meetingID = request.getParameter("meetingID");
%>

<div class="hero-unit">
	<h2>Convidar</h2>
</div>

<FORM NAME="form3" class="well" METHOD="GET">
		<INPUT TYPE=hidden NAME=action VALUE="enter">
		<label>Você foi convidado para se juntar <strong><%=meetingID%></strong></label>
		<label>Entre com seu nome</label>
		<input type="text"	name="username" />
		<INPUT TYPE=hidden NAME=meetingID VALUE="<%=meetingID%>"> 
		<div class="form-actions">
		   <input type="submit" value="Entrar" class="btn btn-primary"/>
		</div>
</FORM>

<%
	} else if (request.getParameter("action").equals("join")) {
		String joinURL = getJoinURLViewer(request.getParameter("username"), request.getParameter("meetingID"));
		if (joinURL.startsWith("http://")) {
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} else { 
%>

Erro: getJoinURL() falhou
<p /><%=joinURL%> 

<%
 	}
 }
 %> 

 </div>
<%@ include file="demo_footer.jsp"%>

    <script type="text/javascript" src="<%=request.getContextPath()%>/js/heartbeat.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-transition.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-alert.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-modal.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-dropdown.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-scrollspy.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tab.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tooltip.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-popover.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-button.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-collapse.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-carousel.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-typeahead.js"></script>

</body>
</html>
